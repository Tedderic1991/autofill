// Profile card widget — shows avatar, name, relationship tag, and DOB.
//
// Used in ProfileListScreen's ListView.builder. Tap navigates to
// ProfileEditScreen. Does NOT load custom fields (edit-screen only).
//
// Requirements: PROF-01 (profile display), PROF-05 (avatar display)

import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/database/tables/profiles_table.dart';
import '../../domain/models/profile.dart';

/// Stateless card widget displaying a single [FamilyProfile].
///
/// [onDelete] is invoked after the parent has shown a confirmation dialog —
/// this widget is purely presentational and does NOT call deleteProfile().
class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.profile,
    required this.onDelete,
  });

  final FamilyProfile profile;
  final VoidCallback onDelete;

  // ── Relationship tag styling ───────────────────────────────────────────────

  static const Map<RelationshipTag, Color> _tagColors = {
    RelationshipTag.parent: Color(0xFF1565C0), // blue-800
    RelationshipTag.child: Color(0xFF2E7D32), // green-800
    RelationshipTag.guardian: Color(0xFF6A1B9A), // purple-800
  };

  static const Map<RelationshipTag, String> _tagLabels = {
    RelationshipTag.parent: 'Parent',
    RelationshipTag.child: 'Child',
    RelationshipTag.guardian: 'Guardian',
  };

  // ── Avatar builder ─────────────────────────────────────────────────────────

  Widget _buildAvatar(BuildContext context) {
    final path = profile.avatarPath;
    if (path != null && path.isNotEmpty) {
      final file = File(path);
      if (file.existsSync()) {
        return CircleAvatar(
          radius: 24,
          backgroundImage: FileImage(file),
        );
      }
    }
    // Initials fallback
    final initials = profile.displayName.isNotEmpty
        ? profile.displayName.trim().split(' ').map((w) => w[0]).take(2).join()
        : '?';
    return CircleAvatar(
      radius: 24,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        initials.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tagColor =
        _tagColors[profile.relationshipTag] ?? Colors.grey.shade700;
    final tagLabel = _tagLabels[profile.relationshipTag] ?? 'Unknown';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).pushNamed(
          '/profiles/${profile.id}/edit',
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildAvatar(context),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            tagLabel,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          backgroundColor: tagColor,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        if (profile.dateOfBirth != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            profile.dateOfBirth!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete profile',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
