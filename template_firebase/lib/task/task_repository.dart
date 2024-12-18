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
    return Task.fromDocument(snapshot);
  }

  Stream<List<Task>> find() {
    return _firestore.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
    });
  }

  Future<Task> insert(Task task) async {
    final docRef = await _firestore.collection('tasks').add(task.toMap());
    return task.copyWith(id: docRef.id);
  }

  Future<void> update(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());
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
