// Profile edit/create screen.
//
// Handles both create (profileId == null) and edit (profileId != null).
// On create, builds a ProfileCreateRequest and calls profileUseCase.createProfile().
// On edit, loads the existing profile and calls profileUseCase.updateProfile().
//
// ProfileLimitReached is caught and navigates to PaywallStubScreen.
//
// Avatar: ImagePicker.pickImage() → compressed to 512×512/85% → saved to
// ${documentsDir}/avatars/${uuid}.jpg → path stored on profile.
//
// Requirements: PROF-01, PROF-02, PROF-04 (avatar), PROF-05, PROF-06 (paywall)

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/tables/profiles_table.dart';
import '../../domain/models/profile.dart';
import '../../domain/use_cases/profile_use_case.dart';
import '../../providers/database_provider.dart';
import '../../providers/profile_providers.dart' show profileUseCaseProvider;
import '../paywall/paywall_stub_screen.dart';
import 'custom_field_editor_widget.dart';

/// Profile create/edit form screen.
///
/// Pass [profileId] = null to create a new profile.
/// Pass [profileId] = existing profile id to edit.
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({
    super.key,
    required this.profileId,
  });

  final String? profileId;

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  // ── Form controllers ────────────────────────────────────────────────────────
  final _displayNameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _addr1Ctrl = TextEditingController();
  final _addr2Ctrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _allergiesCtrl = TextEditingController();
  final _emergNameCtrl = TextEditingController();
  final _emergPhoneCtrl = TextEditingController();

  RelationshipTag _relationshipTag = RelationshipTag.parent;
  String? _avatarPath; // local file path; null until user picks one

  // State flags
  bool _loading = true;
  bool _saving = false;
  FamilyProfile? _existingProfile;

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    if (widget.profileId != null) {
      _loadExistingProfile();
    } else {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _displayNameCtrl.dispose();
    _dobCtrl.dispose();
    _addr1Ctrl.dispose();
    _addr2Ctrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _postalCtrl.dispose();
    _countryCtrl.dispose();
    _phoneCtrl.dispose();
    _allergiesCtrl.dispose();
    _emergNameCtrl.dispose();
    _emergPhoneCtrl.dispose();
    super.dispose();
  }

  // ── Load existing profile ──────────────────────────────────────────────────

  Future<void> _loadExistingProfile() async {
    try {
      // Load the profile directly via repository getById.
      final repo = await ref.read(profileRepositoryProvider.future);
      final profile = await repo.getById(widget.profileId!);

      if (profile != null) {
        _existingProfile = profile;
        _displayNameCtrl.text = profile.displayName;
        _dobCtrl.text = profile.dateOfBirth ?? '';
        _addr1Ctrl.text = profile.addressLine1 ?? '';
        _addr2Ctrl.text = profile.addressLine2 ?? '';
        _cityCtrl.text = profile.city ?? '';
        _stateCtrl.text = profile.stateProvince ?? '';
        _postalCtrl.text = profile.postalCode ?? '';
        _countryCtrl.text = profile.country ?? '';
        _phoneCtrl.text = profile.phone ?? '';
        _allergiesCtrl.text = profile.allergies ?? '';
        _emergNameCtrl.text = profile.emergencyContactName ?? '';
        _emergPhoneCtrl.text = profile.emergencyContactPhone ?? '';
        _relationshipTag = profile.relationshipTag;
        _avatarPath = profile.avatarPath;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── Avatar picker ──────────────────────────────────────────────────────────

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return;

    // Save compressed file to documents/avatars/{uuid}.jpg
    final docsDir = await getApplicationDocumentsDirectory();
    final avatarsDir = Directory(p.join(docsDir.path, 'avatars'));
    if (!avatarsDir.existsSync()) {
      avatarsDir.createSync(recursive: true);
    }
    final fileName = '${const Uuid().v4()}.jpg';
    final destPath = p.join(avatarsDir.path, fileName);
    await File(picked.path).copy(destPath);

    if (mounted) {
      setState(() => _avatarPath = destPath);
    }
  }

  // ── Avatar preview ─────────────────────────────────────────────────────────

  Widget _buildAvatarPicker() {
    final hasAvatar = _avatarPath != null && _avatarPath!.isNotEmpty;
    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: hasAvatar ? FileImage(File(_avatarPath!)) : null,
          child: hasAvatar
              ? null
              : const Icon(Icons.person_outline, size: 36),
        ),
        const SizedBox(width: 16),
        TextButton.icon(
          onPressed: _pickAvatar,
          icon: const Icon(Icons.photo_library_outlined),
          label: const Text('Pick photo'),
        ),
      ],
    );
  }

  // ── Date picker helper ─────────────────────────────────────────────────────

  Future<void> _pickDate() async {
    final initial = _dobCtrl.text.isNotEmpty
        ? DateTime.tryParse(_dobCtrl.text) ?? DateTime.now()
        : DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      _dobCtrl.text =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  // ── Save ───────────────────────────────────────────────────────────────────

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final useCase = await ref.read(profileUseCaseProvider.future);
      final nullable = (String s) => s.trim().isEmpty ? null : s.trim();

      if (widget.profileId == null) {
        // Create new profile
        final request = ProfileCreateRequest(
          displayName: _displayNameCtrl.text.trim(),
          dateOfBirth: nullable(_dobCtrl.text),
          addressLine1: nullable(_addr1Ctrl.text),
          addressLine2: nullable(_addr2Ctrl.text),
          city: nullable(_cityCtrl.text),
          stateProvince: nullable(_stateCtrl.text),
          postalCode: nullable(_postalCtrl.text),
          country: nullable(_countryCtrl.text),
          phone: nullable(_phoneCtrl.text),
          allergies: nullable(_allergiesCtrl.text),
          emergencyContactName: nullable(_emergNameCtrl.text),
          emergencyContactPhone: nullable(_emergPhoneCtrl.text),
          relationshipTag: _relationshipTag,
          avatarPath: _avatarPath,
        );
        await useCase.createProfile(request);
      } else {
        // Update existing profile
        final request = ProfileUpdateRequest(
          id: widget.profileId!,
          displayName: _displayNameCtrl.text.trim(),
          dateOfBirth: nullable(_dobCtrl.text),
          addressLine1: nullable(_addr1Ctrl.text),
          addressLine2: nullable(_addr2Ctrl.text),
          city: nullable(_cityCtrl.text),
          stateProvince: nullable(_stateCtrl.text),
          postalCode: nullable(_postalCtrl.text),
          country: nullable(_countryCtrl.text),
          phone: nullable(_phoneCtrl.text),
          allergies: nullable(_allergiesCtrl.text),
          emergencyContactName: nullable(_emergNameCtrl.text),
          emergencyContactPhone: nullable(_emergPhoneCtrl.text),
          relationshipTag: _relationshipTag,
          avatarPath: _avatarPath,
        );
        await useCase.updateProfile(widget.profileId!, request);
      }

      if (mounted) Navigator.of(context).pop();
    } on ProfileLimitReached {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PaywallStubScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isCreate = widget.profileId == null;
    final title = isCreate ? 'New Profile' : 'Edit Profile';

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Avatar ────────────────────────────────────────────────────────
            _buildAvatarPicker(),
            const SizedBox(height: 20),

            // ── Display name ──────────────────────────────────────────────────
            TextFormField(
              controller: _displayNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: 'e.g. Jane Smith',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),

            // ── Relationship tag ──────────────────────────────────────────────
            DropdownButtonFormField<RelationshipTag>(
              value: _relationshipTag,
              decoration: const InputDecoration(labelText: 'Relationship'),
              items: const [
                DropdownMenuItem(
                  value: RelationshipTag.parent,
                  child: Text('Parent'),
                ),
                DropdownMenuItem(
                  value: RelationshipTag.child,
                  child: Text('Child'),
                ),
                DropdownMenuItem(
                  value: RelationshipTag.guardian,
                  child: Text('Guardian'),
                ),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _relationshipTag = v);
              },
            ),
            const SizedBox(height: 12),

            // ── Date of birth ─────────────────────────────────────────────────
            TextFormField(
              controller: _dobCtrl,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'YYYY-MM-DD',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: _pickDate,
                ),
              ),
              readOnly: false,
              onTap: _pickDate,
            ),
            const SizedBox(height: 20),

            // ── Address section ───────────────────────────────────────────────
            Text('Address', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addr1Ctrl,
              decoration: const InputDecoration(labelText: 'Address line 1'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addr2Ctrl,
              decoration: const InputDecoration(labelText: 'Address line 2'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cityCtrl,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _stateCtrl,
                    decoration:
                        const InputDecoration(labelText: 'State/Province'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _postalCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Postal code'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _countryCtrl,
                    decoration: const InputDecoration(labelText: 'Country'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Contact ───────────────────────────────────────────────────────
            Text('Contact', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            // ── Medical ───────────────────────────────────────────────────────
            Text('Medical', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _allergiesCtrl,
              decoration: const InputDecoration(
                labelText: 'Allergies',
                hintText: 'e.g. peanuts, penicillin',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // ── Emergency contact ─────────────────────────────────────────────
            Text('Emergency Contact',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emergNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Emergency contact name',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emergPhoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Emergency contact phone',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),

            // ── Custom fields (edit mode only) ────────────────────────────────
            if (widget.profileId != null) ...[
              const Divider(),
              const SizedBox(height: 8),
              CustomFieldEditorWidget(profileId: widget.profileId!),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
