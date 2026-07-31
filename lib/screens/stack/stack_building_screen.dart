import 'package:flutter/material.dart';

import '../../utils/progress.dart';
import 'stack_animate_screen.dart';
import 'stack_learn_screen.dart';
import 'stack_master_screen.dart';

class StackBuildingScreen extends StatefulWidget {
  const StackBuildingScreen({super.key});

  @override
  State<StackBuildingScreen> createState() =>
      _StackBuildingScreenState();
}

class _StackBuildingScreenState extends State<StackBuildingScreen> {
  @override
  Widget build(BuildContext context) {
    final bool learnCompleted =
        Progress.stackLearnCompleted;

    final bool animateUnlocked =
        Progress.stackAnimateUnlocked;

    final bool animateCompleted =
        Progress.stackAnimateCompleted;

    final bool masterUnlocked =
        Progress.stackMasterUnlocked;

    final bool masterCompleted =
        Progress.stackMasterCompleted;

    return Scaffold(
      body: Stack(
        children: [
          // =====================================================
          // BACKGROUND
          // =====================================================

          Positioned.fill(
            child: Image.asset(
              "lib/assets/lam_building.png",
              fit: BoxFit.cover,
            ),
          ),

          // =====================================================
          // DARK OVERLAY
          // =====================================================

          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ),

          // =====================================================
          // LAM MODULES
          // =====================================================

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                // Move the complete module upward
                padding: const EdgeInsets.only(
                  top: 120,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    // =================================================
                    // MASTER
                    // =================================================

                    _lamCard(
                      number: "3",
                      title: "MASTER",
                      subtitle: masterCompleted
                          ? "COMPLETED ✓"
                          : masterUnlocked
                              ? "Stack Quiz Challenge"
                              : "Complete Animate First 🔒",
                      color: Colors.purple,
                      unlocked: masterUnlocked,
                      completed: masterCompleted,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StackMasterScreen(),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      },
                    ),

                    // Space between Master and Animate
                    const SizedBox(height: 55),

                    // =================================================
                    // ANIMATE
                    // =================================================

                    _lamCard(
                      number: "2",
                      title: "ANIMATE",
                      subtitle: animateCompleted
                          ? "COMPLETED ✓"
                          : animateUnlocked
                              ? "Push, Pop & Peek"
                              : "Complete Learn First 🔒",
                      color: Colors.blue,
                      unlocked: animateUnlocked,
                      completed: animateCompleted,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StackAnimateScreen(),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      },
                    ),

                    // Space between Animate and Learn
                    const SizedBox(height: 55),

                    // =================================================
                    // LEARN
                    // =================================================

                    _lamCard(
                      number: "1",
                      title: "LEARN",
                      subtitle: learnCompleted
                          ? "COMPLETED ✓"
                          : "Theory + Code Explorer",
                      color: Colors.orange,
                      unlocked: true,
                      completed: learnCompleted,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StackLearnScreen(),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LAM CARD
  // ============================================================

  Widget _lamCard({
    required String number,
    required String title,
    required String subtitle,
    required Color color,
    required bool unlocked,
    required bool completed,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: unlocked ? onTap : null,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.90),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // =====================================================
            // NUMBER
            // =====================================================

            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // =====================================================
            // TITLE + SUBTITLE
            // =====================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: completed
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: completed
                          ? Colors.green.shade700
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}