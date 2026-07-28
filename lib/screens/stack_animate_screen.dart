import 'package:flutter/material.dart';
import '../widgets/stack_box.dart';
import '../utils/progress.dart';
import 'stack_building_screen.dart';

class StackAnimateScreen extends StatefulWidget {
  const StackAnimateScreen({super.key});

  @override
  State<StackAnimateScreen> createState() => _StackAnimateScreenState();
}

class _StackAnimateScreenState extends State<StackAnimateScreen> {
  List<int?> stack = [];

  bool stackCreated = false;

  int? highlightedIndex;

  final TextEditingController controller =
      TextEditingController();



  Future<int?> askNumber(String title, String hint) async {

    controller.clear();

    return showDialog<int>(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text(title),

          content: TextField(

            controller: controller,

            keyboardType:
                TextInputType.number,


            decoration: InputDecoration(

              hintText: hint,

              border:
                  OutlineInputBorder(

                borderRadius:
                    BorderRadius.circular(12),

              ),

            ),

          ),


          actions: [

            TextButton(

              onPressed: () =>
                  Navigator.pop(context),

              child:
                  const Text("Cancel"),

            ),
            ElevatedButton(
               onPressed: () {
               Navigator.pop(
               context,
               int.tryParse(controller.text),
    );
  },
             child: const Text("OK"),
)

          ],

        );

      },

    );

  }

 void createStack() async {
  print("Create pressed");

  int? size = await askNumber(
    "Create Stack",
    "Enter stack size",
  );

  print("Size = $size");

  if (size == null || size <= 0) return;

  setState(() {
    stack = List.generate(size, (_) => null);
    stackCreated = true;
  });

  print(stack.length);
}

void pushValue() async {

  if (!stackCreated) return;

  int? value = await askNumber(
    "Push Element",
    "Enter value",
  );

  if (value == null) return;

  int index = stack.indexOf(null);

  if (index == -1) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Stack Overflow"),
      ),
    );
    return;
  }

  setState(() {
    stack[index] = value;
  });
}

void popValue() {

  if (!stackCreated) return;

  for (int i = stack.length - 1; i >= 0; i--) {

    if (stack[i] != null) {

      setState(() {
        stack[i] = null;
      });

      return;
    }
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Stack Underflow"),
    ),
  );
}

void peekValue() async {

  if (!stackCreated) return;

  for (int i = stack.length - 1; i >= 0; i--) {

    if (stack[i] != null) {

      setState(() {
        highlightedIndex = i;
      });

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      setState(() {
        highlightedIndex = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Top Element = ${stack[i]}"),
        ),
      );

      return;
    }
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Stack is Empty"),
    ),
  );
}
  void finishModule() {

  Progress.stackAnimateCompleted = true;

  Progress.stackMasterUnlocked = true;

  Navigator.pushReplacement(

    context,

    MaterialPageRoute(

      builder: (_) =>
          const StackBuildingScreen(),

    ),

  );

}
@override
void dispose() {
  controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF4FF),
      appBar: AppBar(
        title: const Text("Animate Stack"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Stack Canvas",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            stack.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: StackBox(
                                index: index,
                                value: stack[index],
                                highlighted: highlightedIndex == index,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ActionButton(
                            text: "Create",
                            icon: Icons.add_box_rounded,
                            color: stackCreated ? Colors.grey : Colors.green,
                            onTap: stackCreated ? null : createStack,
                          ),
                          ActionButton(
                            text: "Push",
                            icon: Icons.arrow_upward,
                            color: Colors.blue,
                            onTap: pushValue,
                          ),
                          ActionButton(
                            text: "Pop",
                            icon: Icons.arrow_downward,
                            color: Colors.red,
                            onTap: popValue,
                          ),
                          ActionButton(
                            text: "Peek",
                            icon: Icons.visibility,
                            color: Colors.orange,
                            onTap: peekValue,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            finishModule();
                          },
                          icon: const Icon(Icons.check_circle),
                          label: const Text(
                            "DONE",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
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


class ActionButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return ElevatedButton.icon(

      onPressed: onTap,

      icon: Icon(icon),

      label: Text(text),

      style: ElevatedButton.styleFrom(

        backgroundColor: color,

        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        elevation: 4,

      ),

    );

  }
}