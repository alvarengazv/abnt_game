import 'package:abntplaybic/shared/components/normas/linha_folha.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Folha extends StatelessWidget {
  const Folha({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Container(
        height: size.height * 0.4,
        width: size.width * 0.6,
        color: Color(0xffD9D9D9),
        child: Padding(
          padding: EdgeInsets.fromLTRB(size.width * 0.1, size.width * 0.09, size.width * 0.067, size.width * 0.058),
          child: Column(
            children: [
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
              Linha(),
            ],
          ),
        ),
      ),
    );
  }
}
