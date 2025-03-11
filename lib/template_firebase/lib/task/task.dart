import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
sealed class Task with _$Task {
  const factory Task({
    String? id,
    required String title,
    @Default(false) bool isCompleted,
  }) = _Task;

  factory Task.empty() => const Task(
        id: null,
        title: '',
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task.fromJson(data).copyWith(id: doc.id);
  }
}
