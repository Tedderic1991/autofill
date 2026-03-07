// App entry point.
//
// ProviderScope wraps the entire widget tree so all Riverpod providers
// are available to every descendant.
//
// WidgetsFlutterBinding.ensureInitialized() is called before runApp to
// guarantee platform channel readiness (required by local_auth, path_provider,
// and drift_flutter before any async plugin call).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AutofillApp()));
}
