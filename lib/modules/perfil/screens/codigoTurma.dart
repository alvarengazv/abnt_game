import 'package:flutter/material.dart';

import '../../../shared/colors.dart';

class CodigoTurmaScreen extends StatefulWidget {
  const CodigoTurmaScreen({super.key});

  @override
  State<CodigoTurmaScreen> createState() => _CodigoTurmaScreenState();
}

class _CodigoTurmaScreenState extends State<CodigoTurmaScreen> {
  TextEditingController codigo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Possui Turma?",
                style: TextStyle(fontFamily: "PassionOne", fontSize: 32),
              ),
              SizedBox(
                  width: size.width * 0.65,
                  height: size.width * 0.65,
                  child: Image.asset("src/images/coruja_login.png")),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.7,
                child: const Text(
                  "Caso tenha uma turma, que seu professor tenha passado, insira abaixo. Caso não possua turma, apenas pressione continuar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: codigo,
                  style:
                      const TextStyle(fontFamily: "PassionOne", fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: lilas, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: lilas, width: 3)),
                    label: const Text("Código"),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  fixedSize: Size(size.width * 0.65, 62),
                ),
                child: const Text(
                  "Continuar",
                  style: TextStyle(
                      fontFamily: "PassionOne",
                      fontSize: 32,
                      color: Colors.white),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
