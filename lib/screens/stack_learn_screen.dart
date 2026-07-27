import 'package:flutter/material.dart';
import 'stack_code_explorer_screen.dart';


class StackLearnScreen extends StatelessWidget {
  const StackLearnScreen({super.key});



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(

          "Learn - Stack Creation",

        ),

        centerTitle: true,

      ),




      body: Container(


        width: double.infinity,

        height: double.infinity,



        decoration: const BoxDecoration(


          gradient: LinearGradient(

            colors: [

              Color(0xffe3f2fd),

              Color(0xfff1f8e9),

            ],


            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

          ),

        ),




        child: Padding(

          padding: const EdgeInsets.all(20),



          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [



              // TITLE

              const Text(

                "What is a Stack?",


                style: TextStyle(

                  fontSize:30,

                  fontWeight:FontWeight.bold,

                ),

              ),





              const SizedBox(height:20),





              // THEORY CARD

              Container(


                padding:const EdgeInsets.all(20),




                decoration:BoxDecoration(


                  color:Colors.white.withOpacity(0.9),


                  borderRadius:BorderRadius.circular(25),



                  boxShadow:[


                    BoxShadow(

                      color:Colors.black.withOpacity(0.15),

                      blurRadius:15,

                      offset:const Offset(0,8),

                    )


                  ],



                ),




                child:const Text(


                  "A stack is a linear data structure that stores "
                  "elements in a specific order following the "
                  "Last In, First Out (LIFO) principle.\n\n"

                  "Elements are added using the Push operation "
                  "and removed using the Pop operation.\n\n"


                 "In Java, all insertion and deletion operations "
                 "take place only at the top of the stack.",

                  style: TextStyle(

                    fontSize: 17,

                    height: 1.5,

                  ),


                ),



              ),






              const SizedBox(height:30),






              // STACK VISUALIZATION TITLE

              const Text(

                "Stack Memory View",

                style:TextStyle(

                  fontSize:22,

                  fontWeight:FontWeight.bold,

                ),

              ),





              const SizedBox(height:15),

// STACK BOXES

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [

      const Text(
        "TOP",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),

      const SizedBox(height: 10),

      stackCell("40"),
      const SizedBox(height: 8),

      stackCell("30"),
      const SizedBox(height: 8),

      stackCell("20"),
      const SizedBox(height: 8),

      stackCell("10"),

      const SizedBox(height: 10),

      const Text(
        "BOTTOM",
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20),



              // NEXT BUTTON


              Align(


                alignment:Alignment.centerRight,



                child:SizedBox(


                  width:65,

                  height:65,



                  child:FloatingActionButton(


                    backgroundColor:Colors.orange,


                    onPressed:(){



                      Navigator.push(


                        context,


                        MaterialPageRoute(


                          builder:(context)


                          =>const StackCodeExplorerScreen(),


                        ),


                      );


                    },




                    child:const Icon(


                      Icons.arrow_forward,


                      size:35,


                    ),


                  ),



                ),


              )




            ],


          ),


        ),


     ),


    );


  }





  Widget stackCell(String value) {
    return Container(


      width:55,

      height:55,



      alignment:Alignment.center,



      decoration:BoxDecoration(

        color:Colors.orange,

        borderRadius:BorderRadius.circular(12),

      ),



      child:Text(

        value,


        style:const TextStyle(

          color:Colors.white,

          fontSize:20,

          fontWeight:FontWeight.bold,

        ),

      ),



    );


  }



}
