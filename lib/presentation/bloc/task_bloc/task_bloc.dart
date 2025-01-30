import 'package:block_flutter/domain/usecases/usecases.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_event.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/task_entity.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final EditTaskUseCase editTaskCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
    required this.editTaskCase,
  }) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<EditTask>(_onEditTask);
  }


  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await getTasksUseCase();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Failed to load tasks"));
    }
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final updatedTasks = List<TaskEntity>.from((state as TaskLoaded).tasks)..add(event.task);
      await addTaskUseCase(event.task);
      emit(TaskLoaded(updatedTasks, message: "Task added on the list"));
    }
  }



  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final updatedTasks = (state as TaskLoaded).tasks.map((task) {
        return task.id == event.updatedTask.id ? event.updatedTask : task;
      }).toList();
      await updateTaskUseCase(event.updatedTask);
      emit(TaskLoaded(updatedTasks));
    }
  }

  // on<AddTask>((event, emit) async {
  //   try {
  //     await taskRepository.addTask(event.task);
  //     final updatedTasks = List<TaskEntity>.from(state.tasks)..add(event.task);
  //     emit(TaskLoaded(updatedTasks, message: "Task added successfully!"));
  //   } catch (e) {
  //     emit(TaskError("Failed to add task: ${e.toString()}"));
  //   }
  // });

  void _onEditTask(EditTask event , Emitter<TaskState> emit)async{
    // try{
    //   final editTask = (state as TaskLoaded).tasks.map((task){
    //     return task.id == event.taskEdit.id ? event.taskEdit : task;
    //   }).toList();
    //   await editTaskCase(event.ediTask);
    //
    // }catch(e){
    //
    // }
  }


  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final updatedTasks = (state as TaskLoaded).tasks.where((task) => task.id != event.taskId).toList();
      await deleteTaskUseCase(event.taskId);
      emit(TaskLoaded(updatedTasks, message: "Task deleted successfully!"));
    }
  }

}









// import 'package:block_flutter/domain/usecases/usecases.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/entities/task_entity.dart';
//
//
// abstract class TaskEvent {}
// class LoadTasks extends TaskEvent {}
// class AddTask extends TaskEvent { final TaskEntity task; AddTask(this.task); }
//
// abstract class TaskState {}
// class TaskInitial extends TaskState {}
// class TaskLoaded extends TaskState { final List<TaskEntity> tasks; TaskLoaded(this.tasks); }
//
// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   final GetTasksUseCase getTasksUseCase;
//   final AddTaskUseCase addTaskUseCase;
//
//   TaskBloc({required this.getTasksUseCase, required this.addTaskUseCase}) : super(TaskInitial()) {
//     on<LoadTasks>((event, emit) async {
//       final tasks = await getTasksUseCase();
//       emit(TaskLoaded(tasks));
//     });
//
//     on<AddTask>((event, emit) async {
//       await addTaskUseCase(event.task);
//       add(LoadTasks());
//     });
//
//
//     on<UpdateTask>((event, emit) async {
//       final updatedTasks = state.tasks.map((task) {
//         return task.id == event.updatedTask.id ? event.updatedTask : task;
//       }).toList();
//
//       emit(TaskLoaded(updatedTasks));
//
//       // Optionally save updated task to local storage
//       await taskRepository.updateTask(event.updatedTask);
//     });
//   }
// }
//
