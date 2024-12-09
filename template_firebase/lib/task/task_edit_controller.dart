import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_service.dart';

part 'task_edit_controller.g.dart';

@riverpod
class TaskEditController extends _$TaskEditController {
  @override
  Future<Task> build(Task task) async {
    print('build task');
    print(task.toMap());
    return task;
  }

  Future<void> insertOrUpdate() async {
    // print('state.value');
    // print(state.value?.toMap());
    Task task = state.value!;
    final taskService = ref.read(taskServiceProvider);
    state = const AsyncValue.loading();
    if (task.id == null) {
      task = await taskService.insert(task);
      // TODO: get task with id
    } else {
      await taskService.update(task);
    }
    state = await AsyncValue.guard(() => Future.value(task));
  }
}
