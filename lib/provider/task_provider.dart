// lib/providers/task_provider.dart

import 'package:flutter/foundation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_mngmt/model/task_model.dart';
import 'package:task_mngmt/services/task_services.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService;
  List<Task> _tasks = [];
  bool _isLoading = false;
  String _searchTerm = '';
  String? _priorityFilter;
  bool? _completionFilter;
  bool _hasError = false;
  String _errorMessage = '';

  // Getters
  List<Task> get tasks => _filterTasks();
  bool get isLoading => _isLoading;
  String get searchTerm => _searchTerm;
  String? get priorityFilter => _priorityFilter;
  bool? get completionFilter => _completionFilter;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  TaskProvider({required String userId})
      : _taskService = TaskService(userId: userId) {
    _initializeTasks();
  }

  // Initialize tasks stream
  void _initializeTasks() {
    try {
      _isLoading = true;
      notifyListeners();

      _taskService.getTasks().listen(
        (tasks) {
          _tasks = tasks;
          _isLoading = false;
          _hasError = false;
          _errorMessage = '';
          notifyListeners();
        },
        onError: (error) {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Failed to load tasks: ${error.toString()}';
          notifyListeners();
        },
      );
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = 'Failed to initialize tasks: ${e.toString()}';
      notifyListeners();
    }
  }

  // Add new task
  Future<void> addTask(Task task) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _taskService.addTask(task);

      _hasError = false;
      _errorMessage = '';
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to add task: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update existing task
  Future<void> updateTask(Task task) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _taskService.updateTask(task);

      _hasError = false;
      _errorMessage = '';
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to update task: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _taskService.deleteTask(taskId);

      _hasError = false;
      _errorMessage = '';
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to delete task: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(Task task) async {
    try {
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
      );
      await _taskService.updateTask(updatedTask);

      _hasError = false;
      _errorMessage = '';
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to update task status: ${e.toString()}';
      notifyListeners();
    }
  }

  // Set search term
  void setSearchTerm(String term) {
    _searchTerm = term.toLowerCase();
    notifyListeners();
  }

  // Set filters
  void setFilters({String? priority, bool? isCompleted}) {
    _priorityFilter = priority;
    _completionFilter = isCompleted;
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _priorityFilter = null;
    _completionFilter = null;
    _searchTerm = '';
    notifyListeners();
  }

  // Filter tasks based on search term and filters
  List<Task> _filterTasks() {
    return _tasks.where((task) {
      // Search term filter
      if (_searchTerm.isNotEmpty) {
        final title = task.title.toLowerCase();
        final description = task.description.toLowerCase();
        if (!title.contains(_searchTerm) &&
            !description.contains(_searchTerm)) {
          return false;
        }
      }

      // Priority filter
      if (_priorityFilter != null && task.priority != _priorityFilter) {
        return false;
      }

      // Completion filter
      if (_completionFilter != null && task.isCompleted != _completionFilter) {
        return false;
      }

      return true;
    }).toList();
  }

  // Get tasks by priority
  List<Task> getTasksByPriority(String priority) {
    return _tasks.where((task) => task.priority == priority).toList();
  }

  // Get tasks by completion status
  List<Task> getTasksByCompletion(bool completed) {
    return _tasks.where((task) => task.isCompleted == completed).toList();
  }

  // Get overdue tasks
  List<Task> getOverdueTasks() {
    final now = DateTime.now();
    return _tasks
        .where((task) => !task.isCompleted && task.dueDate.isBefore(now))
        .toList();
  }

  // Get tasks due today
  List<Task> getTasksDueToday() {
    final now = DateTime.now();
    return _tasks.where((task) {
      return !task.isCompleted &&
          task.dueDate.year == now.year &&
          task.dueDate.month == now.month &&
          task.dueDate.day == now.day;
    }).toList();
  }

  // Get tasks due this week
  List<Task> getTasksDueThisWeek() {
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    return _tasks.where((task) {
      return !task.isCompleted &&
          task.dueDate.isAfter(now) &&
          task.dueDate.isBefore(weekFromNow);
    }).toList();
  }

  // Get task completion statistics
  Map<String, dynamic> getTaskStatistics() {
    final total = _tasks.length;
    final completed = _tasks.where((task) => task.isCompleted).length;
    final overdue = getOverdueTasks().length;

    return {
      'total': total,
      'completed': completed,
      'pending': total - completed,
      'overdue': overdue,
      'completionRate':
          total > 0 ? (completed / total * 100).toStringAsFixed(1) : '0',
      'priorityDistribution': {
        'high': getTasksByPriority('high').length,
        'medium': getTasksByPriority('medium').length,
        'low': getTasksByPriority('low').length,
      },
    };
  }

  // Refresh tasks
  Future<void> refreshTasks() async {
    _initializeTasks();
  }

  // Clear error state
  void clearError() {
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }
}
