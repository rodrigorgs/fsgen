import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_supabase/task/task_edit_page.dart';
import 'package:template_supabase/task/task_list_viewmodel.dart';
import 'package:template_supabase/task/task.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  void _onUpdate(WidgetRef ref) {
    ref.invalidate(taskListViewModelProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final saved = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TaskEditPage(
                taskId: null,
              ),
            ),
          );
          if (saved == true) {
            _onUpdate(ref);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: taskList.when(
          data: (list) => _buildTaskList(ref, list),
          error: _buildError,
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget? _buildError(error, stackTrace) => Center(
        child: Column(
          children: [
            Text('Error: $error'),
            Text('Stack trace: $stackTrace'),
          ],
        ),
      );

  Widget? _buildTaskList(WidgetRef ref, List<Task> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text('No tasks found'),
      );
    } else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Task task = list[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.isCompleted ? 'Completed' : 'Not completed'),
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
                              .read(taskListViewModelProvider.notifier)
                              .delete(task);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
            onTap: () async {
              final saved = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskEditPage(taskId: task.id),
                ),
              );
              if (saved == true) {
                _onUpdate(ref);
              }
            },
          );
        },
      );
    }
  }
}
