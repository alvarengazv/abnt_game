import 'package:abntplaybic/modules/atividades/model/atividade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AtividadeController extends ChangeNotifier {
  Atividade? atividadeAtual;
  int indiceAtivo = 0;
  int acertos = 0;
  List<Atividade> atividades = [];
  String idTopico;
  String idSubTopico;

  AtividadeController(this.idTopico, this.idSubTopico);

  getAtividades() async {
    atividades = [];
    var atvQuery = await FirebaseFirestore.instance
        .collection("topicos")
        .doc(idTopico)
        .collection("subTopicos")
        .doc(idSubTopico)
        .collection("tarefa")
        .withConverter(
            fromFirestore: (snapshot, options) {
              var data = snapshot.data();
              if (data != null) {
                data["id"] = snapshot.id;
                return Atividade.fromFirestore(data, idTopico, idSubTopico);
              }
            },
            toFirestore: (atv, setOp) => atv!.toFirestore())
        .get();

    for (var element in atvQuery.docs) {
      if (element.data() != null) {
        atividades.add(element.data()!);
      }
    }
    print(atividades);
    atividadeAtual = atividades[indiceAtivo];
  }

  void addAcerto() {
    acertos += 1;
  }

  int? proximaAtividade() {
    if (atividades.indexOf(atividadeAtual!) != atividades.length - 1) {
      indiceAtivo += 1;
      atividadeAtual = atividades[indiceAtivo];
      notifyListeners();
    } else {
      return 1;
    }
    return null;
  }
}
