import 'package:block_flutter/domain/entities/task_entity.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskEntity task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskEntity updatedTask;
  UpdateTask(this.updatedTask);
}

class EditTask extends TaskEvent{
  final String taskEdit;
  EditTask(this.taskEdit);
}

class DeleteTask extends TaskEvent {
  final String taskId;
  DeleteTask(this.taskId);
}

