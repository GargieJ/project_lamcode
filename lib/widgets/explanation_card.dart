import 'package:flutter/material.dart';



class ExplanationCard extends StatelessWidget {


  final String title;

  final String description;



  const ExplanationCard({

    super.key,

    required this.title,

    required this.description,

  });



  @override
  Widget build(BuildContext context) {


    return Container(


      margin:

      const EdgeInsets.all(15),



      padding:

      const EdgeInsets.all(18),



      decoration:

      BoxDecoration(


        color:Colors.white,


        borderRadius:

        BorderRadius.circular(20),



        boxShadow:[


          BoxShadow(

            blurRadius:12,

            color:

            Colors.black.withValues(alpha: .15),

          )

        ],


      ),



      child:

      Column(


        crossAxisAlignment:

        CrossAxisAlignment.start,



        children:[



          Text(

            title,


            style:

            const TextStyle(

              fontSize:22,

              fontWeight:FontWeight.bold,

            ),

          ),



          const SizedBox(height:10),



          Text(

            description,


            style:

            const TextStyle(

              fontSize:15,

            ),

          )


        ],


      ),


    );


  }


}