import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {

  final bool correct;

  final String explanation;

  final VoidCallback onNext;

  final bool isLast;

  const ResultCard({

    super.key,

    required this.correct,

    required this.explanation,

    required this.onNext,

    required this.isLast,

  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(

      duration: const Duration(milliseconds: 500),

      curve: Curves.easeOutBack,

      margin: const EdgeInsets.only(top: 25),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: correct

            ? Colors.green.shade50
            : Colors.red.shade50,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(

          color:
              correct
                  ? Colors.green
                  : Colors.red,

          width: 2,

        ),

      ),

      child: Column(

        children: [

          Icon(

            correct
                ? Icons.celebration
                : Icons.cancel,

            color:
                correct
                    ? Colors.green
                    : Colors.red,

            size: 70,

          ),

          const SizedBox(height: 12),

          Text(

            correct
                ? "Correct! 🎉"
                : "Oops! ❌",

            style: TextStyle(

              color:
                  correct
                      ? Colors.green
                      : Colors.red,

              fontSize: 28,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 12),

          Text(

            explanation,

            textAlign: TextAlign.center,

            style: const TextStyle(

              fontSize: 16,

            ),

          ),

          const SizedBox(height: 25),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              onPressed: onNext,

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green,

                foregroundColor: Colors.white,

                padding: const EdgeInsets.symmetric(

                  vertical: 15,

                ),

                shape: RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(18),

                ),

              ),

              child: Text(

                isLast
                    ? "Finish Lesson"
                    : "Continue",

                style: const TextStyle(

                  fontSize: 18,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }

}