import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_firebase/firestore_provider.dart';
import 'package:template_firebase/task/task.dart';

part 'task_repository.g.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;

  TaskRepository(this._firestore);

  Future<Task?> findById(String id) async {
    final snapshot = await _firestore.collection('tasks').doc(id).get();
    if (!snapshot.exists) {
      return null;
    }
    return Task.fromDocument(snapshot);
  }

  Future<List<Task>> find() async {
    final snapshot = await _firestore.collection('tasks').get();
    return snapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
  }

  Future<Task> insert(Task task) async {
    final taskData = task.toJson()..remove('id');
    final docRef = await _firestore.collection('tasks').add(taskData);
    return task.copyWith(id: docRef.id);
  }

  Future<void> update(String id, Task task) async {
    final taskData = task.toJson()..remove('id');
    await _firestore.collection('tasks').doc(task.id).update(taskData);
  }

  Future<void> delete(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }
}

@riverpod
TaskRepository taskRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return TaskRepository(firestore);
}
