import 'package:block_flutter/domain/entities/task_entity.dart';

abstract class TaskState {
  final String message;
  const TaskState({this.message = ""});
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  const TaskLoaded(this.tasks, {String message = ""}) : super(message: message);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
