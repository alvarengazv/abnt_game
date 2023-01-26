import 'package:abntplaybic/modules/home/pages/index.dart';
import 'package:abntplaybic/modules/login/pages/login.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/screens/tipoPerfilPage.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shared_preferences/shared_preferences.dart';

class RedirectPage extends StatefulWidget {
  const RedirectPage({super.key});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  Future checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var shared = await SharedPreferences.getInstance();
      if (!mounted) return;
      if (FirebaseAuth.instance.currentUser != null) {
        var user = await context.read<PerfilProvider>().getUser();
        if (!mounted) return;
        if (user == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const TipoPerfilPage()),
              (route) => false);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkUser(),
        builder: (context, fut) {
          return const Scaffold(
            body: Center(
              child: LinearProgressIndicator(
                color: primary,
                backgroundColor: lilas,
              ),
            ),
          );
        });
  }
}
