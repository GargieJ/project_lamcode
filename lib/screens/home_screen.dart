import 'package:flutter/material.dart';
import '../widgets/level_node.dart';
import 'array_map_screen.dart';
import 'stack_building_screen.dart';


class HomeScreen extends StatelessWidget {


  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Stack(


        children: [



          // Silicon Valley map background

          Image.asset(

            "lib/assets/silicon_valley_map.png",

            width: double.infinity,

            height: double.infinity,

            fit: BoxFit.cover,

          ),




          // Arrays - WORKING

          Positioned(

            bottom: 120,

            left: 140,


            child: LevelNode(


              title: "Arrays",

              level: "1",

              color: Colors.orange,

              unlocked: true,



              onTap: (){


                Navigator.push(


                  context,


                  MaterialPageRoute(


                    builder: (context) =>

                    const ArrayMapScreen(),


                  ),


                );


              },


            ),


          ),





          // Linked Lists

          Positioned(

            bottom: 260,

            right: 120,


            child: LevelNode(


              title: "Linked Lists",

              level: "2",

              color: Colors.green,

              unlocked: false,


            ),


          ),





          // Stacks
Positioned(
  bottom: 400,
  left: 130,
  child: LevelNode(
    title: "Stacks",
    level: "3",
    color: Colors.red,
    unlocked: true,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StackBuildingScreen(),
        ),
      );
    },
  ),
),

          // Queues

          Positioned(

            bottom: 540,

            right: 110,


            child: LevelNode(


              title: "Queues",

              level: "4",

              color: Colors.blue,

              unlocked: false,


            ),


          ),





          // Trees

          Positioned(

            bottom: 680,

            left: 150,


            child: LevelNode(


              title: "Trees",

              level: "5",

              color: Colors.teal,

              unlocked: false,


            ),


          ),





          // Graphs

          Positioned(

            bottom: 820,

            right: 120,


            child: LevelNode(


              title: "Graphs",

              level: "6",

              color: Colors.purple,

              unlocked: false,


            ),


          ),





          // Tries

          Positioned(

            bottom: 960,

            left: 140,


            child: LevelNode(


              title: "Tries",

              level: "7",

              color: Colors.indigo,

              unlocked: false,


            ),


          ),



        ],


      ),


    );


  }


}