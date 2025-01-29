import 'package:block_flutter/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
  Future<void> addReview(String taskId, String review);
  Future<void> editTask(TaskEntity task);
}