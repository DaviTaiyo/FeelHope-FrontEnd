import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
        children: [
          SizedBox(height: 50,),
          Text("Feel Hope", style: TextStyle(color: Colors.purple, fontSize: 40, fontWeight: FontWeight.bold),),
          Text("Vai se tratar main yasuo dos infernos")
        ],
            ),
      ),
    );
  }
}