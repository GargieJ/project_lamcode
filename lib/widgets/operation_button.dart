import 'package:flutter/material.dart';



class OperationButton extends StatelessWidget {


  final String text;

  final Color color;

  final VoidCallback onTap;



  const OperationButton({

    super.key,

    required this.text,

    required this.color,

    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return ElevatedButton(

      style:

      ElevatedButton.styleFrom(

        backgroundColor:color,

        foregroundColor:Colors.white,

        padding:

        const EdgeInsets.symmetric(

          horizontal:18,

          vertical:12,

        ),

      ),



      onPressed:onTap,



      child:

      Text(text),

    );


  }


}