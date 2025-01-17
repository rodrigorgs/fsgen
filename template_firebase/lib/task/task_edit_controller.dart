import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_repository.dart';

part 'task_edit_controller.g.dart';

@riverpod
class TaskEditController extends _$TaskEditController {
  @override
  Future<Task> build(Task task) async {
    return task;
  }

  Future<void> insertOrUpdate() async {
    Task task = state.value!;
    final taskRepository = ref.read(taskRepositoryProvider);
    state = const AsyncValue.loading();
    if (task.id == null) {
      task = await taskRepository.insert(task);
      // TODO: get task with id
    } else {
      await taskRepository.update(task.id!, task);
    }
    state = await AsyncValue.guard(() => Future.value(task));
  }
}
