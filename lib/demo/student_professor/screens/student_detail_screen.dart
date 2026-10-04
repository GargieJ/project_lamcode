import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../models/student_learning_record.dart';

class StudentDetailScreen extends StatelessWidget {
  final StudentLearningRecord record;

  const StudentDetailScreen({
    Key? key,
    required this.record,
  }) : super(key: key);

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.studentName),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Center(
                          child: Text(
                            record.studentName[record.studentName.length - 1],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.studentName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: record.completed
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                record.completed ? 'Completed' : 'Incomplete',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: record.completed
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Performance Summary',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPerformanceMetric(
                        context,
                        'Score',
                        '${record.correctAnswers}/${record.totalQuestions}',
                        Colors.blue,
                      ),
                      _buildPerformanceMetric(
                        context,
                        'Accuracy',
                        '${record.accuracy.toStringAsFixed(1)}%',
                        Colors.green,
                      ),
                      _buildPerformanceMetric(
                        context,
                        'Time',
                        _formatTime(record.timeSpentSeconds),
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Quiz Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildDetailRow(context, 'Student', record.studentName),
                      const Divider(height: 20),
                      _buildDetailRow(context, 'Topic', record.topic),
                      const Divider(height: 20),
                      _buildDetailRow(
                          context, 'Time Spent', _formatTime(record.timeSpentSeconds)),
                      const Divider(height: 20),
                      _buildDetailRow(context, 'Total Questions',
                          record.totalQuestions.toString()),
                      const Divider(height: 20),
                      _buildDetailRow(context, 'Correct Answers',
                          record.correctAnswers.toString()),
                      const Divider(height: 20),
                      _buildDetailRow(context, 'Incorrect Answers',
                          record.incorrectAnswers.toString()),
                      const Divider(height: 20),
                      _buildDetailRow(
                          context, 'Score', '${record.score.toStringAsFixed(2)}%'),
                      const Divider(height: 20),
                      _buildDetailRow(context, 'Accuracy',
                          '${record.accuracy.toStringAsFixed(2)}%'),
                      const Divider(height: 20),
                      _buildDetailRow(
                        context,
                        'Completion Status',
                        record.completed ? 'Completed' : 'Incomplete',
                      ),
                      const Divider(height: 20),
                      _buildDetailRow(
                        context,
                        'Completion Timestamp',
                        record.timestamp.toIso8601String(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceMetric(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
        ),
      ],
    );
  }
}
