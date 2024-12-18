import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mngmt/model/task_model.dart';
import 'package:task_mngmt/provider/task_provider.dart';
import 'package:task_mngmt/task_screen/task_form.dart';
import 'package:task_mngmt/widget/priority.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 156, 120, 255),
        title: const Text(
          'Task Details',
          style: TextStyle(fontFamily: 'RussoOne'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskFormScreen(task: task),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Task'),
                  content:
                      const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<TaskProvider>().deleteTask(task.id);
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Return to list
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            PriorityBadge(priority: task.priority),
            const SizedBox(height: 16),
            Text(
              'Due Date: ${_formatDate(task.dueDate)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text(
                'Mark as Complete',
                style: TextStyle(fontFamily: 'Lexend'),
              ),
              value: task.isCompleted,
              onChanged: (bool value) {
                context.read<TaskProvider>().toggleTaskCompletion(task);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
