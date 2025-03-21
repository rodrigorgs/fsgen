import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_client/template_client.dart';
import 'package:template_flutter/task/task_service.dart';

part 'task_edit_viewmodel.g.dart';

@riverpod
class TaskEditController extends _$TaskEditController {
  @override
  Future<Task> build(Task task) async {
    return task;
  }

  Future<void> insertOrUpdate() async {
    Task task = state.value!;
    final taskService = ref.read(taskServiceProvider);
    state = const AsyncValue.loading();
    if (task.id == null) {
      task = await taskService.insert(task);
    } else {
      await taskService.update(task);
    }
    state = await AsyncValue.guard(() => Future.value(task));
  }
}
