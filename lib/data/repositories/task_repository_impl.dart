// import 'package:block_flutter/data/models/task_model.dart';
// import 'package:block_flutter/domain/entities/task_entity.dart';
// import '../../domain/repositories/task_repository.dart';
// import '../datasources/task_local_data_source.dart';
//
// class TaskRepositoryImpl implements TaskRepository {
//   final TaskLocalDataSource localDataSource;
//   TaskRepositoryImpl({required this.localDataSource});
//
//   @override
//   Future<List<TaskEntity>> getTasks() => localDataSource.getTasks();
//
//   @override
//   Future<void> addTask(TaskEntity task) => localDataSource.addTask(task as TaskModel);
//
//   @override
//   Future<void> updateTask(TaskEntity task) => localDataSource.updateTask(task as TaskModel);
//
//   @override
//   Future<void> deleteTask(String taskId) => localDataSource.deleteTask(taskId);
//
//   @override
//   Future<void> addReview(String taskId, String review) => localDataSource.updateTaskReview(taskId, review);
// }
//
//
import 'package:sqflite/sqflite.dart';
import 'package:block_flutter/data/models/task_model.dart';
import 'package:block_flutter/domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';




class TaskRepositoryImpl implements TaskRepository {

  final TaskLocalDataSource localDataSource;
  TaskRepositoryImpl({required this.localDataSource});


  @override
  Future<List<TaskEntity>> getTasks() => localDataSource.getTasks();

  @override
  Future<void> addTask(TaskEntity task) {
    // Convert TaskEntity to TaskModel before storing
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
      review: task.review
    );
    return localDataSource.addTask(taskModel);
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    // Convert TaskEntity to TaskModel before updating
    final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        isCompleted: task.isCompleted,
        review: task.review
    );
    return localDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String taskId) => localDataSource.deleteTask(taskId);

  @override
  Future<void> addReview(String taskId, String review) => localDataSource.updateTaskReview(taskId, review);

  @override
  Future<void> editTask(TaskEntity task) async {
    final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        isCompleted: task.isCompleted,
        review: task.review
    );
    return localDataSource.editTask(taskModel);
  }
}
