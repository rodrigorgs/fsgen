import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_firebase/task/task.dart';

import 'task_repository.dart';

part 'task_service.g.dart';

class TaskService {
  final TaskRepository taskRepository;

  TaskService({required this.taskRepository});

  Future<Task?> findById(int id) async {
    final task = await taskRepository.findById(id);
    return task;
  }

  Future<List<Task>> find() async {
    final task = await taskRepository.find();
    return await task.first;
  }

  // TODO: Future<Task>
  Future<Task> insert(Task task) async {
    return await taskRepository.insert(task);
  }

  Future<void> update(Task task) async {
    await taskRepository.update(task);
  }

  Future<void> delete(Task task) async {
    if (task.id != null) {
      await taskRepository.delete(task.id!);
    }
  }
}

@Riverpod(keepAlive: true)
TaskService taskService(Ref ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskService(taskRepository: repository);
}
