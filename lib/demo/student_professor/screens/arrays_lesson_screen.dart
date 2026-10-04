import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../data/arrays_lesson_data.dart';
import '../models/demo_student.dart';
import 'arrays_quiz_screen.dart';

class ArraysLessonScreen extends StatefulWidget {
  final DemoStudent student;

  const ArraysLessonScreen({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  State<ArraysLessonScreen> createState() => _ArraysLessonScreenState();
}

class _ArraysLessonScreenState extends State<ArraysLessonScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late DateTime _lessonStartTime;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _lessonStartTime = DateTime.now();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToQuiz() {
    final timeSpent =
        DateTime.now().difference(_lessonStartTime).inSeconds;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArraysQuizScreen(
          student: widget.student,
          timeSpentInLesson: timeSpent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = ArraysLesson.sections.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrays Lesson'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Section ${_currentPage + 1}/$totalPages',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '${((_currentPage + 1) / totalPages * 100).toStringAsFixed(0)}%',
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
                    value: (_currentPage + 1) / totalPages,
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
          // Lesson Content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: totalPages,
              itemBuilder: (context, index) {
                final section = ArraysLesson.sections[index];
                return LessonSectionView(section: section);
              },
            ),
          ),
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Previous'),
                    ),
                  ),
                if (_currentPage > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < totalPages - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _goToQuiz();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    child: Text(
                      _currentPage == totalPages - 1 ? 'Take Quiz' : 'Next',
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

class LessonSectionView extends StatelessWidget {
  final LessonSection section;

  const LessonSectionView({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
          ),
          const SizedBox(height: 24),
          Text(
            section.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.grey[800],
                ),
          ),
        ],
      ),
    );
  }
}
