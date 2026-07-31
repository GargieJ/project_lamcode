import 'package:flutter/material.dart';
import '../../utils/progress.dart';
import 'stack_building_screen.dart';

class StackCodeExplorerScreen extends StatefulWidget {
  const StackCodeExplorerScreen({super.key});

  @override
  State<StackCodeExplorerScreen> createState() =>
      _StackCodeExplorerScreenState();
}


class _StackCodeExplorerScreenState
    extends State<StackCodeExplorerScreen> {


  int selectedLine = 0;


 final List<Map<String, String>> codeLines = [

  {
    "code": "Stack<Integer> stack = new Stack<>();",
    "explanation":
        "Creates an empty stack that stores Integer values.",
  },

  {
    "code": "stack.push(10);",
    "explanation":
        "Pushes 10 onto the top of the stack.",
  },

  {
    "code": "stack.push(20);",
    "explanation":
        "Pushes 20 above 10. The newest element is always at the top.",
  },

  {
    "code": "System.out.println(stack.peek());",
    "explanation":
        "Returns the top element without removing it.",
  },

  {
    "code": "stack.pop();",
    "explanation":
        "Removes the top element from the stack.",
  },

];



  void completeLearn(){

    Progress.stackLearnCompleted = true;

    Progress.stackAnimateUnlocked = true;


    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder:(context)=>
        const StackBuildingScreen(),

      ),

    );

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Stack Code Explorer",
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

                    "StackExample.java",

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
                  Colors.red.shade50,

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

               backgroundColor: Colors.red,


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