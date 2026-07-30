import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../utils/progress.dart';
import 'linked_list_animate_screen.dart';
import 'linked_list_animate_screen.dart';

class LinkedListLearnScreen extends StatelessWidget {
  const LinkedListLearnScreen({super.key});

  void _openAnimate(BuildContext context) {
    // Mark Learn as completed and unlock Animate.
    Progress.markLinkedListLearnCompleted();

    // Open Animate directly.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const LinkedListAnimateScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Learn - Linked List",
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffe3f2fd),
              Color(0xfff1f8e9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "What is a Linked List?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.9),
                  borderRadius:
                      BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.15),
                      blurRadius: 15,
                      offset:
                          const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Text(
                  "A linked list is a linear data structure "
                  "made up of nodes that are connected using "
                  "references.\n\n"
                  "Each node contains two important parts: "
                  "data and a reference to the next node.\n\n"
                  "Unlike an array, linked-list nodes do not "
                  "need to be stored next to each other in memory.",
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Linked List Memory View",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal,
                  child: Row(
                    children: [
                      _buildNode("10"),
                      _buildArrow(),
                      _buildNode("20"),
                      _buildArrow(),
                      _buildNode("30"),
                      _buildArrow(),
                      _buildNull(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "HEAD → 10 → 20 → 30 → NULL",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              // BACK BUTTON
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _openAnimate(context);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                  label: const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange,
                    foregroundColor:
                        Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // OPTIONAL: small clarification
              const Center(
                child: Text(
                  "Continue to Animate",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNode(String value) {
    return Container(
      width: 70,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildArrow() {
    return const Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.arrow_forward,
        size: 30,
        color: Colors.green,
      ),
    );
  }

  Widget _buildNull() {
    return Container(
      width: 70,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: const Text(
        "NULL",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}