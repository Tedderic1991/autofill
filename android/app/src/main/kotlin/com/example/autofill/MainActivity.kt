package com.example.autofill

// FlutterFragmentActivity is required for local_auth to work correctly.
// FlutterActivity (the Flutter default) does not extend FragmentActivity,
// which is required by the Android BiometricPrompt API used by local_auth v3.
// See: https://pub.dev/packages/local_auth — Android integration section
// Pitfall #3 from 01-RESEARCH.md: changing this after first release requires
// a force-stop on device; always set from project creation.
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity()
