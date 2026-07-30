import '../models/question.dart';

final List<Question> linkedListQuestions = [
  Question(
    question: "What is the first node of a linked list called?",
    options: [
      "Tail",
      "Head",
      "Root",
      "Start",
    ],
    correctOption: 1,
    explanation:
        "The first node of a linked list is called the Head.",
    type: QuestionType.mcq,
  ),

  Question(
    question:
        "What does the last node of a singly linked list point to?",
    options: [
      "Head",
      "Previous Node",
      "NULL",
      "First Node",
    ],
    correctOption: 2,
    explanation:
        "The last node points to NULL, marking the end of the list.",
    type: QuestionType.mcq,
  ),

  Question(
    question:
        "What are the two main parts of a linked-list node?",
    options: [
      "Index and Value",
      "Data and Next",
      "Head and Tail",
      "Key and Index",
    ],
    correctOption: 1,
    explanation:
        "A node contains data and a reference to the next node.",
    type: QuestionType.mcq,
  ),

  Question(
    question: "What does traversal mean?",
    options: [
      "Deleting all nodes",
      "Adding a new node",
      "Visiting nodes one by one",
      "Sorting the list",
    ],
    correctOption: 2,
    explanation:
        "Traversal means visiting nodes one by one starting from the head.",
    type: QuestionType.mcq,
  ),

  Question(
    question: "Complete the linked list:",
    code: "HEAD → 10 → 20 → 30 → ____",
    answer: "NULL",
    explanation:
        "The last node in a singly linked list points to NULL.",
    type: QuestionType.fillBlank,
  ),

  Question(
    question: "Which operation adds a new node?",
    options: [
      "Deletion",
      "Traversal",
      "Insertion",
      "Searching",
    ],
    correctOption: 2,
    explanation:
        "Insertion is used to add a new node.",
    type: QuestionType.mcq,
  ),

  Question(
    question: "Which operation removes a node?",
    options: [
      "Insertion",
      "Deletion",
      "Traversal",
      "Mapping",
    ],
    correctOption: 1,
    explanation:
        "Deletion removes a node from the linked list.",
    type: QuestionType.mcq,
  ),

  Question(
    question: "What is produced by this traversal?",
    code: "HEAD → 10 → 20 → 30 → NULL",
    options: [
      "10 20 30",
      "30 20 10",
      "NULL 30 20",
      "10 30 20",
    ],
    correctOption: 0,
    explanation:
        "Traversal from HEAD visits 10, then 20, then 30.",
    type: QuestionType.output,
  ),
];