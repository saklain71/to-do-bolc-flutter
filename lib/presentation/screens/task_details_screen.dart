// TaskDetailsScreen (lib/presentation/screens/task_details_screen.dart)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc/task_bloc.dart';
import '../../domain/entities/task_entity.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskEntity task;
  TaskDetailsScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(title: Text('Task Details'),backgroundColor: Colors.green,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(task.review ?? 'No review yet.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
