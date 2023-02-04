import 'package:abntplaybic/modules/perfil/models/perfil.dart';
import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilAluno extends Perfil {
  Function? _notify;
  int _melhorRanking = 0;
  int _rankingAtual = 0;
  int _xpAtual = 0;
  int _xpTotal = 0;
  String? _turmaID;
  Turma? _turma;

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
      _xpTotal = dadosUser["xpColetado"] ?? 0;
      _turmaID = dadosUser["turma"];
    }
  }

  PerfilAluno.novoAluno(User user)
      : super(
            nome: user.displayName!,
            email: user.email!,
            id: user.uid,
            fotoPerfil: user.photoURL);

  PerfilAluno.fromFirestore(Map<String, Object?> data, User user,
      [Function? notify])
      : super(
            nome: user.displayName!,
            email: user.email!,
            id: user.uid,
            fotoPerfil: user.photoURL) {
    _melhorRanking = data["melhorRanking"] as int? ?? 0;
    _rankingAtual = data["rankingAtual"] as int? ?? 0;
    _xpAtual = data["xpAtual"] as int? ?? 0;
    _xpTotal = data["xpColetado"] as int? ?? 0;
    _turmaID = data["turma"] as String?;
    _notify = notify;
  }

  @override
  toMap() {
    return {
      "nome": nome,
      "melhorRanking": _melhorRanking,
      "rankingAtual": _rankingAtual,
      "xpAtual": _xpAtual,
      "xpColetado": _xpTotal,
      "turma": _turmaID
    };
  }

  @override
  updateFirestore() async {
    await FirebaseFirestore.instance
        .collection("aluno")
        .doc(id)
        .update(toMap());
  }

  getTurma() async {
    if (_turmaID != null) {
      var data = await FirebaseFirestore.instance
          .collection("turma")
          .doc(_turmaID)
          .get();
      if (data.data() != null) {
        _turma = Turma.fromFirestoreDoc(data);
      }
    }
  }

  void addXp(int xp) async {
    _xpAtual += xp;
    _xpTotal += xp;
    await updateFirestore();
  }

  listenData() {
    FirebaseFirestore.instance
        .collection("aluno")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      _melhorRanking = event.data()!["melhorRanking"] ?? 0;
      _rankingAtual = event.data()!["rankingAtual"] ?? 0;
      _xpAtual = event.data()!["xpAtual"] ?? 0;
      _xpTotal = event.data()!["xpColetado"] ?? 0;
      _notify != null ? _notify!() : null;
    });
  }

  void updateRanking(int newRanking) async {
    _rankingAtual = newRanking;
    if (newRanking < _melhorRanking) {
      _melhorRanking = newRanking;
    }
    await updateFirestore();
    (_notify != null) ? _notify!() : null;
  }

  set setTurma(String novaTurma) {
    _turmaID = novaTurma;

    (_notify != null) ? _notify!() : null;
  }

  //Getters
  int get xpAtual => _xpAtual;
  int get xpTotal => _xpTotal;
  int get melhorRanking => _melhorRanking;
  int get rankingAtual => _rankingAtual;
  String? get turmaID => _turmaID;
  Turma? get turma => _turma;
}
