import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_event.dart';
import 'package:block_flutter/presentation/bloc/task_bloc/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/task_entity.dart';
import 'task_details_screen.dart';

class TaskListScreen extends StatelessWidget {


  final alarmSettings = AlarmSettings(
    id: 1,
    dateTime: DateTime(2025),
    assetAudioPath: 'assets/alarm.mp3',
    loopAudio: true,
    vibrate: true,
    warningNotificationOnKill: Platform.isIOS,
    androidFullScreenIntent: true,
    // volumeSettings: VolumeSettings.fixed(
    //   volume: 0.8,
    //   fadeDuration: Duration(seconds: 5),
    //   volumeEnforced: true,
    // ),
    volume: 0.8,
    // fadeDuration: Duration(days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: 0, microseconds: 0),
    fadeDuration: 5,
    volumeEnforced: true,
    notificationSettings: const NotificationSettings(
      title: 'This is the title',
      body: 'This is the body',
      stopButton: 'Stop the alarm',
      icon: 'notification_icon',
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(title: Center(child: Text('To-Do List')),backgroundColor: Colors.green,),
      // body: BlocBuilder<TaskBloc, TaskState>(
      //   builder: (context, state) {
      //     if (state is TaskInitial) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (state is TaskLoaded) {
      //       return ListView.builder(
      //         itemCount: state.tasks.length,
      //         itemBuilder: (context, index) {
      //           final task = state.tasks[index];
      //           return ListTile(
      //             title: Text(task.title),
      //             subtitle: task.review != null ? Text('Review: ${task.review}') : null,
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Checkbox(
      //                   value: task.isCompleted,
      //                   onChanged: (value) {
      //                     BlocProvider.of<TaskBloc>(context).add(
      //                       UpdateTask(task.copyWith(isCompleted: value ?? false)),
      //                     );
      //                   },
      //                 ),
      //                 IconButton(
      //                   icon: Icon(Icons.delete, color: Colors.red),
      //                   onPressed: () {
      //                     BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
      //                   },
      //                 ),
      //               ],
      //             ),
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => TaskDetailsScreen(task: task),
      //                 ),
      //               );
      //             },
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(child: Text('Error loading tasks.'));
      //     }
      //   },
      // )
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            _showSnackbar(context, state.message, success: state is TaskLoaded);
          }
        },
        builder: (context, state) {
          if (state is TaskInitial) {
            return const Center(child: CircularProgressIndicator(color: Colors.blueAccent,));
          } else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text("${index + 1}."),
                      const SizedBox(width: 10,),
                      Expanded(child: Text(task.title)),
                    ],
                  ),
                  subtitle: task.review != null ? Text('Review: ${task.review}') : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task.isCompleted == 0 ?  false : true,
                        onChanged: (value) {
                          print(value);
                          BlocProvider.of<TaskBloc>(context).add(
                            UpdateTask(task.copyWith(isCompleted: value == true ? 1 :  0)),
                          );
                        },
                      ),
                      IconButton(
                          icon : Icon(Icons.edit, color: Colors.black45,),
                        onPressed: () {
                            _showEditTaskDialog(context, task);
                            // BlocProvider.of<TaskBloc>(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.alarm, color: Colors.blueAccent),
                        onPressed: () async {
                          // await Alarm.set(alarmSettings: alarmSettings);
                          await Alarm.setWarningNotificationOnKill("Alarm", "Wake Up");
                          // BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(task: task),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('There is no task in list.'));
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message, {bool success = true}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController _taskController = TextEditingController();
    showDialog(
      barrierColor: Colors.red,barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(controller: _taskController, decoration: InputDecoration(hintText: 'Enter task title')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final taskTitle = _taskController.text.trim();
                if (taskTitle.isNotEmpty) {

                  BlocProvider.of<TaskBloc>(context).add(AddTask(TaskEntity(id: DateTime.now().toString(), title: taskTitle)));
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, TaskEntity task) {
    final TextEditingController _taskController = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(controller: _taskController, decoration: InputDecoration(hintText: 'Enter new task title')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTitle = _taskController.text.trim();
                if (updatedTitle.isNotEmpty) {
                  BlocProvider.of<TaskBloc>(context).add(UpdateTask(task.copyWith(title: updatedTitle, isCompleted: 0)));
                }
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

}
