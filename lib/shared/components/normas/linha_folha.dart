import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Linha extends StatelessWidget {
  const Linha({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        color: Color(0xff959595),
        height: size.height * 0.005,
        width: size.width * 0.5,
      ),
    );
  }
}
