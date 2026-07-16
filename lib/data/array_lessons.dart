class ArrayLesson {

  final String title;
  final int number;
  final bool unlocked;


  ArrayLesson({

    required this.title,

    required this.number,

    this.unlocked = false,

  });

}



List<ArrayLesson> arrayLessons = [

  ArrayLesson(

    title: "Array Creation",

    number: 1,

    unlocked: true,

  ),


  ArrayLesson(

    title: "Accessing Elements",

    number: 2,

  ),


  ArrayLesson(

    title: "Insertion",

    number: 3,

  ),


  ArrayLesson(

    title: "Deletion",

    number: 4,

  ),


  ArrayLesson(

    title: "Searching",

    number: 5,

  ),


];