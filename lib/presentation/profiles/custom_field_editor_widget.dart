// Custom field editor widget — embedded in ProfileEditScreen.
//
// Lists existing custom fields for a profile and allows add/edit/delete.
// Uses customFieldUseCaseProvider for all mutations.
// Uses customFieldRepositoryProvider.getActiveForProfile() to load fields
// (the repository interface has no stream — we reload on each mutation).
//
// Requirements: PROF-07 (add field), PROF-08 (edit/delete field)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/tables/custom_fields_table.dart';
import '../../domain/models/custom_field.dart';
import '../../providers/database_provider.dart';
import '../../providers/profile_providers.dart';

/// Embedded widget for managing custom fields on a profile.
///
/// Shows the list of existing custom fields with edit/delete actions.
/// "Add field" button opens a bottom sheet for adding a new field.
/// All mutations go through [CustomFieldUseCase] via [customFieldUseCaseProvider].
class CustomFieldEditorWidget extends ConsumerStatefulWidget {
  const CustomFieldEditorWidget({
    super.key,
    required this.profileId,
  });

  final String profileId;

  @override
  ConsumerState<CustomFieldEditorWidget> createState() =>
      _CustomFieldEditorWidgetState();
}

class _CustomFieldEditorWidgetState
    extends ConsumerState<CustomFieldEditorWidget> {
  // Local list rebuilt after each mutation.
  List<CustomField> _fields = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  // ── Load ───────────────────────────────────────────────────────────────────

  Future<void> _loadFields() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final repo = await ref.read(customFieldRepositoryProvider.future);
      final fields = await repo.getActiveForProfile(widget.profileId);
      if (mounted) {
        setState(() {
          _fields = fields;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  // ── Delete ─────────────────────────────────────────────────────────────────

  Future<void> _deleteField(String fieldId) async {
    try {
      final useCase = await ref.read(customFieldUseCaseProvider.future);
      await useCase.deleteField(fieldId);
      await _loadFields();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete field: $e')),
        );
      }
    }
  }

  // ── Add / Edit bottom sheet ────────────────────────────────────────────────

  Future<void> _showFieldSheet({CustomField? existing}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _FieldSheet(
        profileId: widget.profileId,
        existing: existing,
      ),
    );
    // Reload after sheet closes (regardless of whether user saved or cancelled)
    await _loadFields();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Custom Fields',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          )
        else if (_error != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Error: $_error'),
          )
        else ...[
          ..._fields.map((field) => _FieldRow(
                field: field,
                onEdit: () => _showFieldSheet(existing: field),
                onDelete: () => _deleteField(field.id),
              )),
        ],
        TextButton.icon(
          onPressed: () => _showFieldSheet(),
          icon: const Icon(Icons.add),
          label: const Text('Add field'),
        ),
      ],
    );
  }
}

// ── Internal: single field row ─────────────────────────────────────────────

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.field,
    required this.onEdit,
    required this.onDelete,
  });

  final CustomField field;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  static String _typeBadge(CustomFieldType type) {
    switch (type) {
      case CustomFieldType.text:
        return 'Text';
      case CustomFieldType.number:
        return 'Number';
      case CustomFieldType.date:
        return 'Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(field.label),
      subtitle: field.value != null ? Text(field.value!) : null,
      leading: Chip(
        label: Text(
          _typeBadge(field.fieldType),
          style: const TextStyle(fontSize: 11),
        ),
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit field',
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete field',
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

// ── Internal: add / edit bottom sheet ────────────────────────────────────────

class _FieldSheet extends ConsumerStatefulWidget {
  const _FieldSheet({
    required this.profileId,
    this.existing,
  });

  final String profileId;
  final CustomField? existing;

  @override
  ConsumerState<_FieldSheet> createState() => _FieldSheetState();
}

class _FieldSheetState extends ConsumerState<_FieldSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelCtrl;
  late final TextEditingController _valueCtrl;
  late CustomFieldType _selectedType;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _labelCtrl =
        TextEditingController(text: widget.existing?.label ?? '');
    _valueCtrl =
        TextEditingController(text: widget.existing?.value ?? '');
    _selectedType = widget.existing?.fieldType ?? CustomFieldType.text;
  }

  @override
  void dispose() {
    _labelCtrl.dispose();
    _valueCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final useCase = await ref.read(customFieldUseCaseProvider.future);
      if (widget.existing == null) {
        await useCase.addField(
          widget.profileId,
          _labelCtrl.text.trim(),
          _selectedType,
        );
      } else {
        await useCase.editField(
          widget.existing!.id,
          profileId: widget.profileId,
          label: _labelCtrl.text.trim(),
          fieldType: _selectedType,
          value: _valueCtrl.text.isEmpty ? null : _valueCtrl.text.trim(),
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save field: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEdit ? 'Edit Field' : 'Add Field',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _labelCtrl,
              decoration: const InputDecoration(
                labelText: 'Label',
                hintText: 'e.g. Passport number',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Label is required' : null,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<CustomFieldType>(
              value: _selectedType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: const [
                DropdownMenuItem(
                    value: CustomFieldType.text, child: Text('Text')),
                DropdownMenuItem(
                    value: CustomFieldType.number, child: Text('Number')),
                DropdownMenuItem(
                    value: CustomFieldType.date, child: Text('Date')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _selectedType = v);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _valueCtrl,
              decoration: const InputDecoration(
                labelText: 'Value (optional)',
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(isEdit ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
