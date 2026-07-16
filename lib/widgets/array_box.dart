import 'package:flutter/material.dart';


class ArrayBox extends StatelessWidget {


  final int index;

  final int? value;

  final bool highlighted;



  const ArrayBox({

    super.key,

    required this.index,

    required this.value,

    required this.highlighted,

  });





  @override
  Widget build(BuildContext context) {


    return Container(

      margin:

      const EdgeInsets.all(8),



      child:

      Column(

        children:[



          // INDEX LABEL

          Container(

            padding:

            const EdgeInsets.symmetric(

              horizontal:10,

              vertical:4,

            ),



            decoration:

            BoxDecoration(

              color:

              Colors.white,

              borderRadius:

              BorderRadius.circular(12),

            ),



            child:

            Text(

              "Index $index",


              style:

              const TextStyle(

                fontWeight:

                FontWeight.bold,

                fontSize:12,

              ),

            ),

          ),





          const SizedBox(height:8),






          // ARRAY BOX

          AnimatedContainer(

            duration:

            const Duration(

              milliseconds:300,

            ),



            height:65,

            width:65,



            alignment:

            Alignment.center,



            decoration:

            BoxDecoration(

              color:

              highlighted

              ?

              Colors.orange

              :

              Colors.blueAccent,



              borderRadius:

              BorderRadius.circular(18),



              boxShadow:[



                BoxShadow(

                  blurRadius:12,

                  color:

                  Colors.black.withOpacity(.3),

                )


              ],

            ),




            child:

            Text(

              value==null

              ?

              "∅"

              :

              value.toString(),



              style:

              const TextStyle(

                color:Colors.white,

                fontSize:22,

                fontWeight:

                FontWeight.bold,

              ),

            ),


          ),


        ],


      ),


    );


  }


}