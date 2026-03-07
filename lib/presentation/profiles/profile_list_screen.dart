// Profile list screen — displays all active family profiles.
//
// Watches profileListProvider for a reactive stream of profiles.
// FAB navigates to ProfileEditScreen for creation.
// Swipe-to-dismiss or delete icon shows an AlertDialog before calling
// deleteProfile() — PROF-03 requirement.
//
// Requirements: PROF-01 (list), PROF-02 (create), PROF-03 (delete with confirm)
// PROF-05 (avatar in card), PROF-06 (paywall stub on limit)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/profile_use_case.dart';
import '../../providers/profile_providers.dart';
import 'profile_card_widget.dart';
import 'profile_edit_screen.dart';

/// Reactive list of all active family profiles.
///
/// Built as a [ConsumerWidget] so it rebuilds when [profileListProvider]
/// emits a new list (insert, update, soft-delete events).
class ProfileListScreen extends ConsumerWidget {
  const ProfileListScreen({super.key});

  // ── Delete flow ────────────────────────────────────────────────────────────

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String profileId,
    String displayName,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Profile'),
        content: Text(
          'Delete "$displayName"? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final useCase = await ref.read(profileUseCaseProvider.future);
        await useCase.deleteProfile(profileId);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete profile: $e')),
          );
        }
      }
    }
  }

  // ── Navigate to edit/create ────────────────────────────────────────────────

  void _navigateToCreate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProfileEditScreen(profileId: null),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(profileListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Profiles'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreate(context),
        tooltip: 'Add profile',
        child: const Icon(Icons.add),
      ),
      body: profilesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error loading profiles: $error')),
              );
            }
          });
          return const Center(
            child: Text('Unable to load profiles. Please try again.'),
          );
        },
        data: (profiles) {
          if (profiles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Add your first family member',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Sort profiles by displayName (case-insensitive)
          final sorted = [...profiles]
            ..sort((a, b) => a.displayName
                .toLowerCase()
                .compareTo(b.displayName.toLowerCase()));

          return ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final profile = sorted[index];
              return Dismissible(
                key: ValueKey(profile.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete Profile'),
                      content: Text(
                        'Delete "${profile.displayName}"? This cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(ctx).colorScheme.error,
                          ),
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  return confirmed == true;
                },
                onDismissed: (_) async {
                  try {
                    final useCase =
                        await ref.read(profileUseCaseProvider.future);
                    await useCase.deleteProfile(profile.id);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to delete profile: $e'),
                        ),
                      );
                    }
                  }
                },
                child: ProfileCardWidget(
                  profile: profile,
                  onDelete: () => _confirmDelete(
                    context,
                    ref,
                    profile.id,
                    profile.displayName,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
