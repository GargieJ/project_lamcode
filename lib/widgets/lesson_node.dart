import 'package:flutter/material.dart';


class LessonNode extends StatelessWidget {


  final String title;
  final int number;
  final bool unlocked;
  final VoidCallback? onTap;



  const LessonNode({

    super.key,

    required this.title,

    required this.number,

    required this.unlocked,

    this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      onTap: unlocked ? onTap : null,


      child: Column(

        children: [



          Container(

            width:70,

            height:70,


            decoration: BoxDecoration(

              shape: BoxShape.circle,


              color: unlocked

                  ? Colors.orange

                  : Colors.grey.shade400,



              border: Border.all(

                color: Colors.white,

                width:4,

              ),



              boxShadow: [

                BoxShadow(

                  color: Colors.black.withValues(alpha: 0.25),

                  blurRadius:10,

                  offset:const Offset(0,5),

                )

              ],

            ),



            child: Center(

              child: unlocked

                  ? Text(

                      "$number",

                      style:const TextStyle(

                        color:Colors.white,

                        fontSize:28,

                        fontWeight:FontWeight.bold,

                      ),

                    )


                  : const Icon(

                      Icons.lock,

                      color:Colors.white,

                      size:30,

                    ),

            ),


          ),



          const SizedBox(height:8),



          Container(

            padding:const EdgeInsets.symmetric(

              horizontal:12,

              vertical:6,

            ),



            decoration:BoxDecoration(

              color:Colors.white.withValues(alpha: 0.85),

              borderRadius:

                  BorderRadius.circular(15),

            ),



            child:Text(

              title,


              textAlign:TextAlign.center,


              style:const TextStyle(

                fontSize:13,

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