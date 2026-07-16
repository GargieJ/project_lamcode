import 'package:flutter/material.dart';


class SideBar extends StatelessWidget {

  const SideBar({super.key});


  @override
  Widget build(BuildContext context) {


    return Container(

      width: 90,

      color: Colors.white,

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          CircleAvatar(

            radius: 28,

            backgroundColor: Colors.orange,

            child: Icon(

              Icons.person,

              color: Colors.white,

              size: 32,

            ),

          ),


          const SizedBox(height:40),



          IconButton(

            icon: Icon(Icons.home),

            iconSize:30,

            onPressed:(){},

          ),



          IconButton(

            icon: Icon(Icons.dashboard),

            iconSize:30,

            onPressed:(){},

          ),



          IconButton(

            icon: Icon(Icons.timeline),

            iconSize:30,

            onPressed:(){},

          ),



          IconButton(

            icon: Icon(Icons.emoji_events),

            iconSize:30,

            onPressed:(){},

          ),



          IconButton(

            icon: Icon(Icons.settings),

            iconSize:30,

            onPressed:(){},

          ),


        ],

      ),

    );


  }

}