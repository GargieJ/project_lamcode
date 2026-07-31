import 'package:flutter/material.dart';

import '../../utils/progress.dart';
import 'stack_building_screen.dart';

class StackLearnScreen extends StatefulWidget {
  const StackLearnScreen({super.key});

  @override
  State<StackLearnScreen> createState() => _StackLearnScreenState();
}

class _StackLearnScreenState extends State<StackLearnScreen> {
  int currentPage = 0;

  final PageController pageController = PageController();

  void nextPage() {
  if (currentPage < 3) {
    setState(() {
      currentPage++;
    });

    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  } else {
    // Mark Stack Learn as completed
    Progress.markStackLearnCompleted();

    // Return to Stack LAM building screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const StackBuildingScreen(),
      ),
    );
  }
}

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Learn - Stack",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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

        child: Column(
          children: [

            // ------------------------------------------------
            // PAGE CONTENT
            // ------------------------------------------------

            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildIntroductionPage(),
                  _buildWorkingPage(),
                  _buildCodePage(),
                  _buildRecapPage(),
                ],
              ),
            ),

            // ------------------------------------------------
            // PAGE INDICATOR
            // ------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.orange
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ------------------------------------------------
            // NEXT BUTTON
            // ------------------------------------------------

            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                0,
                12,
                12,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    currentPage == 3
                        ? "CONTINUE →"
                        : "NEXT →",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================
  // PAGE 1
  // ========================================================

  Widget _buildIntroductionPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "What is a Stack?",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Let's understand the basic idea first.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          _infoCard(
            child: const Text(
              "A stack is a linear data structure that "
              "follows the LIFO principle.\n\n"
              "LIFO means Last In, First Out. This means "
              "the element added last is the first element "
              "to be removed.",
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Why is a Stack Used?",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _bulletCard(
            "To store data in a Last In, First Out order.",
          ),

          _bulletCard(
            "To easily add and remove elements from the TOP.",
          ),

          _bulletCard(
            "To manage temporary data efficiently.",
          ),

          const SizedBox(height: 24),

          const Text(
            "Real-World Examples",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _exampleCard(
            icon: Icons.undo,
            title: "Undo Operation",
            description:
                "The latest action is undone first.",
          ),

          _exampleCard(
            icon: Icons.web,
            title: "Browser History",
            description:
                "Recently visited pages can be accessed first.",
          ),

          _exampleCard(
            icon: Icons.layers,
            title: "Stack of Plates",
            description:
                "The last plate placed on the top is removed first.",
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ========================================================
  // PAGE 2
  // ========================================================

  Widget _buildWorkingPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "How Does a Stack Work?",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "All important operations happen at the TOP.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          _buildStackVisualization(),

          const SizedBox(height: 28),

          _operationCard(
            title: "1. PUSH",
            description:
                "Adds a new element to the TOP of the stack.",
            icon: Icons.arrow_upward,
          ),

          _operationCard(
            title: "2. POP",
            description:
                "Removes the element currently at the TOP.",
            icon: Icons.arrow_downward,
          ),

          _operationCard(
            title: "3. PEEK",
            description:
                "Looks at the TOP element without removing it.",
            icon: Icons.visibility,
          ),

          _operationCard(
            title: "4. isEmpty",
            description:
                "Checks whether the stack contains any elements.",
            icon: Icons.check_circle_outline,
          ),

          const SizedBox(height: 20),

          _infoCard(
            color: const Color(0xfffff3e0),
            child: const Text(
              "Remember:\n\n"
              "The TOP is the only end where we normally "
              "insert and remove elements.",
              style: TextStyle(
                fontSize: 17,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ========================================================
  // PAGE 3
  // ========================================================

  Widget _buildCodePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Stack in Java",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Let's understand the code step by step.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          _codeCard(
            code: "Stack<Integer> stack = new Stack<>();",
          ),

          _stepCard(
            number: "1",
            title: "Create the Stack",
            description:
                "We create an empty Stack that can store "
                "integer values.",
          ),

          _codeCard(
            code: "stack.push(10);\n"
                "stack.push(20);\n"
                "stack.push(30);",
          ),

          _stepCard(
            number: "2",
            title: "Push Elements",
            description:
                "10 is added first, then 20, and finally 30.\n\n"
                "Because 30 was added last, it becomes the TOP.",
          ),

          _buildSmallCodeStack(),

          _codeCard(
            code: "stack.pop();",
          ),

          _stepCard(
            number: "3",
            title: "Pop an Element",
            description:
                "The POP operation removes 30 because it is "
                "currently at the TOP.",
          ),

          _infoCard(
            color: const Color(0xffe8f5e9),
            child: const Text(
              "After POP:\n\n"
              "TOP → 20\n"
              "10 remains at the bottom.\n\n"
              "This is LIFO in action!",
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ========================================================
  // PAGE 4
  // ========================================================

  Widget _buildRecapPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Stack - Quick Recap",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          _infoCard(
            child: const Text(
              "A Stack follows the LIFO principle:\n\n"
              "Last In → First Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 28),

          _recapRow(
            title: "PUSH",
            description:
                "Adds an element to the TOP.",
          ),

          _recapRow(
            title: "POP",
            description:
                "Removes the TOP element.",
          ),

          _recapRow(
            title: "PEEK",
            description:
                "Views the TOP element.",
          ),

          _recapRow(
            title: "isEmpty",
            description:
                "Checks whether the stack is empty.",
          ),

          const SizedBox(height: 25),

          _infoCard(
            color: const Color(0xfffff3e0),
            child: const Text(
              "You have completed the basic Stack lesson!\n\n"
              "Next, we can explore Stack code and "
              "animations.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ========================================================
  // STACK VISUALIZATION
  // ========================================================

  Widget _buildStackVisualization() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [

          const Text(
            "TOP",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _stackCell("30"),

          _stackCell("20"),

          _stackCell("10"),

          const SizedBox(height: 12),

          const Text(
            "BOTTOM",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCodeStack() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [

          const Text(
            "TOP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          _stackCell("30"),

          _stackCell("20"),

          _stackCell("10"),

          const SizedBox(height: 10),

          const Text(
            "BOTTOM",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================
  // COMMON WIDGETS
  // ========================================================

  Widget _infoCard({
    required Widget child,
    Color color = const Color(0xffffffff),
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _bulletCard(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.orange,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _exampleCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: Icon(
              icon,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _operationCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeCard({
    required String code,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff222222),
        borderRadius: BorderRadius.circular(18),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "monospace",
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _stepCard({
    required String number,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recapRow({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _stackCell(String value) {
    return Container(
      width: 140,
      height: 58,
      margin: const EdgeInsets.only(bottom: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}