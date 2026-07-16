import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {

  final String text;

  final VoidCallback onTap;

  final bool selected;

  final bool correct;

  final bool answered;

  const OptionButton({

    super.key,

    required this.text,

    required this.onTap,

    required this.selected,

    required this.correct,

    required this.answered,

  });

  @override
  Widget build(BuildContext context) {

    Color color = Colors.blue;

    if (answered) {

      if (correct) {

        color = Colors.green;

      }

      else if (selected) {

        color = Colors.red;

      }

      else {

        color = Colors.grey;

      }

    }

    return Padding(

      padding:
          const EdgeInsets.symmetric(vertical: 6),

      child:

      SizedBox(

        width: double.infinity,

        child:

        ElevatedButton(

          onPressed:
              answered
                  ? null
                  : onTap,

          style:

          ElevatedButton.styleFrom(

            backgroundColor: color,

            foregroundColor: Colors.white,

            padding:
                const EdgeInsets.symmetric(
              vertical: 16,
            ),

            shape:

            RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(18),

            ),

          ),

          child:

          Text(

            text,

            style: const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,

            ),

          ),

        ),

      ),

    );

  }

}