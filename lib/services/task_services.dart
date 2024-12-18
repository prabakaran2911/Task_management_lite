// lib/services/task_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_mngmt/model/task_model.dart';
// import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  TaskService({required this.userId});

  CollectionReference get _tasksCollection => _firestore.collection('tasks');

  Stream<List<Task>> getTasks() {
    return _tasksCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> addTask(Task task) async {
    final docRef = _tasksCollection.doc();
    final newTask = task.copyWith(id: docRef.id);
    await docRef.set(newTask.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _tasksCollection.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }
}
