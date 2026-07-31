import 'package:flutter/material.dart';

import '../../utils/progress.dart';
import 'stack_building_screen.dart';

class StackAnimateScreen extends StatefulWidget {
  const StackAnimateScreen({super.key});

  @override
  State<StackAnimateScreen> createState() =>
      _StackAnimateScreenState();
}

class _StackAnimateScreenState extends State<StackAnimateScreen> {
  // ==========================================================
  // STACK DATA
  // ==========================================================

  final List<int> stack = [];

  int? capacity;

  bool stackCreated = false;

  bool showCreateInput = false;
  bool showPushInput = false;
  bool showStackDetails = false;

  String message = "";

  final TextEditingController capacityController =
      TextEditingController();

  final TextEditingController valueController =
      TextEditingController();

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    capacityController.dispose();
    valueController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef4ff),

      appBar: AppBar(
        title: const Text(
          "Animate Stack",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [

            // ==================================================
            // MESSAGE
            // ==================================================

            if (message.isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(
                  12,
                  10,
                  12,
                  0,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // ==================================================
            // STACK CANVAS
            // ==================================================

            Expanded(
              child: Center(
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withValues(alpha: 0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      // ----------------------------------------
                      // CANVAS TITLE
                      // ----------------------------------------

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [

                          const Text(
                            "Stack Canvas",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          if (stackCreated)
                            Text(
                              "${stack.length}/${capacity ?? 0}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ----------------------------------------
                      // STACK
                      // ----------------------------------------

                      Expanded(
                        child: _buildStackCanvas(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ==================================================
            // CREATE INPUT
            // ==================================================

            if (showCreateInput)
              _buildInputPanel(
                title: "Create Stack",
                hint: "Enter stack capacity",
                controller: capacityController,
                buttonText: "CREATE STACK",
                buttonColor: Colors.green,
                onSubmit: _confirmCreateStack,
                onCancel: () {
                  setState(() {
                    showCreateInput = false;
                    capacityController.clear();
                  });
                },
              ),

            // ==================================================
            // PUSH INPUT
            // ==================================================

            if (showPushInput)
              _buildInputPanel(
                title: "Push Element",
                hint: "Enter value",
                controller: valueController,
                buttonText: "PUSH",
                buttonColor: Colors.blue,
                onSubmit: _confirmPush,
                onCancel: () {
                  setState(() {
                    showPushInput = false;
                    valueController.clear();
                  });
                },
              ),

            // ==================================================
            // SHOW STACK DETAILS
            // ==================================================

            if (showStackDetails)
              _buildStackDetails(),

            // ==================================================
            // CREATE + PUSH
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: _actionButton(
                      label: "CREATE",
                      icon: Icons.add_box,
                      color: Colors.green,
                      onPressed: stackCreated
                          ? null
                          : _startCreate,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _actionButton(
                      label: "PUSH",
                      icon: Icons.arrow_upward,
                      color: Colors.blue,
                      onPressed: stackCreated
                          ? _startPush
                          : null,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // POP + DELETE
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: _actionButton(
                      label: "POP",
                      icon: Icons.arrow_downward,
                      color: Colors.orange,
                      onPressed:
                          stackCreated && stack.isNotEmpty
                              ? _pop
                              : null,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _actionButton(
                      label: "DELETE",
                      icon: Icons.delete,
                      color: Colors.red,
                      onPressed:
                          stackCreated ? _deleteStack : null,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // SHOW STACK
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed:
                      stackCreated ? _showStack : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        Colors.grey.shade300,
                    disabledForegroundColor:
                        Colors.grey.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.visibility),
                  label: const Text(
                    "SHOW STACK",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // RESET
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _reset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(
                      color: Colors.black26,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    "RESET",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // DONE
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _done,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle),
                  label: const Text(
                    "DONE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // STACK CANVAS
  // ==========================================================

  Widget _buildStackCanvas() {
    if (!stackCreated) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              Icons.layers_outlined,
              size: 60,
              color: Colors.grey,
            ),

            SizedBox(height: 12),

            Text(
              "No Stack Created",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),

            SizedBox(height: 5),

            Text(
              "Tap CREATE to begin",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        const Text(
          "TOP",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: stack.isEmpty
              ? const Center(
                  child: Text(
                    "Stack is Empty",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      ...stack.reversed.map(
                        (value) => _stackBox(value),
                      ),
                    ],
                  ),
                ),
        ),

        const SizedBox(height: 8),

        Container(
          width: 170,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "BOTTOM",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // STACK BOX
  // ==========================================================

  Widget _stackBox(int value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 150,
      height: 54,
      margin: const EdgeInsets.only(bottom: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // INPUT PANEL
  // ==========================================================

  Widget _buildInputPanel({
    required String title,
    required String hint,
    required TextEditingController controller,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onSubmit,
    required VoidCallback onCancel,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        12,
        0,
        12,
        8,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
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

          const SizedBox(height: 10),

          TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              Expanded(
                child: SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                height: 46,
                child: OutlinedButton(
                  onPressed: onCancel,
                  child: const Text("CANCEL"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STACK DETAILS
  // ==========================================================

  Widget _buildStackDetails() {
    final String valueText = stack.isEmpty
        ? "Empty"
        : stack.reversed.join(" → ");

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        12,
        0,
        12,
        8,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Text(
            "TOP → BOTTOM",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            valueText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "Size: ${stack.length}/${capacity ?? 0}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTION BUTTON
  // ==========================================================

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor:
              Colors.grey.shade300,
          disabledForegroundColor:
              Colors.grey.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // START CREATE
  // ==========================================================

  void _startCreate() {
    setState(() {
      showCreateInput = true;
      showPushInput = false;
      showStackDetails = false;
      message = "";
    });
  }

  // ==========================================================
  // CONFIRM CREATE
  // ==========================================================

  void _confirmCreateStack() {
    final int? value = int.tryParse(
      capacityController.text.trim(),
    );

    if (value == null || value <= 0) {
      setState(() {
        message = "Please enter a valid capacity.";
      });
      return;
    }

    setState(() {
      capacity = value;
      stack.clear();
      stackCreated = true;
      showCreateInput = false;
      showPushInput = false;
      showStackDetails = false;
      message =
          "Stack created with capacity $value.";
    });

    capacityController.clear();
  }

  // ==========================================================
  // START PUSH
  // ==========================================================

  void _startPush() {
    if (!stackCreated) {
      return;
    }

    if (capacity != null &&
        stack.length >= capacity!) {
      setState(() {
        message =
            "Stack Overflow! The stack is full.";
      });
      return;
    }

    setState(() {
      showPushInput = true;
      showCreateInput = false;
      showStackDetails = false;
      message = "";
    });
  }

  // ==========================================================
  // CONFIRM PUSH
  // ==========================================================

  void _confirmPush() {
    final int? value = int.tryParse(
      valueController.text.trim(),
    );

    if (value == null) {
      setState(() {
        message = "Please enter a valid value.";
      });
      return;
    }

    if (capacity != null &&
        stack.length >= capacity!) {
      setState(() {
        showPushInput = false;
        message =
            "Stack Overflow! The stack is full.";
      });
      return;
    }

    setState(() {
      stack.add(value);
      showPushInput = false;
      showStackDetails = false;
      message =
          "$value pushed to the TOP.";
    });

    valueController.clear();
  }

  // ==========================================================
  // POP
  // ==========================================================

  void _pop() {
    if (stack.isEmpty) {
      setState(() {
        message =
            "Stack Underflow! The stack is empty.";
      });
      return;
    }

    final int removedValue = stack.removeLast();

    setState(() {
      showStackDetails = false;
      message =
          "$removedValue popped from the TOP.";
    });
  }

  // ==========================================================
  // DELETE
  // ==========================================================

  void _deleteStack() {
    setState(() {
      stack.clear();
      capacity = null;
      stackCreated = false;
      showCreateInput = false;
      showPushInput = false;
      showStackDetails = false;
      message = "Stack deleted.";
    });

    capacityController.clear();
    valueController.clear();
  }

  // ==========================================================
  // SHOW STACK
  // ==========================================================

  void _showStack() {
    setState(() {
      showStackDetails = !showStackDetails;
      showCreateInput = false;
      showPushInput = false;

      if (showStackDetails) {
        message = "";
      }
    });
  }

  // ==========================================================
  // RESET
  // ==========================================================

  void _reset() {
    setState(() {
      stack.clear();
      capacity = null;
      stackCreated = false;
      showCreateInput = false;
      showPushInput = false;
      showStackDetails = false;
      message = "Stack has been reset.";
    });

    capacityController.clear();
    valueController.clear();
  }

  // ==========================================================
  // DONE
  // ==========================================================

  void _done() {
    if (!stackCreated) {
      setState(() {
        message =
            "Create a stack before completing Animate.";
      });
      return;
    }

    Progress.markStackAnimateCompleted();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const StackBuildingScreen(),
      ),
    );
  }
}