import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_repository.dart';

part 'task_list_controller.g.dart';

@riverpod
class TaskListController extends _$TaskListController {
  @override
  Future<List<Task>> build() async {
    return ref.read(taskRepositoryProvider).find();
  }

  Future<void> find() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(ref.read(taskRepositoryProvider).find);
  }

  Future<void> delete(Task task) async {
    final taskRepository = ref.read(taskRepositoryProvider);
    state = const AsyncValue.loading();
    await taskRepository.delete(task.id!);
    state = await AsyncValue.guard(taskRepository.find);
  }
}
