import 'package:abntplaybic/modules/home/pages/index.dart';
import 'package:abntplaybic/modules/login/controllers/cadastroController.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CadastroController controller = CadastroController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool escondeSenha = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //appBar: AppBar(title: Text('ABNT PLAY'),),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Image.asset(
                        "src/images/coruja_login.png",
                      ),
                    ),
                    const Text(
                      "ABNTPLAY",
                      style: TextStyle(
                          fontFamily: "Righteous", color: roxo, fontSize: 40),
                    ),
                    const SizedBox(height: 10),
                    Hero(
                      tag: "email",
                      child: Material(
                        child: TextFormField(
                            controller: controller.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite um email válido";
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontFamily: "PassionOne", fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: lilas, width: 3)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: lilas, width: 3)),
                              label: const Text("Email"),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "email@example.com",
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: controller.nome,
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
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: lilas, width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: lilas, width: 3)),
                          suffixIcon: const Icon(
                            Icons.remove_red_eye,
                            color: roxo,
                          ),
                          label: const Text("Nome"),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Hero(
                        tag: "senha",
                        child: Material(
                          child: TextFormField(
                              controller: controller.senha,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Digite uma senha";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  fontFamily: "PassionOne", fontSize: 20),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: lilas, width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: lilas, width: 3)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      escondeSenha = !escondeSenha;
                                    });
                                  },
                                  icon: Icon(
                                    escondeSenha
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: roxo,
                                  ),
                                ),
                                label: const Text("Senha"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              obscureText: escondeSenha),
                        )),
                    const SizedBox(height: 40),
                    Hero(
                        tag: "botao",
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              fixedSize: Size(size.width * 0.65, 62),
                              maximumSize: Size(size.width * 0.65, 62)),
                          child: const Text(
                            "Cadastrar",
                            style: TextStyle(
                                fontFamily: "PassionOne",
                                fontSize: 32,
                                color: Colors.white),
                          ),
                          onPressed: () async {
                            try {
                              if (_form.currentState!.validate()) {
                                await controller.criarConta();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (route) => false);
                              }
                            } catch (e) {
                              rethrow;
                            }
                          },
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já possui conta?",
                          style: TextStyle(
                            fontFamily: "PassionOne",
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: "PassionOne",
                                fontSize: 20,
                                color: primary),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
