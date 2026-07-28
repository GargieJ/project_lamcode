import 'package:flutter/material.dart';

class LessonComplete extends StatelessWidget {

 final int xp;

final int coins;

final double accuracy;

final String badgeName;

final VoidCallback onContinue;

const LessonComplete({

  super.key,

  required this.xp,

  required this.coins,

  required this.accuracy,

  required this.badgeName,

  required this.onContinue,

});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.green.shade50,

      body: SafeArea(

        child: Center(

          child: Padding(

            padding: const EdgeInsets.all(25),

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                const Icon(

                  Icons.emoji_events,

                  color: Colors.amber,

                  size: 120,

                ),

                const SizedBox(height: 20),

                const Text(

                  "Lesson Complete!",

                  style: TextStyle(

                    fontSize: 34,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                const SizedBox(height: 25),

                Card(

                  elevation: 5,

                  shape: RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(20),

                  ),

                  child: Padding(

                    padding:
                        const EdgeInsets.all(22),

                    child: Column(

                      children: [

                        Text(

                          "⭐ XP Earned : $xp",

                          style: const TextStyle(

                            fontSize: 20,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                        const SizedBox(height: 12),

                        Text(

                          "🪙 Coins : $coins",

                          style: const TextStyle(

                            fontSize: 20,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                        const SizedBox(height: 12),

                        Text(

                          "🎯 Accuracy : ${accuracy.toStringAsFixed(0)}%",

                          style: const TextStyle(

                            fontSize: 20,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                        const SizedBox(height: 18),
                         Text(
                         "🏅 $badgeName Badge Unlocked!",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                         ),
                        ),

                      ],

                    ),

                  ),

                ),

                const SizedBox(height: 35),

                ElevatedButton(

                  onPressed: onContinue,

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green,

                    foregroundColor: Colors.white,

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 50,

                      vertical: 18,

                    ),

                    shape: RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(20),

                    ),

                  ),

                  child: const Text(

                    "Back to Building",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}