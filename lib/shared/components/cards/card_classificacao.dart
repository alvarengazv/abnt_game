import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardClassificacao extends StatefulWidget {
  final int classificacao;
  final String nome;
  final String pontuacao;
  bool? isUser;

  CardClassificacao(
      {super.key,
      required this.classificacao,
      required this.nome,
      this.isUser = false,
      required this.pontuacao});

  @override
  State<CardClassificacao> createState() => _CardClassificacaoState();
}

class _CardClassificacaoState extends State<CardClassificacao> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      color: widget.isUser == true ? lilas : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        radius: 200,
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        highlightColor: Color.fromARGB(255, 243, 207, 243),
        splashColor: lilas.withAlpha(50),
        child: ListTile(
          leading: SizedBox(
            width: size.width * 0.46,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.classificacao.toString(),
                    style: TextStyle(
                        fontFamily: "BebasNeue",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: widget.classificacao == 1
                            ? ouro
                            : widget.classificacao == 2
                                ? prata
                                : widget.classificacao == 3
                                    ? bronze
                                    : roxoClassificacao),
                  ),
                ),
                const CircleAvatar(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.nome,
                    style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          trailing: Text(
            "${widget.pontuacao} XP",
            style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w900,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
