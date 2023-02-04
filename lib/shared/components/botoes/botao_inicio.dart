import 'package:abntplaybic/modules/atividades/pages/principal.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta.dart';
import 'package:flutter/material.dart';

class BotaoInicio extends StatefulWidget {
  final Map<String, String> data;
  final bool desbloqueado;
  const BotaoInicio({super.key, required this.data, this.desbloqueado = true});

  @override
  State<BotaoInicio> createState() => _BotaoInicioState();
}

class _BotaoInicioState extends State<BotaoInicio> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.data["titulo"] != ""
        ? Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 180,
            width: 140,
            child: ElevatedButton(
              onPressed: () => widget.desbloqueado
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainAtividadesPage(
                            // titulo: widget.texto,
                            data: widget.data),
                      ),
                    )
                  : alertaApp(
                      context, "Seu professor não liberou essa atividade"),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.desbloqueado ? lilas : prata,
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
                      widget.data["titulo"]!,
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
