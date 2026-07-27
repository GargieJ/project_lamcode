import '../models/question.dart';

const List<Question> stackQuestions = [

  Question(

    type: QuestionType.mcq,

    question: "Which principle does a stack follow?",

    options: [

      "FIFO",

      "LIFO",

      "Random Access",

      "Priority Order",

    ],

    correctOption: 1,

    explanation:
        "Stack follows LIFO (Last In First Out), meaning the last inserted element is removed first.",

  ),


  Question(

    type: QuestionType.output,

    question: "Predict the output.",

    code:
'''
Stack<Integer> stack = new Stack<>();

stack.push(10);
stack.push(20);

System.out.println(stack.pop());
''',

    options: [

      "10",

      "20",

      "30",

      "Compilation Error",

    ],

    correctOption: 1,

    explanation:
        "20 was pushed last, so it is removed first according to LIFO.",

  ),


  Question(

    type: QuestionType.fillBlank,

    question: "Fill in the blank.",

    code:
'''
Stack<Integer> stack = new Stack<>();

stack.____(50);
''',

    answer: "push",

    explanation:
        "The push() operation inserts an element at the top of the stack.",

  ),


  Question(

    type: QuestionType.mcq,

    question: "Which operation removes the top element from a stack?",

    options: [

      "Push",

      "Peek",

      "Pop",

      "Insert",

    ],

    correctOption: 2,

    explanation:
        "Pop removes the element currently present at the top of the stack.",

  ),


  Question(

    type: QuestionType.mcq,

    question: "Which operation only views the top element without removing it?",

    options: [

      "Push",

      "Pop",

      "Peek",

      "Delete",

    ],

    correctOption: 2,

    explanation:
        "Peek returns the top element without modifying the stack.",

  ),

];