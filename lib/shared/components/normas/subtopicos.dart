import 'package:abntplaybic/shared/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TelaSubtopicos extends StatefulWidget {
  final String titulo;
  final Widget corpo;
  final String descricao;

  const TelaSubtopicos(
      {super.key,
      required this.titulo,
      required this.corpo,
      required this.descricao});

  @override
  State<TelaSubtopicos> createState() => _TelaSubtopicosState();
}

class _TelaSubtopicosState extends State<TelaSubtopicos> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.9,
            child: Text(
              widget.titulo,
              style: const TextStyle(
                fontFamily: "PassionOne",
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: size.width,
            constraints: BoxConstraints(minHeight: size.height * 0.4),
            padding: const EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.center,
              child: widget.corpo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              padding: const EdgeInsets.all(8),
              constraints: BoxConstraints(
                maxWidth: size.width * 0.9,
                minHeight: size.height * 0.19,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.resolveWith((states) => roxo.withOpacity(0.5)),
                    ),
                    child: Scrollbar(
                      radius: Radius.circular(12),
                      trackVisibility: true,
                      controller: _controller,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: AutoSizeText(
                          widget.descricao,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
