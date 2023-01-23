import 'dart:io';

import 'package:abntplaybic/modules/atividades/pages/subtopicos_tela.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainAtividadesPage extends StatefulWidget {
  const MainAtividadesPage({super.key});

  @override
  State<MainAtividadesPage> createState() => _MainAtividadesPageState();
}

class _MainAtividadesPageState extends State<MainAtividadesPage> {
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
          title: const Text(
            "Trabalhos Acadêmicos",
            style: TextStyle(
              color: roxo,
              fontFamily: "PassionOne",
              fontSize: 30,
            ),
          ),
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.19,
                    decoration: const BoxDecoration(
                      color: lilas,
                    ),
                    /*child: Image.asset( ),*/
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        InkWell(
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
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          child: Text(
                                            "Tarefa Geral em Trabalhos Acadêmicos",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "PassionOne",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
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
                                                    BorderRadius.circular(13),
                                              ),
                                              fixedSize:
                                                  Size(size.width * 0.9, 50),
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SubTopicosPage()));
                                              
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: const ListTile(
                            title: Text(
                              "Geral",
                              style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const ListTile(
                            title: Text(
                              "Capa",
                              style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const ListTile(
                            title: Text(
                              "Paginação",
                              style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
