import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mngmt/provider/auth_provider.dart';
import 'package:task_mngmt/provider/task_provider.dart';
import 'package:task_mngmt/config/theme/theme_provider.dart';
import 'package:task_mngmt/task_screen/task_form.dart';
import 'package:task_mngmt/task_screen/task_list_screen.dart';
import 'package:task_mngmt/widget/filterchip.dart';
import 'package:task_mngmt/widget/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 156, 120, 255),
        title: const Text(
          'Task Manager',
          style: TextStyle(fontFamily: 'RussoOne'),
        ),
        actions: [
          // Theme Toggle Button
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  // Toggle theme
                  themeProvider.toggleTheme();
                },
                tooltip: 'Toggle theme',
              );
            },
          ),
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TaskSearchBar(
              onSearch: (term) {
                context.read<TaskProvider>().setSearchTerm(term);
              },
            ),
          ),
          const FilterChipsRow(),
          const Expanded(
            child: TaskListScreen(),
          ),
          Text(
            '@ Powered By TBC Developers',
            style: TextStyle(fontFamily: 'Lexend', fontSize: 10),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 156, 120, 255),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
