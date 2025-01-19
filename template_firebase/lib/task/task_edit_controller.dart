import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_repository.dart';

part 'task_edit_controller.g.dart';

@riverpod
class TaskEditController extends _$TaskEditController {
  @override
  Future<Task> build(String? taskId) async {
    if (taskId == null) {
      return Future.value(Task.empty());
    } else {
      final task = await ref.read(taskRepositoryProvider).findById(taskId);
      if (task == null) {
        throw Exception('Task not found');
      }
      return task;
    }
  }

  Future<void> updateState(Task task) async {
    state = AsyncValue.data(task);
  }

  Future<void> save() async {
    Task task = state.value!;
    final taskRepository = ref.read(taskRepositoryProvider);
    state = const AsyncValue.loading();
    if (task.id == null) {
      task = await taskRepository.insert(task);
    } else {
      await taskRepository.update(task.id!, task);
    }
    state = await AsyncValue.guard(() => Future.value(task));
  }
}
