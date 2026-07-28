import 'package:flutter/material.dart';
import 'array_code_explorer_screen.dart';



class ArrayLearnScreen extends StatelessWidget {

  const ArrayLearnScreen({super.key});



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(

          "Learn - Array Creation",

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

                "What is an Array?",


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


                  color:Colors.white.withValues(alpha: 0.9),


                  borderRadius:BorderRadius.circular(25),



                  boxShadow:[


                    BoxShadow(

                      color:Colors.black.withValues(alpha: 0.15),

                      blurRadius:15,

                      offset:const Offset(0,8),

                    )


                  ],



                ),




                child:const Text(


                  "An array is a data structure that stores "

                  "multiple values of the same type in a "

                  "continuous block of memory.\n\n"


                  "Each element in an array has a position "

                  "called an index.\n\n"


                  "In Java, indexing starts from 0.",



                  style:TextStyle(

                    fontSize:17,

                    height:1.5,

                  ),


                ),



              ),






              const SizedBox(height:30),






              // ARRAY VISUALIZATION TITLE

              const Text(

                "Array Memory View",

                style:TextStyle(

                  fontSize:22,

                  fontWeight:FontWeight.bold,

                ),

              ),





              const SizedBox(height:15),






              // ARRAY BOXES

              Container(


                padding:const EdgeInsets.all(20),



                decoration:BoxDecoration(


                  color:Colors.blue.shade50,


                  borderRadius:BorderRadius.circular(20),


                ),




                child:Column(

                  children:[



                    const Row(

                      mainAxisAlignment:

                      MainAxisAlignment.spaceEvenly,


                      children:[


                        Text(

                          "0",

                          style:TextStyle(

                            fontWeight:FontWeight.bold,

                          ),

                        ),


                        Text(

                          "1",

                          style:TextStyle(

                            fontWeight:FontWeight.bold,

                          ),

                        ),


                        Text(

                          "2",

                          style:TextStyle(

                            fontWeight:FontWeight.bold,

                          ),

                        ),


                        Text(

                          "3",

                          style:TextStyle(

                            fontWeight:FontWeight.bold,

                          ),

                        ),



                      ],

                    ),





                    const SizedBox(height:10),






                    Row(

                      mainAxisAlignment:

                      MainAxisAlignment.spaceEvenly,


                      children:[


                        arrayCell("10"),

                        arrayCell("20"),

                        arrayCell("30"),

                        arrayCell("40"),



                      ],


                    )



                  ],

                ),



              ),





              const Spacer(),





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


                          =>const CodeExplorerScreen(),


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





  Widget arrayCell(String value){


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
