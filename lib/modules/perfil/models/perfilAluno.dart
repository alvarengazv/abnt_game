import 'package:abntplaybic/modules/perfil/models/perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilAluno extends Perfil {
  Function? _notify;
  int _melhorRanking = 0;
  int _rankingAtual = 0;
  int _xpAtual = 0;
  int _xpTotal = 0;
  String? _turma;

  //construtor
  PerfilAluno(String id, String nome, String email,
      [String? fotoPerfil, this._notify])
      : super(id: id, nome: nome, email: email, fotoPerfil: fotoPerfil);

  @override
  getPerfil() async {
    var dadosUser = await FirebaseFirestore.instance
        .collection("aluno")
        .doc(id)
        .get()
        .then((value) => value.data());
    if (dadosUser != null) {
      _melhorRanking = dadosUser["melhorRanking"] ?? 0;
      _rankingAtual = dadosUser["rankingAtual"] ?? 0;
      _xpAtual = dadosUser["xpAtual"] ?? 0;
      _xpTotal = dadosUser["xpTotal"] ?? 0;
      _turma = dadosUser["turma"];
    }
  }

  PerfilAluno.novoAluno(User user)
      : super(
            nome: user.displayName!,
            email: user.email!,
            id: user.uid,
            fotoPerfil: user.photoURL);

  @override
  PerfilAluno.fromFirestore(Map<String, Object?> data, User user)
      : super(
            nome: user.displayName!,
            email: user.email!,
            id: user.uid,
            fotoPerfil: user.photoURL) {
    _melhorRanking = data["melhorRanking"] as int? ?? 0;
    _rankingAtual = data["rankingAtual"] as int? ?? 0;
    _xpAtual = data["xpAtual"] as int? ?? 0;
    _xpTotal = data["xpTotal"] as int? ?? 0;
    _turma = data["turma"] as String?;
  }

  @override
  toMap() {
    return {
      "melhorRanking": _melhorRanking,
      "rankingAtual": _rankingAtual,
      "xpAtual": _xpAtual,
      "xpTotal": _xpTotal,
      "turma": _turma
    };
  }

  @override
  updateFirestore() async {
    await FirebaseFirestore.instance
        .collection("aluno")
        .doc(id)
        .update(toMap());
  }

  addXp(int xp) {
    _xpAtual += xp;
    _xpTotal += xp;
  }

  updateRanking(int newRanking) {
    _rankingAtual = newRanking;
    if (newRanking < _melhorRanking) {
      _melhorRanking = newRanking;
    }
  }

  set setTurma(String novaTurma) {
    _turma = novaTurma;
    (_notify != null) ? _notify!() : null;
  }

  //Getters
  get xpAtual => _xpAtual;
  get xpTotal => _xpTotal;
  get melhorRanking => _melhorRanking;
  get rankingAtual => _rankingAtual;
  get turma => _turma;
}
