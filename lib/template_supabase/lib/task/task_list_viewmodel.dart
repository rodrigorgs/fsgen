import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template_supabase/task/task.dart';
import 'package:template_supabase/task/task_repository.dart';

part 'task_list_viewmodel.g.dart';

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
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
