import 'package:abntplaybic/modules/atividades/pages/principal.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BotaoInicio extends StatefulWidget {
  final String texto;

  const BotaoInicio(
      {super.key, required this.texto});

  @override
  State<BotaoInicio> createState() => _BotaoInicioState();
}

class _BotaoInicioState extends State<BotaoInicio> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.texto != ""
        ? Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 180,
            width: 140,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainAtividadesPage(
                    titulo: widget.texto,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: lilas,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      widget.texto,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "PassionOne",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ))
        : const SizedBox(
            height: 180,
            width: 140,
          );
  }
}
