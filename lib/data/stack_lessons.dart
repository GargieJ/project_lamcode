class StackLesson {

  final String title;
  final int number;
  final bool unlocked;


  StackLesson({

    required this.title,

    required this.number,

    this.unlocked = false,

  });

}



List<StackLesson> stackLessons = [

  StackLesson(

    title: "Stack Creation",

    number: 1,

    unlocked: true,

  ),


  StackLesson(

    title: "Push Operation",

    number: 2,

  ),


  StackLesson(

    title: "Pop Operation",

    number: 3,

  ),


  StackLesson(

    title: "Peek Operation",

    number: 4,

  ),


  StackLesson(

    title: "Stack Applications",

    number: 5,

  ),

];