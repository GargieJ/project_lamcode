import 'package:flutter/material.dart';

import '../data/array_questions.dart';
import '../models/question.dart';
import '../widgets/progress_header.dart';
import '../widgets/option_button.dart';
import '../widgets/result_card.dart';
import '../widgets/lesson_complete.dart';

import '../utils/progress.dart';
import 'array_building_screen.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen>
    with SingleTickerProviderStateMixin {

  int currentQuestion = 0;

  int hearts = 3;

  int xp = 0;

  int coins = 0;

  int correctAnswers = 0;

  bool answered = false;

  bool answerCorrect = false;

  int? selectedOption;

  final TextEditingController controller =
      TextEditingController();

  late AnimationController animationController;

  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(

      vsync: this,

      duration: const Duration(milliseconds: 500),

    );

    scaleAnimation = Tween<double>(

      begin: .7,

      end: 1,

    ).animate(

      CurvedAnimation(

        parent: animationController,

        curve: Curves.elasticOut,

      ),

    );
  }

  @override
  void dispose() {

    animationController.dispose();

    controller.dispose();

    super.dispose();
  }

  Question get question =>
      arrayQuestions[currentQuestion];

  double get progress =>

      (currentQuestion + 1) /

          arrayQuestions.length;
 void checkMCQ(int option) {

  if (answered) return;

  selectedOption = option;

  answerCorrect = option == question.correctOption;

  if (answerCorrect) {

    xp += 10;

    coins += 5;

    correctAnswers++;

  } else {

    hearts--;

    if (hearts <= 0) {

      hearts = 0;

      setState(() {});

      showGameOverDialog();

      return;

    }

  }

  answered = true;

  animationController.forward(from: 0);

  setState(() {});

}

  void checkFillBlank() {

  if (answered) return;

  answerCorrect =
      controller.text.trim() ==
      question.answer;

  if (answerCorrect) {

    xp += 10;

    coins += 5;

    correctAnswers++;

  } else {

    hearts--;

    if (hearts <= 0) {

      hearts = 0;

      setState(() {});

      showGameOverDialog();

      return;

    }

  }

  answered = true;

  animationController.forward(from: 0);

  setState(() {});

}

  void nextQuestion() {

    controller.clear();

    selectedOption = null;

    answered = false;

    answerCorrect = false;

    if (currentQuestion ==
        arrayQuestions.length - 1) {

      finishLesson();

      return;
    }

    currentQuestion++;

    setState(() {});
  }
    void finishLesson() async {

  Progress.markMasterCompleted();

  await Future.delayed(
    const Duration(milliseconds: 300),
  );

  if (!mounted) return;

  showBadgeDialog();

  await Future.delayed(
    const Duration(seconds: 2),
  );

  if (!mounted) return;

  Navigator.pushReplacement(

    context,

    MaterialPageRoute(

      builder: (_) => LessonComplete(

        xp: xp,

        coins: coins,

        accuracy:

            correctAnswers *

            100 /

            arrayQuestions.length,

        onContinue: () {

          Navigator.pushAndRemoveUntil(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const ArrayBuildingScreen(),

            ),

            (route) => false,

          );

        },

      ),

    ),

  );

}
    @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(

        elevation: 0,

        centerTitle: true,

        backgroundColor: Colors.white,

        foregroundColor: Colors.black,

        title: const Text(

          "MASTER",

          style: TextStyle(

            fontWeight: FontWeight.bold,

            letterSpacing: 1,

          ),

        ),

      ),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              ProgressHeader(

                hearts: hearts,

                xp: xp,

                coins: coins,

                progress: progress,

              ),

              const SizedBox(height: 30),

              Text(

                "Question ${currentQuestion + 1}/${arrayQuestions.length}",

                style: TextStyle(

                  color: Colors.grey.shade700,

                  fontWeight: FontWeight.bold,

                  fontSize: 18,

                ),

              ),

              const SizedBox(height: 15),

              Expanded(

                child: SingleChildScrollView(

                  child: ScaleTransition(

                    scale: scaleAnimation,

                    child: buildQuestionCard(),

                  ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }  Widget buildQuestionCard() {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:

            BorderRadius.circular(28),

        boxShadow: [

          BoxShadow(

            blurRadius: 18,

            color: Colors.black.withOpacity(.08),

            offset: const Offset(0, 8),

          ),

        ],

      ),

      child: Column(

        crossAxisAlignment:

            CrossAxisAlignment.start,

        children: [

          Text(

            question.question,

            style: const TextStyle(

              fontSize: 24,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 20),

          if (question.code != null)

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.grey.shade100,

                borderRadius:

                    BorderRadius.circular(18),

              ),

              child: Text(

                question.code!,

                style: const TextStyle(

                  fontFamily: "monospace",

                  fontSize: 16,

                ),

              ),

            ),

          const SizedBox(height: 25),

          if (question.type == QuestionType.mcq)

            buildMCQ(),

          if (question.type == QuestionType.fillBlank)

            buildFill(),

          if (question.type == QuestionType.output)

            buildOutput(),

          if (answered)

            ResultCard(

              correct: answerCorrect,

              explanation:

                  question.explanation,

              isLast:

                  currentQuestion ==

                      arrayQuestions.length - 1,

              onNext: nextQuestion,

            ),

        ],

      ),

    );

  }  Widget buildMCQ() {

    return Column(

      children: List.generate(

        question.options!.length,

        (index) {

          return OptionButton(

            text: question.options![index],

            selected: selectedOption == index,

            correct: index == question.correctOption,

            answered: answered,

            onTap: () => checkMCQ(index),

          );

        },

      ),

    );

  }
    void showGameOverDialog() {

    showDialog(

      context: context,

      barrierDismissible: false,

      builder: (context) {

        return AlertDialog(

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(20),

          ),

          title: const Text(
            "💔 Out of Hearts!",
            textAlign: TextAlign.center,
          ),

          content: const Text(

            "Don't worry! Practice makes perfect.\n\n"
            "Restart the lesson and try again.",

            textAlign: TextAlign.center,

          ),

          actions: [

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                  setState(() {

                    hearts = 3;

                    xp = 0;

                    coins = 0;

                    correctAnswers = 0;

                    currentQuestion = 0;

                    answered = false;

                    answerCorrect = false;

                    selectedOption = null;

                    controller.clear();

                  });

                },

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.orange,

                  foregroundColor: Colors.white,

                ),

                child: const Text("Restart"),

              ),

            ),

          ],

        );

      },

    );

  }
  void showBadgeDialog() {

  showDialog(

    context: context,

    barrierDismissible: false,

    builder: (context) {

      return AlertDialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),

        content: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            const Icon(
              Icons.workspace_premium,
              color: Colors.amber,
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(

              "Badge Unlocked!",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),

            ),

            const SizedBox(height: 10),

            const Text(

              "🏅 Array Explorer",

              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),

            ),

            const SizedBox(height: 25),

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context);

              },

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green,

                foregroundColor: Colors.white,

              ),

              child: const Text("Awesome!"),

            ),

          ],

        ),

      );

    },

  );

}
Widget buildFill() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        enabled: !answered,
        decoration: InputDecoration(
          hintText: "Enter your answer",
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),

      const SizedBox(height: 20),

      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: answered ? null : checkFillBlank,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: const Text("Submit"),
        ),
      ),
    ],
  );
}
Widget buildOutput() {
  return Column(
    children: List.generate(
      question.options!.length,
      (index) {
        return OptionButton(
          text: question.options![index],
          selected: selectedOption == index,
          correct: index == question.correctOption,
          answered: answered,
          onTap: () => checkMCQ(index),
        );
      },
    ),
  );
}
    }