import 'package:flutter/material.dart';

import '../../utils/progress.dart';
import 'linked_list_learn_screen.dart';
import 'linked_list_animate_screen.dart';
import 'linked_list_master_screen.dart';

class LinkedListBuildingScreen extends StatelessWidget {
  const LinkedListBuildingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                "lib/assets/lam_building.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),

            // DARK OVERLAY
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.20),
              ),
            ),

            SafeArea(
              child: SizedBox.expand(
                child: Stack(
                  children: [
                    // FLOOR 3 - MASTER
                    Positioned(
                      top: 120,
                      left: 25,
                      right: 25,
                      child: FloorCard(
                        floor: "Floor 3",
                        title: "MASTER",
                        subtitle: Progress.linkedListAnimateCompleted
                            ? "Practice & Challenges"
                            : "Complete Animate First 🔒",
                        unlocked: Progress.linkedListMasterUnlocked,
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const LinkedListMasterScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                    // FLOOR 2 - ANIMATE
                    Positioned(
                      top: 310,
                      left: 25,
                      right: 25,
                      child: FloorCard(
                        floor: "Floor 2",
                        title: "ANIMATE",
                        subtitle: Progress.linkedListAnimateCompleted
                            ? "Completed ✅"
                            : Progress.linkedListAnimateUnlocked
                                ? "Interactive Visualizations"
                                : "Complete Learn First 🔒",
                        unlocked:
                            Progress.linkedListAnimateUnlocked,
                        completed:
                            Progress.linkedListAnimateCompleted,
                        color: Colors.blue,
                        onTap: Progress.linkedListAnimateUnlocked
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LinkedListAnimateScreen(),
                                  ),
                                );
                              }
                            : () {},
                      ),
                    ),

                    // FLOOR 1 - LEARN
                    Positioned(
                      top: 500,
                      left: 25,
                      right: 25,
                      child: FloorCard(
                        floor: "Floor 1",
                        title: "LEARN",
                        subtitle: Progress.linkedListLearnCompleted
                            ? "Completed ✅"
                            : "Theory + Code Explorer",
                        unlocked: true,
                        completed:
                            Progress.linkedListLearnCompleted,
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LinkedListLearnScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloorCard extends StatelessWidget {
  final String floor;
  final String title;
  final String subtitle;
  final bool unlocked;
  final bool completed;
  final Color color;
  final VoidCallback onTap;

  const FloorCard({
    super.key,
    required this.floor,
    required this.title,
    required this.subtitle,
    required this.unlocked,
    required this.color,
    required this.onTap,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unlocked ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.90),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: completed ? Colors.green : Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,
              child: Text(
                floor.replaceAll("Floor ", ""),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
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