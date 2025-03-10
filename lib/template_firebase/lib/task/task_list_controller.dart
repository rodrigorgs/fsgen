import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_firebase/task/task.dart';
import 'package:template_firebase/task/task_repository.dart';

part 'task_list_controller.g.dart';

@riverpod
class TaskListController extends _$TaskListController {
  @override
  Future<List<Task>> build() async {
    return ref.watch(taskRepositoryProvider).find();
  }

  Future<void> delete(Task task) async {
    state = const AsyncValue.loading();
    await ref.read(taskRepositoryProvider).delete(task.id!);
    ref.invalidateSelf();
  }
}
