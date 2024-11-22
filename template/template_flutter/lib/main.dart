import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/task/task_list_widget.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MaterialApp(
        home: TaskListPage(),
      ),
    ),
  );
}
