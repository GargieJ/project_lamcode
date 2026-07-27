import 'package:flutter/material.dart';
import 'array_building_screen.dart';


class ArrayMapScreen extends StatelessWidget {

  const ArrayMapScreen({super.key});



  final List<Map<String,dynamic>> lessons = const [

    {
      "title":"Array Creation",
      "number":"1",
      "unlocked":true,
      "color":Colors.orange,
    },


    {
      "title":"Accessing Elements",
      "number":"2",
      "unlocked":false,
      "color":Colors.blue,
    },


    {
      "title":"Insertion",
      "number":"3",
      "unlocked":false,
      "color":Colors.green,
    },


    {
      "title":"Deletion",
      "number":"4",
      "unlocked":false,
      "color":Colors.red,
    },


    {
      "title":"Searching",
      "number":"5",
      "unlocked":false,
      "color":Colors.purple,
    },

  ];



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body:Stack(

        children:[


          Positioned.fill(

            child:Image.asset(

              "lib/assets/array_city_bg.png",

              fit:BoxFit.cover,

            ),

          ),




          Positioned.fill(

            child:Container(

              color:Colors.black.withValues(alpha: 0.15),

            ),

          ),





          SafeArea(

            child:Column(

              children:[



                Padding(

                  padding:const EdgeInsets.all(16),

                  child:Row(

                    children:[


                      IconButton(

                        onPressed:(){

                          Navigator.pop(context);

                        },

                        icon:const Icon(

                          Icons.arrow_back,

                          color:Colors.white,

                        ),

                      ),



                      const Text(

                        "Arrays",

                        style:TextStyle(

                          color:Colors.white,

                          fontSize:28,

                          fontWeight:FontWeight.bold,

                        ),

                      )

                    ],

                  ),

                ),





                Expanded(

                  child:ListView.builder(

                    itemCount:lessons.length,


                    itemBuilder:(context,index){


                      final lesson=lessons[index];



                      return Align(

                        alignment:index%2==0

                        ?Alignment.centerLeft

                        :Alignment.centerRight,



                        child:Padding(

                          padding:EdgeInsets.only(

                            top:35,

                            left:index%2==0?45:0,

                            right:index%2==0?0:45,

                          ),



                          child:LessonNode(

                            title:lesson["title"],

                            number:lesson["number"],

                            color:lesson["color"],

                            unlocked:lesson["unlocked"],


                            onTap:lesson["unlocked"]

                            ?

                            (){


                              if(index==0){


                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder:(context)=>const ArrayBuildingScreen(),

                                  ),

                                );


                              }


                            }


                            :null,


                          ),

                        ),

                      );

                    },


                  ),

                )

              ],

            ),

          )

        ],

      ),


    );


  }

}








class LessonNode extends StatelessWidget {


final String title;

final String number;

final Color color;

final bool unlocked;

final VoidCallback? onTap;



const LessonNode({

super.key,

required this.title,

required this.number,

required this.color,

required this.unlocked,

this.onTap,

});



@override
Widget build(BuildContext context){


return GestureDetector(


onTap:onTap,


child:Column(

children:[


Container(

width:75,

height:75,


decoration:BoxDecoration(

shape:BoxShape.circle,

color:unlocked

?color

:Colors.grey,


border:Border.all(

color:Colors.white,

width:4,

),


),



child:Center(

child:unlocked

?

Text(

number,

style:const TextStyle(

color:Colors.white,

fontSize:28,

fontWeight:FontWeight.bold,

),

)

:

const Icon(

Icons.lock,

color:Colors.white,

),

),


),





const SizedBox(height:10),




Container(

padding:const EdgeInsets.symmetric(

horizontal:15,

vertical:8,

),


decoration:BoxDecoration(

color:Colors.white.withValues(alpha: 0.9),

borderRadius:BorderRadius.circular(20),

),


child:Text(

title,

style:const TextStyle(

fontWeight:FontWeight.bold,

color:Colors.black87,

),

),

)


],

),

);


}


}