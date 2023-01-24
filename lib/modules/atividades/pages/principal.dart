import 'dart:io';

import 'package:abntplaybic/modules/atividades/pages/subtopicos_tela.dart';
import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainAtividadesPage extends StatefulWidget {
  final String titulo;

  const MainAtividadesPage({super.key, required this.titulo});

  @override
  State<MainAtividadesPage> createState() => _MainAtividadesPageState();
}

class _MainAtividadesPageState extends State<MainAtividadesPage> {
  TopicosController _topicosController = TopicosController();
  bool loading = false;
  List<String> listaSubTopicos = [];

  @override
  void initState() {
    super.initState();
    getTopicos();
  }

  getTopicos() async {
    setState(() {
      loading = true;
    });

    listaSubTopicos = await _topicosController.getSubTopicos(widget.titulo);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: roxo,
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
        title: Text(
          widget.titulo,
          style: const TextStyle(
            color: roxo,
            fontFamily: "PassionOne",
            fontSize: 30,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: !loading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: size.width,
                        height: size.height * 0.19,
                        decoration: const BoxDecoration(
                          color: lilas,
                        ),
                        /*child: Image.asset( ),*/
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: ListView.builder(
                          itemCount: listaSubTopicos.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: size.height * 0.35,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 20, 10, 0),
                                              child: AutoSizeText(
                                                "Tarefa ${listaSubTopicos.elementAt(index)} em ${widget.titulo}",
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "PassionOne",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 20),
                                              child: Container(
                                                width: size.width * 0.3,
                                                height: size.width * 0.3,
                                                decoration: const BoxDecoration(
                                                  color: lilas,
                                                ),
                                                /*child: Image.asset( ),*/
                                              ),
                                            ),
                                            Hero(
                                              tag: "botao",
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  ),
                                                  fixedSize: Size(
                                                      size.width * 0.9, 50),
                                                ),
                                                child: const Text(
                                                  "Iniciar",
                                                  style: TextStyle(
                                                      fontFamily: "PassionOne",
                                                      fontSize: 32,
                                                      color: Colors.white),
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SubTopicosPage(
                                                                subTopico: listaSubTopicos.elementAt(index),
                                                                topico: widget.titulo,
                                                              )));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: ListTile(
                                title: Text(
                                  listaSubTopicos.elementAt(index),
                                  style: const TextStyle(
                                    fontFamily: "PassionOne",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
