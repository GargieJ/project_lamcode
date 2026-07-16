import 'package:flutter/material.dart';


class LessonScreen extends StatelessWidget {

  const LessonScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          // Background
          Positioned.fill(

            child: Container(

              decoration: const BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Color(0xff87CEEB),

                    Color(0xffE8F5E9),

                  ],

                  begin: Alignment.topCenter,

                  end: Alignment.bottomCenter,

                ),

              ),

            ),

          ),



          SafeArea(

            child: Column(

              children: [


                // Header

                Padding(

                  padding: const EdgeInsets.all(16),

                  child: Row(

                    children: [


                      IconButton(

                        onPressed: () {

                          Navigator.pop(context);

                        },

                        icon: const Icon(

                          Icons.arrow_back,

                          size: 30,

                        ),

                      ),



                      const SizedBox(width:10),



                      const Text(

                        "Array Creation Lab",

                        style: TextStyle(

                          fontSize:24,

                          fontWeight:FontWeight.bold,

                        ),

                      ),


                    ],

                  ),

                ),





                const SizedBox(height:40),






                // Lesson Card

                Container(

                  margin: const EdgeInsets.symmetric(horizontal:25),

                  padding: const EdgeInsets.all(25),


                  decoration: BoxDecoration(

                    color:Colors.white.withOpacity(0.85),

                    borderRadius:BorderRadius.circular(25),


                    boxShadow: [

                      BoxShadow(

                        color:Colors.black.withOpacity(0.15),

                        blurRadius:15,

                        offset:const Offset(0,8),

                      )

                    ],


                  ),



                  child:Column(

                    children: [



                      const Icon(

                        Icons.business,

                        size:80,

                        color:Colors.orange,

                      ),




                      const SizedBox(height:20),





                      const Text(

                        "Welcome Engineer!",

                        style:TextStyle(

                          fontSize:26,

                          fontWeight:FontWeight.bold,

                        ),

                      ),






                      const SizedBox(height:15),





                      const Text(

                        "You have entered the Array Creation Lab.\n\n"

                        "In this lesson you will understand:\n\n"

                        "• What is an Array?\n"

                        "• How arrays are created\n"

                        "• How memory stores array elements\n\n"

                        "Complete the lesson and unlock the next level!",


                        textAlign:TextAlign.center,


                        style:TextStyle(

                          fontSize:16,

                        ),

                      ),


                    ],

                  ),


                ),







                const Spacer(),





                Padding(

                  padding:const EdgeInsets.all(25),


                  child:SizedBox(

                    width:double.infinity,


                    child:ElevatedButton(


                      onPressed:(){


                        ScaffoldMessenger.of(context)

                        .showSnackBar(

                          const SnackBar(

                            content:Text(

                              "Learn Module coming next 🚀",

                            ),

                          ),

                        );


                      },



                      style:ElevatedButton.styleFrom(

                        backgroundColor:Colors.orange,

                        padding:const EdgeInsets.all(18),


                        shape:RoundedRectangleBorder(

                          borderRadius:BorderRadius.circular(30),

                        ),


                      ),



                      child:const Text(

                        "START LEARNING →",

                        style:TextStyle(

                          color:Colors.white,

                          fontSize:18,

                          fontWeight:FontWeight.bold,

                        ),

                      ),



                    ),


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