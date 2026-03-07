// Profile edit/create screen — stub for Task 1 compile.
// Full implementation added in Task 2.

import 'package:flutter/material.dart';

/// Stub — replaced with full implementation in Task 2.
class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key, required this.profileId});

  final String? profileId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(profileId == null ? 'New Profile' : 'Edit Profile')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
