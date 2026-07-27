import 'package:flutter/material.dart';

class StackBox extends StatelessWidget {
  final int index;
  final int? value;
  final bool? highlighted;

  const StackBox({
    super.key,
    required this.index,
    required this.value,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 55,
      decoration: BoxDecoration(
        color: highlighted == true
            ? Colors.orange
            : value == null
                ? Colors.grey.shade300
                : Colors.blue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          value == null ? "Empty" : value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}