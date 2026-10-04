import '../models/quiz_question.dart';

final List<QuizQuestion> arraysQuizQuestions = [
  QuizQuestion(
    id: 'q1',
    question: 'In most programming languages, what is the index of the first element in an array?',
    options: ['0', '1', '-1', 'It depends on the language'],
    correctAnswer: '0',
    explanation: 'Arrays use zero-based indexing. The first element is always at index 0.',
  ),
  QuizQuestion(
    id: 'q2',
    question: 'What is the time complexity of accessing an element in an array by its index?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n²)'],
    correctAnswer: 'O(1)',
    explanation: 'Accessing by index is constant time because we can jump directly to that location in memory.',
  ),
  QuizQuestion(
    id: 'q3',
    question: 'If an array has 5 elements, what are the valid indices?',
    options: ['0 to 5', '1 to 5', '0 to 4', 'All of the above'],
    correctAnswer: '0 to 4',
    explanation: 'With 5 elements, valid indices are 0, 1, 2, 3, 4. Index 5 would be out of bounds.',
  ),
  QuizQuestion(
    id: 'q4',
    question: 'What is the time complexity of inserting an element in the middle of an array?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n²)'],
    correctAnswer: 'O(n)',
    explanation: 'Inserting in the middle requires shifting all subsequent elements, which takes O(n) time.',
  ),
  QuizQuestion(
    id: 'q5',
    question: 'What is the main advantage of arrays?',
    options: [
      'Dynamic memory allocation',
      'Fast access to elements by index',
      'Automatic sorting',
      'Unlimited size'
    ],
    correctAnswer: 'Fast access to elements by index',
    explanation: 'Arrays excel at providing fast O(1) access to any element when you know its index.',
  ),
];
