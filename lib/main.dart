import 'package:flutter/material.dart';

void main() {
  runApp(const AutofillApp());
}

class AutofillApp extends StatelessWidget {
  const AutofillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Family Autofill',
      home: Scaffold(
        body: Center(child: Text('Family Autofill')),
      ),
    );
  }
}
