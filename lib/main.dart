import 'package:church_tool/app/church_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // Ensure that flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: ChurchTool(),
    ),
  );
}
