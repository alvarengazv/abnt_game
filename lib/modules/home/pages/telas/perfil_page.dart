import 'package:abntplaybic/modules/home/controllers/editController.dart';
import 'package:abntplaybic/modules/home/pages/telas/editar_perfil.dart';
import 'package:abntplaybic/modules/login/pages/login.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_perfil.dart';
import 'package:abntplaybic/shared/components/cards/card_perfil.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta_confirm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  EditController controller = EditController();

  Future<String?> getImage() async {
    return await FirebaseStorage.instance
        .ref("/users/img-default.jpg")
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            height: size.height,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: primary)),
                        child: context
                                    .watch<PerfilProvider>()
                                    .perfilAtual
                                    ?.fotoPerfil ==
                                null
                            ? FutureBuilder<String?>(
                                future: getImage(),
                                builder: (context, snap) {
                                  return snap.hasData
                                      ? Image.network(context
                                              .read<PerfilProvider>()
                                              .perfilAtual
                                              ?.fotoPerfil ??
                                          snap.data!)
                                      : Container();
                                })
                            : Image.network(context
                                .read<PerfilProvider>()
                                .perfilAtual!
                                .fotoPerfil!)
                        // child: Image.asset(
                        //   controller. snapshot.data?['imageUrl'] ?? "https://firebasestorage.googleapis.com/v0/b/abnt-play.appspot.com/o/img-default.jpg?alt=media&token=38a51965-25c2-4e93-b484-ab8116cafe27"
                        // ),
                        ),
                  ),
                  AutoSizeText(
                    context.watch<PerfilProvider>().perfilAtual!.nome,
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 33,
                    ),
                    maxLines: 1,
                  ),
                  Consumer<PerfilProvider>(builder: (context, value, child) {
                    return value.perfilAtual.runtimeType == PerfilAluno
                        ? Text.rich(
                            TextSpan(
                              text:
                                  "${(value.perfilAtual as PerfilAluno).xpAtual} ",
                              style: const TextStyle(
                                fontFamily: "BebasNeue",
                                color: verde,
                                fontSize: 25,
                              ),
                              children: [
                                const TextSpan(
                                  text: "XP",
                                  style: TextStyle(
                                    fontFamily: "BebasNeue",
                                    color: verde,
                                    fontSize: 15,
                                  ),
                                ),
                                const TextSpan(
                                  text: "  -  ",
                                  style: TextStyle(
                                    fontFamily: "BebasNeue",
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: value.perfilAtual.runtimeType ==
                                          PerfilAluno
                                      ? (value.perfilAtual as PerfilAluno)
                                                  .rankingAtual !=
                                              0
                                          ? "${(value.perfilAtual as PerfilAluno).rankingAtual} º"
                                          : "  º"
                                      : " - º",
                                  style: const TextStyle(
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
                          )
                        : Container();
                  }),
                  const SizedBox(height: 40),
                  Consumer<PerfilProvider>(builder: (context, value, child) {
                    return value.perfilAtual.runtimeType == PerfilAluno
                        ? Padding(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CardPerfil(
                                      title: "MELHOR\nRANKING",
                                      text: (value.perfilAtual as PerfilAluno)
                                                  .melhorRanking ==
                                              0
                                          ? "-"
                                          : "${(value.perfilAtual as PerfilAluno).melhorRanking} º",
                                      bgcolor: laranja,
                                    ),
                                    CardPerfil(
                                      title: "XP\nCOLETADO",
                                      text:
                                          "${(value.perfilAtual as PerfilAluno).xpTotal} ",
                                      bgcolor: azul,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container();
                  }),
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
                                  alertaConfirmaApp(context,
                                      "Você tem certeza de que deseja sair?",
                                      () async {
                                    await FirebaseAuth.instance.signOut();
                                    if (!mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const LoginPage()),
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
                                    builder: ((context) =>
                                        const EditarPerfilPage()),
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
        ),
      ),
    );
  }
}
