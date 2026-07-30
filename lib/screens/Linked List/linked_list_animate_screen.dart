import 'package:flutter/material.dart';

import '../../utils/progress.dart';
import 'linked_list_building_screen.dart';

class LinkedListAnimateScreen extends StatefulWidget {
  const LinkedListAnimateScreen({super.key});

  @override
  State<LinkedListAnimateScreen> createState() =>
      _LinkedListAnimateScreenState();
}

class _LinkedListAnimateScreenState
    extends State<LinkedListAnimateScreen> {
  List<int?> linkedList = [];

  bool linkedListCreated = false;

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

  Future<void> createLinkedList() async {
    int? size = await askNumber(
      "Create Linked List",
      "Enter number of nodes",
    );

    if (size == null || size <= 0) {
      return;
    }

    setState(() {
      linkedList = List.generate(
        size,
        (index) => null,
      );

      linkedListCreated = true;
      highlightedIndex = null;
    });
  }

  Future<void> addValue() async {
    if (!linkedListCreated) return;

    int? index = await askNumber(
      "Add Node",
      "Enter node position",
    );

    if (index == null ||
        index < 0 ||
        index >= linkedList.length) {
      return;
    }

    int? value = await askNumber(
      "Add Node",
      "Enter node value",
    );

    if (value == null) return;

    setState(() {
      linkedList[index] = value;
    });
  }

  Future<void> deleteValue() async {
    if (!linkedListCreated) return;

    int? index = await askNumber(
      "Delete Node",
      "Enter node position",
    );

    if (index == null ||
        index < 0 ||
        index >= linkedList.length) {
      return;
    }

    setState(() {
      linkedList[index] = null;
    });
  }

  Future<void> traverse() async {
    if (!linkedListCreated) return;

    int? index = await askNumber(
      "Traverse Linked List",
      "Enter node position",
    );

    if (index == null ||
        index < 0 ||
        index >= linkedList.length) {
      return;
    }

    if (linkedList[index] == null) {
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
    Progress.markLinkedListAnimateCompleted();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LinkedListBuildingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF4FF),
      appBar: AppBar(
        title: const Text("Animate Linked List"),
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
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
                      "Linked List Canvas",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ScrollConfiguration(
                        behavior:
                            ScrollBehavior().copyWith(
                          overscroll: false,
                        ),
                        child: SingleChildScrollView(
                          physics:
                              const ClampingScrollPhysics(),
                          child: Center(
                            child: _buildLinkedListCanvas(),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    color: linkedListCreated
                        ? Colors.grey
                        : Colors.green,
                    onTap: linkedListCreated
                        ? null
                        : createLinkedList,
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
                  icon: const Icon(
                    Icons.check_circle,
                  ),
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
                  onPressed: finishModule,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedListCanvas() {
    if (!linkedListCreated) {
      return const Text(
        "Create a linked list to begin",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    if (linkedList.isEmpty) {
      return const Text(
        "HEAD → NULL",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeadLabel(),
          _buildArrow(),

          for (int i = 0; i < linkedList.length; i++) ...[
            LinkedListNodeBox(
              value: linkedList[i],
              highlighted:
                  highlightedIndex == i,
              index: i,
            ),

            if (i != linkedList.length - 1)
              _buildArrow(),
          ],

          _buildArrow(),
          _buildNullBox(),
        ],
      ),
    );
  }

  Widget _buildHeadLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "HEAD",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.arrow_forward,
        size: 30,
        color: Colors.green,
      ),
    );
  }

  Widget _buildNullBox() {
    return Container(
      width: 75,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
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

class LinkedListNodeBox extends StatelessWidget {
  final int? value;
  final bool highlighted;
  final int index;

  const LinkedListNodeBox({
    super.key,
    required this.value,
    required this.highlighted,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      width: 95,
      height: 75,
      decoration: BoxDecoration(
        color: highlighted
            ? Colors.yellow.shade600
            : value == null
                ? Colors.grey.shade300
                : Colors.green,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: highlighted
              ? Colors.orange
              : Colors.green.shade700,
          width: highlighted ? 4 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              highlighted ? .18 : .08,
            ),
            blurRadius: highlighted ? 10 : 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Node $index",
            style: TextStyle(
              color: value == null
                  ? Colors.grey.shade700
                  : Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value == null ? "EMPTY" : "$value",
            style: TextStyle(
              color: value == null
                  ? Colors.grey.shade800
                  : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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