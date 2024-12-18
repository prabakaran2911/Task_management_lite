import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mngmt/provider/task_provider.dart';
import 'package:task_mngmt/tasks/task_card.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskProvider.tasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks found. Add some tasks to get started!',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
          );
        }

        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return TaskCard(task: task);
          },
        );
      },
    );
  }
}
