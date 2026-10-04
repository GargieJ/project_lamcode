import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_theme.dart';
import '../data/arrays_quiz_data.dart';
import '../models/demo_student.dart';
import '../models/student_learning_record.dart';
import '../repository/student_analytics_repository.dart';
import 'quiz_result_screen.dart';

class ArraysQuizScreen extends StatefulWidget {
  final DemoStudent student;
  final int timeSpentInLesson;

  const ArraysQuizScreen({
    Key? key,
    required this.student,
    required this.timeSpentInLesson,
  }) : super(key: key);

  @override
  State<ArraysQuizScreen> createState() => _ArraysQuizScreenState();
}

class _ArraysQuizScreenState extends State<ArraysQuizScreen> {
  late int _currentQuestionIndex;
  final Map<int, String?> _answers = {};

  @override
  void initState() {
    super.initState();
    _currentQuestionIndex = 0;
  }

  void _submitQuiz() {
    if (_answers.length < arraysQuizQuestions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions before submitting.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int correctCount = 0;
    for (int i = 0; i < arraysQuizQuestions.length; i++) {
      if (_answers[i] == arraysQuizQuestions[i].correctAnswer) {
        correctCount++;
      }
    }

    final incorrectCount = arraysQuizQuestions.length - correctCount;
    final score = (correctCount / arraysQuizQuestions.length) * 100;
    final accuracy = (correctCount / arraysQuizQuestions.length) * 100;

    // Create learning record
    final record = StudentLearningRecord(
      id: '${widget.student.id}_arrays_${DateTime.now().millisecondsSinceEpoch}',
      studentId: widget.student.id,
      studentName: widget.student.name,
      topic: 'Arrays',
      timeSpentSeconds: widget.timeSpentInLesson,
      totalQuestions: arraysQuizQuestions.length,
      correctAnswers: correctCount,
      incorrectAnswers: incorrectCount,
      score: score,
      accuracy: accuracy,
      completed: true,
      timestamp: DateTime.now(),
    );

    // Save to repository
    context.read<StudentAnalyticsRepository>().saveRecord(record);

    // Navigate to result screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          record: record,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = arraysQuizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrays Quiz'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${arraysQuizQuestions.length}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '${((_currentQuestionIndex + 1) / arraysQuizQuestions.length * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) /
                        arraysQuizQuestions.length,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Question Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 24),
                  ...question.options.map((option) {
                    final isSelected = _answers[_currentQuestionIndex] == option;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OptionButton(
                        option: option,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _answers[_currentQuestionIndex] = option;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          // Navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      child: const Text('Previous'),
                    ),
                  ),
                if (_currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentQuestionIndex <
                          arraysQuizQuestions.length - 1) {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      } else {
                        _submitQuiz();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    child: Text(
                      _currentQuestionIndex == arraysQuizQuestions.length - 1
                          ? 'Submit'
                          : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionButton({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Text(
          option,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? AppTheme.primaryColor
                    : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
