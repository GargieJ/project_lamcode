import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/student_learning_record.dart';

/// Repository for managing student learning records.
/// 
/// This is a local implementation using in-memory storage.
/// It can be easily replaced with a real backend in the future.
class StudentAnalyticsRepository extends ChangeNotifier {
  final Map<String, StudentLearningRecord> _records = {};

  /// Get all learning records
  List<StudentLearningRecord> getAllRecords() {
    return _records.values.toList();
  }

  /// Get records for a specific student
  List<StudentLearningRecord> getRecordsForStudent(String studentId) {
    return _records.values
        .where((record) => record.studentId == studentId)
        .toList();
  }

  /// Get records for a specific topic
  List<StudentLearningRecord> getRecordsForTopic(String topic) {
    return _records.values
        .where((record) => record.topic == topic)
        .toList();
  }

  /// Get records for a specific student and topic
  List<StudentLearningRecord> getRecordsForStudentAndTopic(
    String studentId,
    String topic,
  ) {
    return _records.values
        .where((record) => record.studentId == studentId && record.topic == topic)
        .toList();
  }

  /// Save a new learning record
  Future<void> saveRecord(StudentLearningRecord record) async {
    _records[record.id] = record;
    notifyListeners();

    if (kDebugMode) {
      print('Record saved: ${record.id} for student ${record.studentName}');
    }
  }

  /// Get a specific record by ID
  StudentLearningRecord? getRecordById(String id) {
    return _records[id];
  }

  /// Delete a record
  Future<void> deleteRecord(String id) async {
    _records.remove(id);
    notifyListeners();
  }

  /// Clear all records (for testing)
  Future<void> clearAllRecords() async {
    _records.clear();
    notifyListeners();
  }

  /// Get summary stats for a student
  Map<String, dynamic> getStudentSummary(String studentId) {
    final records = getRecordsForStudent(studentId);
    if (records.isEmpty) {
      return {
        'totalRecords': 0,
        'averageAccuracy': 0.0,
        'totalTimeSpent': 0,
      };
    }

    final totalAccuracy =
        records.fold<double>(0, (sum, record) => sum + record.accuracy);
    final averageAccuracy = totalAccuracy / records.length;
    final totalTimeSpent = records.fold<int>(
      0,
      (sum, record) => sum + record.timeSpentSeconds,
    );

    return {
      'totalRecords': records.length,
      'averageAccuracy': averageAccuracy,
      'totalTimeSpent': totalTimeSpent,
      'topics': records.map((r) => r.topic).toSet().length,
    };
  }
}
