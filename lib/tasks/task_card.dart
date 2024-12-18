import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mngmt/contant/date_fomator.dart';
import 'package:task_mngmt/model/task_model.dart';
import 'package:task_mngmt/provider/task_provider.dart';
import 'package:task_mngmt/task_screen/task_detail.dart';
import 'package:task_mngmt/widget/priority.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 156, 120, 255),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  PriorityBadge(priority: task.priority),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lexend',
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormatter.formatDueDate(task.dueDate),
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      color: DateFormatter.isOverdue(task.dueDate)
                          ? const Color.fromARGB(255, 255, 136, 128)
                          : Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: task.isCompleted,
                      onChanged: (bool value) {
                        context.read<TaskProvider>().toggleTaskCompletion(task);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
