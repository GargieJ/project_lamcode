import '../models/question.dart';

const List<Question> arrayQuestions = [

  Question(

    type: QuestionType.mcq,

    question: "Which data structure stores elements in contiguous memory?",

    options: [

      "Array",

      "Linked List",

      "Queue",

      "Tree",

    ],

    correctOption: 0,

    explanation:
        "Arrays store elements next to each other in memory.",

  ),

  Question(

    type: QuestionType.output,

    question: "Predict the output.",

    code:
'''
int[] arr = {5,10,15};

System.out.println(arr[1]);
''',

    options: [

      "5",

      "10",

      "15",

      "Compilation Error",

    ],

    correctOption: 1,

    explanation:
        "Java arrays begin at index 0, therefore arr[1] = 10.",

  ),

  Question(

    type: QuestionType.fillBlank,

    question: "Fill in the blank.",

    code:
'''
int[] arr = new int[4];

arr[2] = ____;
''',

    answer: "20",

    explanation:
        "The blank should contain the value assigned to index 2.",

  ),

  Question(

    type: QuestionType.mcq,

    question: "Which index stores the first element?",

    options: [

      "0",

      "1",

      "-1",

      "Depends on compiler",

    ],

    correctOption: 0,

    explanation:
        "Java arrays use zero-based indexing.",

  ),

];