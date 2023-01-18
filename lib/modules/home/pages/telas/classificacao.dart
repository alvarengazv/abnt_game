import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  @override
  Widget build(BuildContext context) {
    return Text("ABNT Play CLASSIFICAÇÃO", 
        style: TextStyle(
          color: Color.fromARGB(255, 64, 1, 53),
          fontSize: 30
        ),
    );
  }
}