// App entry point.
//
// ProviderScope wraps the entire widget tree so all Riverpod providers
// are available to every descendant.
//
// WidgetsFlutterBinding.ensureInitialized() is called before runApp to
// guarantee platform channel readiness (required by local_auth, path_provider,
// and drift before any async plugin call).
//
// SQLCipher is initialized via open.overrideFor so that drift's
// NativeDatabase uses the encrypted sqlite library.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SQLCipher native library so PRAGMA key encryption works.
  if (Platform.isAndroid) {
    open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  }

  runApp(const ProviderScope(child: AutofillApp()));
}
