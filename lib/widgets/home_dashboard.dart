import 'package:flutter/material.dart';

import 'continue_learning_card.dart';
import 'stat_card.dart';

class HomeDashboard extends StatelessWidget {
  final VoidCallback onContinue;

  const HomeDashboard({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .95),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withValues(alpha: .08),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.code,
                  color: Colors.blue,
                  size: 34,
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back 👋",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "LamCode",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Learn • Animate • Master",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: const [
              StatCard(
                emoji: "⭐",
                value: "120 XP",
                color: Colors.orange,
              ),
              SizedBox(width: 10),
              StatCard(
                emoji: "🪙",
                value: "45 Coins",
                color: Colors.amber,
              ),
              SizedBox(width: 10),
              StatCard(
                emoji: "🏅",
                value: "1 Badge",
                color: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 20),

          ContinueLearningCard(
            onTap: onContinue,
          ),
        ],
      ),
    );
  }
}