import 'package:abntplaybic/modules/home/controllers/editController.dart';
import 'package:abntplaybic/modules/login/pages/login.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_perfil.dart';
import 'package:abntplaybic/shared/components/cards/card_perfil.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta_confirm.dart';
import 'package:abntplaybic/shared/validacoes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final EditController _controllerEdit = EditController();
  FocusNode emailNode = FocusNode();
  FocusNode nomeNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controllerEdit.email.text = FirebaseAuth.instance.currentUser!.email ?? "";
    _controllerEdit.nome.text =
        FirebaseAuth.instance.currentUser!.displayName ?? "";
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
          title: const Text(
            "Editar Perfil",
            style: TextStyle(
              color: roxo,
              fontFamily: "PassionOne",
              fontSize: 32,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: size.height,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          color: lilas,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primary)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            // Image.asset(""),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: roxo, width: 2)),
                                child: const Icon(
                                  Icons.edit,
                                  color: roxo,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AutoSizeText(
                      FirebaseAuth.instance.currentUser!.displayName ?? "Nome",
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 8),
                            child: Text(
                              "ALTERAR DADOS",
                              style: TextStyle(
                                color: prata,
                                fontFamily: "BebasNeue",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Hero(
                            tag: "email",
                            child: Material(
                              child: TextFormField(
                                  onFieldSubmitted: ((value) {
                                    nomeNode.requestFocus();
                                  }),
                                  focusNode: emailNode,
                                  textInputAction: TextInputAction.go,
                                  controller: _controllerEdit.email,
                                  onChanged: ((value) {}),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Digite um email válido";
                                    }

                                    if (!emailExp.hasMatch(value)) {
                                      return "Email inválido";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      fontFamily: "PassionOne", fontSize: 20),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: lilas, width: 3)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: lilas, width: 3)),
                                    label: const Text("Email"),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: "email@example.com",
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              focusNode: nomeNode,
                              controller: _controllerEdit.nome,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.go,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Digite um nome";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  fontFamily: "PassionOne", fontSize: 20),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: lilas, width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: lilas, width: 3)),
                                label: const Text("Nome"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              )),
                        ],
                      ),
                    ),
                    BotaoPerfil(
                      funcaoBotao: () {},
                      icone: Icons.edit,
                      text: "CONFIRMAR",
                      bgcolor: amarelo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
