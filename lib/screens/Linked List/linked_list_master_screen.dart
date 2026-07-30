import 'package:flutter/material.dart';

import '../../data/linked_list_questions.dart';
import '../../models/question.dart';
import '../../widgets/progress_header.dart';
import '../../widgets/option_button.dart';
import '../../widgets/result_card.dart';
import '../../widgets/lesson_complete.dart';

import '../../utils/progress.dart';
import 'linked_list_building_screen.dart';

class LinkedListMasterScreen extends StatefulWidget {
  const LinkedListMasterScreen({super.key});

  @override
  State<LinkedListMasterScreen> createState() =>
      _LinkedListMasterScreenState();
}

class _LinkedListMasterScreenState
    extends State<LinkedListMasterScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the first node of a linked list called?',
      'options': [
        'Tail',
        'Head',
        'Root',
        'Start',
      ],
      'answer': 1,
    },
    {
      'question': 'What does the last node of a singly linked list point to?',
      'options': [
        'Head',
        'First node',
        'NULL',
        'Previous node',
      ],
      'answer': 2,
    },
    {
      'question': 'What are the two main parts of a linked list node?',
      'options': [
        'Index and value',
        'Data and next',
        'Head and tail',
        'Key and index',
      ],
      'answer': 1,
    },
    {
      'question': 'What does traversal of a linked list mean?',
      'options': [
        'Deleting every node',
        'Sorting the nodes',
        'Visiting nodes one by one',
        'Creating a new list',
      ],
      'answer': 2,
    },
    {
      'question': 'Which operation adds a new node to a linked list?',
      'options': [
        'Insertion',
        'Traversal',
        'Searching',
        'Sorting',
      ],
      'answer': 0,
    },
    {
      'question': 'Which operation removes a node from a linked list?',
      'options': [
        'Traversal',
        'Insertion',
        'Deletion',
        'Mapping',
      ],
      'answer': 2,
    },
    {
      'question': 'In a singly linked list, each node usually points to:',
      'options': [
        'The previous node',
        'The next node',
        'The head and tail',
        'Every node',
      ],
      'answer': 1,
    },
    {
      'question': 'Which of these represents a linked list correctly?',
      'options': [
        '[10] [20] [30]',
        '10 → 20 → 30 → NULL',
        '10 + 20 + 30',
        '10, 20, 30 in a matrix',
      ],
      'answer': 1,
    },
    {
      'question': 'What happens when the head of a linked list is NULL?',
      'options': [
        'The list is empty',
        'The list has one node',
        'The list is full',
        'The tail becomes the head automatically',
      ],
      'answer': 0,
    },
    {
      'question': 'Why are linked lists called linked lists?',
      'options': [
        'Because values are always sorted',
        'Because nodes are connected using references',
        'Because nodes are stored in arrays',
        'Because every node has two data fields',
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

  void _selectAnswer(int index) {
    if (_answerSubmitted) return;

    setState(() {
      _selectedAnswer = index;
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) {
      _showMessage('Please select an answer first.');
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
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

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

  String _feedbackText() {
    final correctAnswer =
        _questions[_currentQuestion]['answer'] as int;

    if (_selectedAnswer == correctAnswer) {
      return 'Correct! Great job! 🎉';
    }

    return 'Not quite. The correct answer is '
        '${_questions[_currentQuestion]['options'][correctAnswer]}.';
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];

    final String questionText =
        question['question'] as String;

    final List<String> options =
        List<String>.from(question['options']);

    final int progressNumber = _currentQuestion + 1;

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text(
          'Linked List - Master',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProgressCard(progressNumber),

              const SizedBox(height: 18),

              _buildScoreCard(),

              const SizedBox(height: 20),

              _buildQuestionCard(
                questionText,
                progressNumber,
              ),

              const SizedBox(height: 18),

              ...List.generate(
                options.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: _buildOption(
                    index,
                    options[index],
                  ),
                ),
              ),

              if (_answerSubmitted) ...[
                const SizedBox(height: 5),
                _buildFeedbackCard(),
              ],

              const SizedBox(height: 20),

              _buildActionButton(),

              const SizedBox(height: 25),

              _buildTipCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(int progressNumber) {
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
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.green.shade100,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(
                  Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            value: '${_accuracy.toStringAsFixed(0)}%',
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
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.quiz,
                    color: Colors.green,
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
      borderRadius: BorderRadius.circular(16),
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
                    selected && !_answerSubmitted
                        ? Colors.green
                        : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Text(
                String.fromCharCode(65 + index),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.bold,
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
                  fontWeight:
                      FontWeight.w600,
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
        borderRadius: BorderRadius.circular(18),
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

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _answerSubmitted
            ? _nextQuestion
            : _submitAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
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

  Widget _buildTipCard() {
    return Card(
      color: Colors.amber.shade50,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
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
                'Tip: Remember the basic structure: '
                'HEAD → NODE → NODE → NULL.',
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