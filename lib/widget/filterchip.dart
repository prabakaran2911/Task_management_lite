import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mngmt/provider/task_provider.dart';

class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text(
              'All',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
            selected: context.watch<TaskProvider>().priorityFilter == null &&
                context.watch<TaskProvider>().completionFilter == null,
            onSelected: (bool selected) {
              if (selected) {
                context.read<TaskProvider>().clearFilters();
              }
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            backgroundColor: const Color.fromARGB(255, 115, 160, 237),
            label: const Text(
              'High Priority',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
            selected: context.watch<TaskProvider>().priorityFilter == 'high',
            onSelected: (bool selected) {
              context.read<TaskProvider>().setFilters(
                    priority: selected ? 'high' : null,
                  );
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            backgroundColor: const Color.fromARGB(255, 154, 187, 243),
            label: const Text(
              'Medium Priority',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
            selected: context.watch<TaskProvider>().priorityFilter == 'medium',
            onSelected: (bool selected) {
              context.read<TaskProvider>().setFilters(
                    priority: selected ? 'medium' : null,
                  );
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            backgroundColor: const Color.fromARGB(255, 199, 216, 246),
            label: const Text(
              'Low Priority',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
            selected: context.watch<TaskProvider>().priorityFilter == 'low',
            onSelected: (bool selected) {
              context.read<TaskProvider>().setFilters(
                    priority: selected ? 'low' : null,
                  );
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            backgroundColor: const Color.fromARGB(255, 171, 241, 214),
            label: const Text('Completed'),
            selected: context.watch<TaskProvider>().completionFilter == true,
            onSelected: (bool selected) {
              context.read<TaskProvider>().setFilters(
                    isCompleted: selected ? true : null,
                  );
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            backgroundColor: const Color.fromARGB(255, 248, 152, 145),
            label: const Text(
              'Pending',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
            selected: context.watch<TaskProvider>().completionFilter == false,
            onSelected: (bool selected) {
              context.read<TaskProvider>().setFilters(
                    isCompleted: selected ? false : null,
                  );
            },
          ),
        ],
      ),
    );
  }
}
