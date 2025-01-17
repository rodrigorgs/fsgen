import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_edit_controller.dart';
import 'package:template_firebase/task/task_list_controller.dart';

// TODO: convert to stateful
class TaskEditPage extends ConsumerWidget {
  Task task;

  TaskEditPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: task.title),
              decoration: const InputDecoration(
                labelText: 'Task title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                task = task.copyWith(title: value);
              },
            ),
            const SizedBox(height: 16),
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
            // await ref
            //     .read(TaskEditControllerProvider(task).notifier)
            //     .insertOrUpdate();
            await ref
                .read(taskListControllerProvider.notifier)
                .insertOrUpdate(task);
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          child: Text(task.id == null ? 'Create' : 'Save'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel')),
      ],
    );
  }
}
