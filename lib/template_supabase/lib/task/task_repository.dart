import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template_supabase/supabase_provider.dart';
import 'package:template_supabase/task/task.dart';

part 'task_repository.g.dart';

class TaskRepository {
  final SupabaseClient _supabase;

  TaskRepository(this._supabase);

  Future<Task?> findById(int id) async {
    final results = await _supabase.from('tasks').select().eq('id', id);
    if (results.isEmpty) {
      return Future.value(null);
    }
    return Task.fromDocument(results.first);
  }

  Future<List<Task>> find() async {
    final results = await _supabase.from('tasks').select();
    return results.map((doc) => Task.fromDocument(doc)).toList();
  }

  Future<Task> insert(Task task) async {
    final taskData = task.toJson()..remove('id');
    final results = await _supabase.from('tasks').insert(taskData).select();
    return Task.fromDocument(results.first);
  }

  Future<void> update(int id, Task task) async {
    final taskData = task.toJson()..remove('id');
    await _supabase.from('tasks').update(taskData).eq('id', id);
  }

  Future<void> delete(int id) async {
    await _supabase.from('tasks').delete().eq('id', id);
  }
}

@riverpod
TaskRepository taskRepository(Ref ref) {
  final supabase = ref.watch(supabaseProvider);
  return TaskRepository(supabase);
}
