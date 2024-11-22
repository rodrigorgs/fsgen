import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_client/template_client.dart';
import 'package:template_flutter/client_provider.dart';

part 'task_repository.g.dart';

class TaskRepository {
  final Client client;

  TaskRepository({required this.client});

  Future<Task?> findById(int id) async {
    final task = await client.task.findById(id);
    return task;
  }

  Future<List<Task>> find() async {
    final task = await client.task.find();
    return task;
  }

  Future<Task> insert(Task task) async {
    return await client.task.insert(task);
  }

  Future<void> update(Task task) async {
    await client.task.update(task);
  }

  Future<void> delete(Task task) async {
    await client.task.delete(task);
  }
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepository(client: ref.watch(clientProvider));
}
