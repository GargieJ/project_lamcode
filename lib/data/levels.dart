import 'package:flutter/material.dart';


class DSLevel {

  final String name;
  final String level;
  final Color color;
  final bool unlocked;


  DSLevel({

    required this.name,

    required this.level,

    required this.color,

    this.unlocked = false,

  });

}



final List<DSLevel> dsLevels = [


  DSLevel(
    name: "Arrays",
    level: "1",
    color: Colors.orange,
    unlocked: true,
  ),


  DSLevel(
    name: "Linked Lists",
    level: "2",
    color: Colors.green,
  ),


  DSLevel(
    name: "Stacks",
    level: "3",
    color: Colors.red,
  ),


  DSLevel(
    name: "Queues",
    level: "4",
    color: Colors.blue,
  ),


  DSLevel(
    name: "Trees",
    level: "5",
    color: Colors.teal,
  ),


  DSLevel(
    name: "Graphs",
    level: "6",
    color: Colors.purple,
  ),


  DSLevel(
    name: "Tries",
    level: "7",
    color: Colors.indigo,
  ),


];