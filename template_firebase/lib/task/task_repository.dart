import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_firebase/firebase.dart';
import 'package:template_firebase/task/task.dart';

part 'task_repository.g.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;

  TaskRepository(this._firestore);

  Future<Task?> findById(int id) async {
    final snapshot =
        await _firestore.collection('tasks').doc(id.toString()).get();
    return Task.fromFirestore(snapshot);
  }

  Future<List<Task>> find() async {
    final snapshot = await _firestore.collection('tasks').get();
    return snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
  }

  Future<Task> insert(Task task) async {
    final docRef = await _firestore.collection('tasks').add(task.toJson());
    return task.copyWith(id: docRef.id);
  }

  Future<void> update(String id, Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toJson());
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
