

import 'package:alarm/alarm.dart';
import 'package:block_flutter/data/datasources/user_api_service.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_event.dart';
import 'package:block_flutter/presentation/screens/home_screen.dart';
import 'package:block_flutter/presentation/screens/task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/task_local_data_source.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/usecases.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // setupLogging(showDebugLogs: true);

  await Alarm.init();

  final taskLocalDataSource = TaskLocalDataSourceImpl();
  final taskRepository = TaskRepositoryImpl(localDataSource: taskLocalDataSource);
  final getTasksUseCase = GetTasksUseCase(taskRepository);
  final addTaskUseCase = AddTaskUseCase(taskRepository);
  final updateTaskUseCase = UpdateTaskUseCase(taskRepository);
  final deleteTaskUseCase = DeleteTaskUseCase(taskRepository);
  final editTaskCase = EditTaskUseCase(taskRepository);

  // // Initialize User API Service and Repository
  // final userApiService = UserApiService();
  // final userRepository = UserRepositiry(apiService: userApiService);


  runApp(MyApp(
    getTasksUseCase: getTasksUseCase,
    addTaskUseCase: addTaskUseCase,
    updateTaskUseCase: updateTaskUseCase,
    deleteTaskUseCase: deleteTaskUseCase,
    editTaskCase: editTaskCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final EditTaskUseCase editTaskCase;

  MyApp({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
    required this.editTaskCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(
              getTasksUseCase: getTasksUseCase,
              addTaskUseCase: addTaskUseCase,
              updateTaskUseCase: updateTaskUseCase,
              deleteTaskUseCase: deleteTaskUseCase,
              editTaskCase: editTaskCase
          )..add(LoadTasks()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter To-Do List',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}


