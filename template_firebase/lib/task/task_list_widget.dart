import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_firebase/task/task_edit_widget.dart';
import 'package:template_firebase/task/task_list_controller.dart';
import 'package:template_firebase/task/task.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  void _onUpdate(WidgetRef ref) {
    ref.read(taskListControllerProvider.notifier).find();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final saved = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TaskEditPage(
                  task: Task(title: '', isCompleted: false),
                ),
              ),
            );
            if (saved != false) {
              _onUpdate(ref);
            }
          },
          child: const Icon(Icons.add),
        ),
        body: taskList.when(
          data: (list) => _buildTaskList(ref, list),
          error: _buildError,
          loading: () => const CircularProgressIndicator(),
        ));
  }

  Widget? _buildError(error, stackTrace) => Center(
        child: Column(
          children: [
            Text('Error: $error'),
            Text('Stack trace: $stackTrace'),
          ],
        ),
      );

  Widget? _buildTaskList(WidgetRef ref, List<Task> list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Task task = list[index];
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                // task.isCompleted = value!;
                task = task.copyWith(isCompleted: value!);
                ref
                    .read(taskListControllerProvider.notifier)
                    .insertOrUpdate(task);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // create dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ref
                              .read(taskListControllerProvider.notifier)
                              .delete(task);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskEditPage(task: task),
                ),
              );
            },
          );
        },
      );
}
