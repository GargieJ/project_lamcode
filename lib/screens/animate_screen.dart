import 'package:flutter/material.dart';
import '../widgets/array_box.dart';
import '../utils/progress.dart';
import 'array_building_screen.dart';

class AnimateScreen extends StatefulWidget {
  const AnimateScreen({super.key});

  @override
  State<AnimateScreen> createState() => _AnimateScreenState();
}

class _AnimateScreenState extends State<AnimateScreen> {
  List<int?> array = [];

  bool arrayCreated = false;

  int? highlightedIndex;

  final TextEditingController controller = TextEditingController();

  Future<int?> askNumber(String title, String hint) async {
    controller.clear();

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  int.tryParse(controller.text),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void createArray() async {
    int? size = await askNumber(
      "Create Array",
      "Enter array size",
    );

    if (size == null || size <= 0) return;

    setState(() {
      array = List.generate(size, (index) => null);
      arrayCreated = true;
    });
  }

  void addValue() async {
    if (!arrayCreated) return;

    int? index = await askNumber(
      "Add Element",
      "Enter index",
    );

    if (index == null ||
        index < 0 ||
        index >= array.length) {
      return;
    }

    int? value = await askNumber(
      "Add Element",
      "Enter value",
    );

    if (value == null) return;

    setState(() {
      array[index] = value;
    });
  }

  void deleteValue() async {
    if (!arrayCreated) return;

    int? index = await askNumber(
      "Delete Element",
      "Enter index",
    );

    if (index == null ||
        index < 0 ||
        index >= array.length) {
      return;
    }

    setState(() {
      array[index] = null;
    });
  }

  void traverse() async {
    if (!arrayCreated) return;

    int? index = await askNumber(
      "Traverse Array",
      "Enter index",
    );

    if (index == null ||
        index < 0 ||
        index >= array.length) {
      return;
    }

    setState(() {
      highlightedIndex = index;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {
      highlightedIndex = null;
    });
  }

  void finishModule() {
    Progress.arrayAnimateCompleted = true;
    Progress.arrayMasterUnlocked = true;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ArrayBuildingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF4FF),

      appBar: AppBar(
        title: const Text("Animate Array"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 15),

            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 18),

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 12,
                  ),
                ],
              ),

              child: Column(
                children: [

                  const Text(
                    "Array Canvas",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SingleChildScrollView(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 18,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        array.length,
                        (index) => ArrayBox(
                          index: index,
                          value: array[index],
                          highlighted:
                              highlightedIndex == index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
                        Expanded(
              child: Container(),
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
                    color: arrayCreated
                        ? Colors.grey
                        : Colors.green,
                    onTap: arrayCreated
                        ? null
                        : createArray,
                  ),

                  ActionButton(
                    text: "Add",
                    icon: Icons.add_circle,
                    color: Colors.blue,
                    onTap: addValue,
                  ),

                  ActionButton(
                    text: "Delete",
                    icon: Icons.delete,
                    color: Colors.red,
                    onTap: deleteValue,
                  ),

                  ActionButton(
                    text: "Traverse",
                    icon: Icons.arrow_forward,
                    color: Colors.orange,
                    onTap: traverse,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                20,
              ),

              child: SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
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
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: finishModule,
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
    required this.onTap,
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