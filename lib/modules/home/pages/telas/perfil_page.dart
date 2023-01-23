import 'package:abntplaybic/modules/home/controllers/editController.dart';
import 'package:abntplaybic/modules/home/pages/telas/editar_perfil.dart';
import 'package:abntplaybic/modules/login/pages/login.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_perfil.dart';
import 'package:abntplaybic/shared/components/cards/card_perfil.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta_confirm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  EditController controller = EditController();

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: controller.getDocsUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              height: size.height,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                              color: primary
                            )
                      ),
                      // child: Image.asset(
                      //   controller. snapshot.data?['imageUrl'] ?? "https://firebasestorage.googleapis.com/v0/b/abnt-play.appspot.com/o/img-default.jpg?alt=media&token=38a51965-25c2-4e93-b484-ab8116cafe27"
                      // ),
                    ),
                    AutoSizeText(
                      snapshot.data!.nome,
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                      maxLines: 1,
                    ),
                    const Text.rich(
                      TextSpan(
                        text: "1200 ",
                        style: TextStyle(
                          fontFamily: "BebasNeue",
                          color: verde,
                          fontSize: 25,
                        ),
                        children: [
                          TextSpan(
                            text: "XP",
                            style: TextStyle(
                              fontFamily: "BebasNeue",
                              color: verde,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: "  -  ",
                            style: TextStyle(
                              fontFamily: "BebasNeue",
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "2º",
                            style: TextStyle(
                              fontFamily: "BebasNeue",
                              color: prata,
                              // widget.classificacao == 1
                              //   ? ouro
                              //   : widget.classificacao == 2
                              //       ? prata
                              //       : widget.classificacao == 3
                              //           ? bronze
                              //           : roxoClassificacao,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 8),
                            child: Text(
                              "ESTATÍSTICAS",
                              style: TextStyle(
                                color: prata,
                                fontFamily: "BebasNeue",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              CardPerfil(
                                title: "MELHOR\nRANKING",
                                text: "1º",
                                bgcolor: laranja,
                              ),
                              CardPerfil(
                                title: "XP\nCOLETADO",
                                text: "14.478",
                                bgcolor: azul,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 1),
                            child: Text(
                              "MINHA CONTA",
                              style: TextStyle(
                                color: prata,
                                fontFamily: "BebasNeue",
                                fontSize: 20,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: BotaoPerfil(
                                  funcaoBotao: () {
                                    alertaConfirmaApp(
                                        context, "Você tem certeza de que deseja sair?",
                                        () async {
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => LoginPage()),
                                        ),
                                        ((route) => false),
                                      );
                                    });
                                  },
                                  icone: Icons.logout,
                                  text: "SAIR",
                                  bgcolor: vermelho,
                                ),
                              ),
                              BotaoPerfil(
                                funcaoBotao: () {
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => EditarPerfilPage()),
                                        ),
                                      );
                                },
                                icone: Icons.edit,
                                text: "EDITAR PERFIL",
                                bgcolor: amarelo,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    ));
  }
}
