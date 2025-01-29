import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
  Future<void> updateTaskReview(String taskId, String review);
  Future<void> editTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final List<TaskModel> _tasks = [];

  @override
  Future<List<TaskModel>> getTasks() async => _tasks;

  @override
  Future<void> addTask(TaskModel task) async => _tasks.add(task);

  @override
  Future<void> editTask(TaskModel task) async {
   final index = _tasks.indexWhere((t)=> t.id == task.id);
   if(index != -1 ) _tasks[index] = task;
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
  }


  @override
  Future<void> deleteTask(String taskId) async => _tasks.removeWhere((t) => t.id == taskId);

  @override
  Future<void> updateTaskReview(String taskId, String review) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) _tasks[index] = TaskModel(
      id: _tasks[index].id,
      title: _tasks[index].title,
      isCompleted: _tasks[index].isCompleted,
      review: review,
    );
  }
}