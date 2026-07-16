import 'package:flutter/material.dart';

class ProgressHeader extends StatelessWidget {

  final int hearts;
  final int xp;
  final int coins;
  final double progress;

  const ProgressHeader({
    super.key,
    required this.hearts,
    required this.xp,
    required this.coins,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        Row(

          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [

            Row(

              children: [

                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),

                const SizedBox(width: 5),

                Text(
                  "$hearts",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],

            ),

            Row(

              children: [

                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),

                const SizedBox(width: 5),

                Text(
                  "$xp XP",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],

            ),

            Row(

              children: [

                const Icon(
                  Icons.monetization_on,
                  color: Colors.orange,
                ),

                const SizedBox(width: 5),

                Text(
                  "$coins",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],

            ),

          ],

        ),

        const SizedBox(height: 20),

        ClipRRect(

          borderRadius:
              BorderRadius.circular(20),

          child: LinearProgressIndicator(

            value: progress,

            minHeight: 12,

            backgroundColor:
                Colors.grey.shade300,

            valueColor:
                const AlwaysStoppedAnimation(
              Colors.green,
            ),

          ),

        ),

      ],

    );

  }

}