class StudentLearningRecord {
  final String id;
  final String studentId;
  final String studentName;
  final String topic;
  final int timeSpentSeconds;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final double score;
  final double accuracy;
  final bool completed;
  final DateTime timestamp;

  StudentLearningRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.topic,
    required this.timeSpentSeconds,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.score,
    required this.accuracy,
    required this.completed,
    required this.timestamp,
  });

  factory StudentLearningRecord.fromJson(Map<String, dynamic> json) {
    return StudentLearningRecord(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      topic: json['topic'] as String,
      timeSpentSeconds: json['timeSpentSeconds'] as int,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      incorrectAnswers: json['incorrectAnswers'] as int,
      score: (json['score'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      completed: json['completed'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'studentId': studentId,
    'studentName': studentName,
    'topic': topic,
    'timeSpentSeconds': timeSpentSeconds,
    'totalQuestions': totalQuestions,
    'correctAnswers': correctAnswers,
    'incorrectAnswers': incorrectAnswers,
    'score': score,
    'accuracy': accuracy,
    'completed': completed,
    'timestamp': timestamp.toIso8601String(),
  };
}
