// ignore_for_file: library_private_types_in_public_api

import 'package:flamestudio/ui/flame_studio_editor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlameStudioApp());
}

class FlameStudioApp extends StatelessWidget {
  const FlameStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Studio',
      theme: ThemeData.dark(),
      home: const FlameStudioEditor(),
    );
  }
}
