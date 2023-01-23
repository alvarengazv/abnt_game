import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PerfilTipo? tipo;
  Future<PerfilTipo?> getUser() async {
    if (_auth.currentUser != null) {
      var prefs = await SharedPreferences.getInstance();
      bool alunoCheck = await FirebaseFirestore.instance
          .collection("aluno")
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => value.exists);

      if (alunoCheck) {
        tipo = PerfilTipo.aluno;
        prefs.setString("tipoPerfil", "aluno");
      } else {
        bool profCheck = await FirebaseFirestore.instance
            .collection("professor")
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value) => value.exists);
        if (profCheck) {
          tipo = PerfilTipo.profesor;
          prefs.setString("tipoPerfil", "professor");
        }
      }
    }
    notifyListeners();
    return tipo;
  }
}

enum PerfilTipo { profesor, aluno }
