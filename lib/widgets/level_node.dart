import 'package:flutter/material.dart';



class LevelNode extends StatelessWidget {


  final String title;

  final String level;

  final Color color;

  final bool unlocked;

  final VoidCallback? onTap;




  const LevelNode({


    super.key,


    required this.title,


    required this.level,


    required this.color,


    this.unlocked = false,


    this.onTap,


  });





  @override
  Widget build(BuildContext context) {


    return GestureDetector(


      onTap: unlocked ? onTap : null,



      child: Column(


        children: [



          Container(


            width:75,


            height:75,



            decoration: BoxDecoration(


              shape: BoxShape.circle,



              color: unlocked

                  ? color

                  : Colors.grey.shade400,




              border: Border.all(


                color: Colors.white,


                width:4,


              ),




              boxShadow:[


                BoxShadow(


                  color: Colors.black.withOpacity(0.3),


                  blurRadius:12,


                  offset:const Offset(0,5),


                )


              ],


            ),





            child: Center(



              child: unlocked



                  ? Text(


                      level,


                      style: const TextStyle(


                        color: Colors.white,


                        fontSize:28,


                        fontWeight:FontWeight.bold,


                      ),


                    )



                  : const Icon(


                      Icons.lock,


                      color: Colors.white,


                      size:30,


                    ),



            ),



          ),





          const SizedBox(height:8),






          Container(



            padding: const EdgeInsets.symmetric(


              horizontal:12,


              vertical:6,


            ),





            decoration: BoxDecoration(


              color: Colors.white.withOpacity(0.85),



              borderRadius:


                  BorderRadius.circular(15),



            ),





            child: Text(


              title,



              textAlign: TextAlign.center,



              style: const TextStyle(


                color: Colors.black87,


                fontWeight: FontWeight.bold,


                fontSize:13,


              ),



            ),



          ),



        ],


      ),



    );


  }


}