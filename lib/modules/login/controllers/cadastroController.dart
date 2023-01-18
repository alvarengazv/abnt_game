import 'package:abntplaybic/modules/home/pages/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroController {
  TextEditingController email = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();
  criarConta(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: senha.text);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(nome.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
