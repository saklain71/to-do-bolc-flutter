


import 'package:block_flutter/domain/entities/task_entity.dart';
import 'package:block_flutter/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<TaskEntity>> call() async {
    return await repository.getTasks();
  }
}

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(TaskEntity task) async {
    await repository.addTask(task);
  }
}

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(TaskEntity updatedTask) async {
    await repository.updateTask(updatedTask);
  }
}

class EditTaskUseCase{
  final TaskRepository repository;
  EditTaskUseCase(this.repository);
  Future<void> call(TaskEntity editTask)async {
    repository.editTask(editTask);
  }
}

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call(String taskId) async {
    await repository.deleteTask(taskId);
  }
}



/*// import '../entities/task_entity.dart';
// import '../repositories/task_repository.dart';
//
// class GetTasksUseCase {
//   final TaskRepository repository;
//   GetTasksUseCase(this.repository);
//   Future<List<TaskEntity>> call() => repository.getTasks();
// }
//
// class AddTaskUseCase {
//   final TaskRepository repository;
//   AddTaskUseCase(this.repository);
//   Future<void> call(TaskEntity task) => repository.addTask(task);
// }
//
// class AddReviewUseCase {
//   final TaskRepository repository;
//   AddReviewUseCase(this.repository);
//   Future<void> call(String taskId, String review) => repository.addReview(taskId, review);
// }
*/