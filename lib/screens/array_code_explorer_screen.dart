import 'package:flutter/material.dart';
import '../utils/progress.dart';
import 'array_building_screen.dart';


class CodeExplorerScreen extends StatefulWidget {

  const CodeExplorerScreen({super.key});

  @override
  State<CodeExplorerScreen> createState() =>
      _CodeExplorerScreenState();

}



class _CodeExplorerScreenState 
extends State<CodeExplorerScreen> {


  int selectedLine = 0;


  final List<Map<String,String>> codeLines = [


    {
      "code":"int[] arr = new int[5];",
      "explanation":
      "Creates an integer array with 5 empty spaces."
    },


    {
      "code":"arr[0] = 10;",
      "explanation":
      "Stores 10 at the first index."
    },


    {
      "code":"arr[1] = 20;",
      "explanation":
      "Stores 20 at index 1."
    },


    {
      "code":"System.out.println(arr[0]);",
      "explanation":
      "Displays the value stored at index 0."
    },


  ];



  void completeLearn(){

    Progress.arrayLearnCompleted = true;

    Progress.arrayAnimateUnlocked = true;


    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder:(context)=>
        const ArrayBuildingScreen(),

      ),

    );

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Java Code Explorer",
        ),

      ),



      body:Padding(

        padding:
        const EdgeInsets.all(16),


        child:Column(

          children:[


            Container(

              padding:
              const EdgeInsets.all(15),


              decoration:BoxDecoration(

                color:Colors.black87,

                borderRadius:
                BorderRadius.circular(20),

              ),



              child:Column(

                children:[


                  const Text(

                    "ArrayCreation.java",

                    style:TextStyle(

                      color:Colors.greenAccent,

                      fontSize:18,

                    ),

                  ),



                  const SizedBox(height:15),




                  ...List.generate(

                    codeLines.length,


                    (index){


                      return GestureDetector(


                        onTap:(){

                          setState((){

                            selectedLine=index;

                          });

                        },



                        child:Container(

                          padding:
                          const EdgeInsets.symmetric(
                            vertical:10,
                          ),



                          color:
                          selectedLine==index
                          ?
                          Colors.blue.withValues(alpha: .3)
                          :
                          Colors.transparent,



                          child:Row(

                            children:[


                              Text(

                                "${index+1}",

                                style:
                                const TextStyle(

                                  color:Colors.grey,

                                  fontFamily:
                                  "monospace",

                                ),

                              ),



                              const SizedBox(width:15),



                              Expanded(

                                child:Text(

                                  codeLines[index]["code"]!,

                                  style:
                                  const TextStyle(

                                    color:
                                    Colors.white,

                                    fontFamily:
                                    "monospace",

                                    fontSize:16,

                                  ),

                                ),

                              )


                            ],

                          ),


                        ),


                      );


                    },


                  )

                ],


              ),


            ),




            const SizedBox(height:20),





            Expanded(

              child:Container(

                padding:
                const EdgeInsets.all(20),


                decoration:BoxDecoration(

                  color:
                  Colors.orange.shade50,

                  borderRadius:
                  BorderRadius.circular(20),

                ),



                child:Text(

                  codeLines[selectedLine]
                  ["explanation"]!,


                  style:
                  const TextStyle(

                    fontSize:18,

                  ),

                ),

              ),

            ),




            const SizedBox(height:15),





            ElevatedButton(

              onPressed:
              completeLearn,



              style:
              ElevatedButton.styleFrom(

                backgroundColor:
                Colors.orange,


                minimumSize:
                const Size(
                  double.infinity,
                  55,
                ),

              ),



              child:
              const Text(

                "DONE / NEXT →",

                style:

                TextStyle(

                  color:Colors.white,

                  fontSize:18,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),


            )


          ],

        ),

      ),

    );

  }

}