import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PefilProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PerfilTipo? tipo;
  getUser() async {
    if (_auth.currentUser != null) {
      await FirebaseFirestore.instance
          .collection("aluno")
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          tipo = PerfilTipo.aluno;
        } else {
          FirebaseFirestore.instance
              .collection("professor")
              .doc(_auth.currentUser!.uid)
              .get();
          tipo = PerfilTipo.profesor;
        }
      });
    }
  }
}

enum PerfilTipo { profesor, aluno }
