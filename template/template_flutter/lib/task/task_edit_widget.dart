import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_client/template_client.dart';
import 'package:template_flutter/task/task_edit_viewmodel.dart';

class TaskEditPage extends ConsumerWidget {
  final Task task;

  const TaskEditPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: task.name),
              decoration: InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                task.name = value;
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: task.description),
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                task.description = value;
              },
            ),
            SizedBox(height: 16),
            _buildButtonBar(ref, context),
          ],
        ),
      ),
    );
  }

  Row _buildButtonBar(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await ref
                .read(TaskEditControllerProvider(task).notifier)
                .insertOrUpdate();
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          child: Text(task.id == null ? 'Create' : 'Save'),
        ),
        SizedBox(width: 16),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel')),
      ],
    );
  }
}
