import 'package:flutter/material.dart';

import '../../widgets/lesson_complete.dart';
import '../../utils/progress.dart';
import 'stack_building_screen.dart';

class StackMasterScreen extends StatefulWidget {
  const StackMasterScreen({super.key});

  @override
  State<StackMasterScreen> createState() =>
      _StackMasterScreenState();
}

class _StackMasterScreenState extends State<StackMasterScreen> {
  // ==========================================================
  // STACK MASTER QUESTIONS
  // ==========================================================

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What principle does a Stack follow?',
      'options': [
        'FIFO',
        'LIFO',
        'FILO only',
        'Random order',
      ],
      'answer': 1,
    },
    {
      'question':
          'Which element is removed first from a Stack?',
      'options': [
        'The bottom element',
        'The middle element',
        'The top element',
        'The first inserted element always',
      ],
      'answer': 2,
    },
    {
      'question':
          'Which operation is used to add an element to a Stack?',
      'options': [
        'Pop',
        'Peek',
        'Push',
        'Delete',
      ],
      'answer': 2,
    },
    {
      'question':
          'Which operation removes the top element from a Stack?',
      'options': [
        'Push',
        'Pop',
        'Peek',
        'Show',
      ],
      'answer': 1,
    },
    {
      'question':
          'What does Peek do in a Stack?',
      'options': [
        'Adds a new element',
        'Deletes the entire Stack',
        'Returns the top element without removing it',
        'Removes the bottom element',
      ],
      'answer': 2,
    },
    {
      'question':
          'Where are insertion and deletion normally performed in a Stack?',
      'options': [
        'Only at the bottom',
        'Only at the middle',
        'At the top',
        'At any position',
      ],
      'answer': 2,
    },
    {
      'question':
          'What happens when Pop is performed on an empty Stack?',
      'options': [
        'Overflow',
        'Underflow',
        'The Stack is automatically created',
        'The bottom element is added',
      ],
      'answer': 1,
    },
    {
      'question':
          'What happens when Push is performed on a full Stack?',
      'options': [
        'Underflow',
        'Overflow',
        'Peek operation',
        'The Stack becomes empty',
      ],
      'answer': 1,
    },
    {
      'question':
          'Suppose we push 10, then 20, then 30. What is at the TOP?',
      'options': [
        '10',
        '20',
        '30',
        'None',
      ],
      'answer': 2,
    },
    {
      'question':
          'If a Stack contains 10, 20, 30 and we perform POP, what remains at the TOP?',
      'options': [
        '10',
        '20',
        '30',
        'The Stack becomes empty',
      ],
      'answer': 1,
    },
  ];

  int _currentQuestion = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int? _selectedAnswer;
  bool _answerSubmitted = false;

  int get _totalQuestions => _questions.length;

  double get _accuracy {
    if (_currentQuestion == 0) {
      return 0;
    }

    return (_correctAnswers / _currentQuestion) * 100;
  }

  // ==========================================================
  // ANSWER SELECTION
  // ==========================================================

  void _selectAnswer(int index) {
    if (_answerSubmitted) {
      return;
    }

    setState(() {
      _selectedAnswer = index;
    });
  }

  // ==========================================================
  // SUBMIT ANSWER
  // ==========================================================

  void _submitAnswer() {
    if (_selectedAnswer == null) {
      _showMessage(
        'Please select an answer first.',
      );
      return;
    }

    final correctAnswer =
        _questions[_currentQuestion]['answer'] as int;

    setState(() {
      _answerSubmitted = true;

      if (_selectedAnswer == correctAnswer) {
        _correctAnswers++;
      } else {
        _wrongAnswers++;
      }
    });
  }

  // ==========================================================
  // NEXT QUESTION
  // ==========================================================

  void _nextQuestion() {
    if (_currentQuestion == _totalQuestions - 1) {
      _finishMaster();
      return;
    }

    setState(() {
      _currentQuestion++;
      _selectedAnswer = null;
      _answerSubmitted = false;
    });
  }

  // ==========================================================
  // FINISH MASTER
  // ==========================================================

  void _finishMaster() {
    final finalAccuracy =
        (_correctAnswers / _totalQuestions) * 100;

    final int xp = _correctAnswers * 10;
    final int coins = _correctAnswers * 5;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LessonComplete(
          xp: xp,
          coins: coins,
          accuracy: finalAccuracy,
          onContinue: () {
            Progress.markStackMasterCompleted();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const StackBuildingScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================
  // OPTION COLORS
  // ==========================================================

  Color _optionColor(int index) {
    if (!_answerSubmitted) {
      if (_selectedAnswer == index) {
        return Colors.green.shade100;
      }

      return Colors.white;
    }

    final correctAnswer =
        _questions[_currentQuestion]['answer'] as int;

    if (index == correctAnswer) {
      return Colors.green.shade100;
    }

    if (index == _selectedAnswer &&
        _selectedAnswer != correctAnswer) {
      return Colors.red.shade100;
    }

    return Colors.white;
  }

  Color _optionBorderColor(int index) {
    if (!_answerSubmitted) {
      if (_selectedAnswer == index) {
        return Colors.green;
      }

      return Colors.grey.shade300;
    }

    final correctAnswer =
        _questions[_currentQuestion]['answer'] as int;

    if (index == correctAnswer) {
      return Colors.green;
    }

    if (index == _selectedAnswer &&
        _selectedAnswer != correctAnswer) {
      return Colors.red;
    }

    return Colors.grey.shade300;
  }

  IconData? _optionIcon(int index) {
    if (!_answerSubmitted) {
      return null;
    }

    final correctAnswer =
        _questions[_currentQuestion]['answer'] as int;

    if (index == correctAnswer) {
      return Icons.check_circle;
    }

    if (index == _selectedAnswer &&
        _selectedAnswer != correctAnswer) {
      return Icons.cancel;
    }

    return null;
  }

  // ==========================================================
  // FEEDBACK
  // ==========================================================

  String _feedbackText() {
    final correctAnswer =
        _questions[_currentQuestion]['answer'] as int;

    if (_selectedAnswer == correctAnswer) {
      return 'Correct! Great job! 🎉';
    }

    return 'Not quite. The correct answer is '
        '${_questions[_currentQuestion]['options'][correctAnswer]}.';
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final question =
        _questions[_currentQuestion];

    final String questionText =
        question['question'] as String;

    final List<String> options =
        List<String>.from(question['options']);

    final int progressNumber =
        _currentQuestion + 1;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      appBar: AppBar(
        title: const Text(
          'Stack - Master',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [

              // ==================================================
              // PROGRESS
              // ==================================================

              _buildProgressCard(progressNumber),

              const SizedBox(height: 18),

              // ==================================================
              // SCORE
              // ==================================================

              _buildScoreCard(),

              const SizedBox(height: 20),

              // ==================================================
              // QUESTION
              // ==================================================

              _buildQuestionCard(
                questionText,
                progressNumber,
              ),

              const SizedBox(height: 18),

              // ==================================================
              // OPTIONS
              // ==================================================

              ...List.generate(
                options.length,
                (index) => Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: _buildOption(
                    index,
                    options[index],
                  ),
                ),
              ),

              // ==================================================
              // FEEDBACK
              // ==================================================

              if (_answerSubmitted) ...[
                const SizedBox(height: 5),
                _buildFeedbackCard(),
              ],

              const SizedBox(height: 20),

              // ==================================================
              // ACTION BUTTON
              // ==================================================

              _buildActionButton(),

              const SizedBox(height: 25),

              // ==================================================
              // TIP
              // ==================================================

              _buildTipCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PROGRESS CARD
  // ==========================================================

  Widget _buildProgressCard(
    int progressNumber,
  ) {
    final progress =
        progressNumber / _totalQuestions;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  'Master Challenge',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '$progressNumber / $_totalQuestions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor:
                    Colors.orange.shade100,
                valueColor:
                    const AlwaysStoppedAnimation<
                        Color>(
                  Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SCORE CARD
  // ==========================================================

  Widget _buildScoreCard() {
    return Row(
      children: [

        Expanded(
          child: _scoreBox(
            title: 'Correct',
            value: '$_correctAnswers',
            icon: Icons.check_circle,
            iconColor: Colors.green,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _scoreBox(
            title: 'Wrong',
            value: '$_wrongAnswers',
            icon: Icons.cancel,
            iconColor: Colors.red,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _scoreBox(
            title: 'Accuracy',
            value:
                '${_accuracy.toStringAsFixed(0)}%',
            icon: Icons.track_changes,
            iconColor: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _scoreBox({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 8,
        ),
        child: Column(
          children: [

            Icon(
              icon,
              color: iconColor,
              size: 27,
            ),

            const SizedBox(height: 7),

            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // QUESTION CARD
  // ==========================================================

  Widget _buildQuestionCard(
    String questionText,
    int progressNumber,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Container(
                  padding:
                      const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.layers,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  'Question $progressNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              questionText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // OPTION
  // ==========================================================

  Widget _buildOption(
    int index,
    String option,
  ) {
    final selected =
        _selectedAnswer == index;

    final borderColor =
        _optionBorderColor(index);

    final backgroundColor =
        _optionColor(index);

    final icon =
        _optionIcon(index);

    return InkWell(
      onTap: () => _selectAnswer(index),
      borderRadius:
          BorderRadius.circular(16),
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: selected ? 3 : 2,
          ),
        ),
        child: Row(
          children: [

            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    selected &&
                            !_answerSubmitted
                        ? Colors.orange
                        : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Text(
                String.fromCharCode(
                  65 + index,
                ),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color:
                      selected &&
                              !_answerSubmitted
                          ? Colors.white
                          : Colors.black87,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),

            if (icon != null)
              Icon(
                icon,
                color: index ==
                        (_questions[
                                _currentQuestion]
                            ['answer'] as int)
                    ? Colors.green
                    : Colors.red,
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // FEEDBACK CARD
  // ==========================================================

  Widget _buildFeedbackCard() {
    final correctAnswer =
        _questions[_currentQuestion]['answer']
            as int;

    final isCorrect =
        _selectedAnswer == correctAnswer;

    return Card(
      color: isCorrect
          ? Colors.green.shade50
          : Colors.red.shade50,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Icon(
              isCorrect
                  ? Icons.celebration
                  : Icons.lightbulb,
              color: isCorrect
                  ? Colors.green
                  : Colors.red,
              size: 28,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                _feedbackText(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w600,
                  color: isCorrect
                      ? Colors.green.shade900
                      : Colors.red.shade900,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // ACTION BUTTON
  // ==========================================================

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _answerSubmitted
            ? _nextQuestion
            : _submitAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding:
              const EdgeInsets.symmetric(
            vertical: 17,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
        ),
        child: Text(
          _answerSubmitted
              ? (_currentQuestion ==
                      _totalQuestions - 1
                  ? 'Finish Master'
                  : 'Next Question')
              : 'Submit Answer',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // TIP CARD
  // ==========================================================

  Widget _buildTipCard() {
    return Card(
      color: Colors.amber.shade50,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Icon(
              Icons.lightbulb,
              color: Colors.amber,
              size: 27,
            ),

            SizedBox(width: 10),

            Expanded(
              child: Text(
                'Tip: Remember the Stack rule — '
                'LIFO means Last In, First Out. '
                'Push adds to the TOP and Pop removes '
                'from the TOP.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}