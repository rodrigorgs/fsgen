import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_edit_controller.dart';

class TaskEditPage extends ConsumerStatefulWidget {
  final String? taskId;
  const TaskEditPage({super.key, required this.taskId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends ConsumerState<TaskEditPage> {
  get isNewTask => widget.taskId == null;
  Task? task;

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskEditControllerProvider(widget.taskId));

    if (task == null && taskAsync.hasValue) {
      task = taskAsync.value!.copyWith();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${isNewTask ? "New" : "Edit"} Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: taskAsync.when(
            data: (originalTask) => _buildForm(context),
            error: (error, stackTrace) => Column(
              children: [
                Text('Error: $error'),
                Text('Stack trace: $stackTrace'),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Column _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          autofocus: true,
          controller: TextEditingController(text: task!.title),
          decoration: const InputDecoration(
            labelText: 'Task title',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            task = task!.copyWith(title: value);
          },
        ),
        CheckboxListTile(
          title: const Text('Is completed'),
          value: task!.isCompleted,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            setState(() {
              task = task!.copyWith(isCompleted: value!);
            });
          },
        ),
        const SizedBox(height: 16),
        _buildButtonBar(ref, context),
      ],
    );
  }

  Row _buildButtonBar(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            final notifier =
                ref.read(taskEditControllerProvider(widget.taskId).notifier);
            await notifier.updateState(task!);
            await notifier.save();
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          child: Text(isNewTask ? 'Create' : 'Save'),
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
