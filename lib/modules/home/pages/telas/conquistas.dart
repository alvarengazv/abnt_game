import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConquistasPage extends StatefulWidget {
  const ConquistasPage({super.key});

  @override
  State<ConquistasPage> createState() => _ConquistasPageState();
}

class _ConquistasPageState extends State<ConquistasPage> {
  @override
  Widget build(BuildContext context) {
    return Text("ABNT Play CONQUISTAS", 
        style: TextStyle(
          color: Color.fromARGB(255, 64, 1, 53),
          fontSize: 30
        ),
    );
  }
}