import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_client/template_client.dart';
import 'package:template_flutter/task/task_service.dart';

part 'task_list_controller.g.dart';

@riverpod
class TaskListController extends _$TaskListController {
  @override
  Future<List<Task>> build() async {
    return ref.read(taskServiceProvider).find();
  }

  Future<void> find() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(ref.read(taskServiceProvider).find);
  }

  Future<void> insertOrUpdate(Task task) async {
    final taskService = ref.read(taskServiceProvider);
    state = const AsyncValue.loading();
    if (task.id == null) {
      await taskService.insert(task);
    } else {
      await taskService.update(task);
    }
    state = await AsyncValue.guard(taskService.find);
  }

  Future<void> delete(Task task) async {
    final taskService = ref.read(taskServiceProvider);
    state = const AsyncValue.loading();
    await taskService.delete(task);
    state = await AsyncValue.guard(taskService.find);
  }
}
