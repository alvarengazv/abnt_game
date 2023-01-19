import 'package:flutter/material.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text("Possui Turma?"),
        Image.asset(""),
        const Text(
          "Caso tenha uma turma, que seu professor tenha passado, insira abaixo. Caso não possua turma, apenas pressione continuar.",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        TextFormField(),
        TextButton(
          child: const Text("Continuar"),
          onPressed: () {},
        )
      ],
    ));
  }
}
