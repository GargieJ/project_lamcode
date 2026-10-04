import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../models/student_learning_record.dart';

class QuizResultScreen extends StatelessWidget {
  final StudentLearningRecord record;

  const QuizResultScreen({
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
    final isPass = record.accuracy >= 60;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Complete'),
          centerTitle: true,
          backgroundColor: AppTheme.primaryColor,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Result Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Quiz Complete!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPass
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text(
                              '${record.accuracy.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: isPass ? Colors.green : Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          isPass ? 'Great Job!' : 'Keep Practicing!',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isPass ? Colors.green : Colors.orange,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Details Section
                Text(
                  'Results',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Student Info
                ResultDetailRow(
                  label: 'Student',
                  value: record.studentName,
                ),
                ResultDetailRow(
                  label: 'Topic',
                  value: record.topic,
                ),
                ResultDetailRow(
                  label: 'Score',
                  value: '${record.correctAnswers}/${record.totalQuestions}',
                ),
                ResultDetailRow(
                  label: 'Accuracy',
                  value: '${record.accuracy.toStringAsFixed(1)}%',
                ),
                ResultDetailRow(
                  label: 'Time Spent',
                  value: _formatTime(record.timeSpentSeconds),
                ),
                ResultDetailRow(
                  label: 'Status',
                  value: record.completed ? 'Completed' : 'Incomplete',
                ),
                ResultDetailRow(
                  label: 'Date',
                  value:
                      '${record.timestamp.year}-${record.timestamp.month.toString().padLeft(2, '0')}-${record.timestamp.day.toString().padLeft(2, '0')}',
                ),
                const SizedBox(height: 32),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(
                        (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Back to Dashboard',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ResultDetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
