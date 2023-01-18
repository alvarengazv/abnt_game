import 'package:abntplaybic/modules/login/controllers/loginController.dart';
import 'package:abntplaybic/modules/login/pages/cadastro.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

import '../../home/pages/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = LoginController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool escondeSenha = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: "email@example.com",
                          )),
                    ),
                  ),
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
                              return "Informe sua senha";
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          obscureText: escondeSenha),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Hero(
                    tag: "botao",
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        fixedSize: Size(size.width * 0.65, 62),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontFamily: "PassionOne",
                            fontSize: 32,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        try {
                          if (_form.currentState!.validate()) {
                            await controller.login();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false);
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side: const BorderSide(color: primary)),
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: size.width * 0.25, vertical: 10),
                      fixedSize: Size(size.width * 0.65, 62),
                    ),
                    child: const Text(
                      "Cadastre-se",
                      style: TextStyle(
                          fontFamily: "PassionOne",
                          fontSize: 32,
                          color: primary),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CadastroPage()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
