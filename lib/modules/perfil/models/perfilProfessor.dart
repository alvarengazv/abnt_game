import 'package:abntplaybic/modules/perfil/models/perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilProfessor extends Perfil {
  List turmas = [];
  PerfilProfessor(User user)
      : super(
            id: user.uid,
            email: user.email!,
            nome: user.displayName!,
            fotoPerfil: user.photoURL);

  PerfilProfessor.fromFirestore(Map<String, Object?> data, User user,
      [Function? notify])
      : super(
            email: user.email!,
            id: user.uid,
            nome: user.displayName!,
            fotoPerfil: user.photoURL);

  @override
  getPerfil() async {
    var profData =
        await FirebaseFirestore.instance.collection("professor").doc(id).get();
    if (profData.data() != null) {
      turmas = profData.data()!["turmas"] ?? [];
    }
  }

  @override
  toMap() {
    return {
      "turmas": turmas,
    };
  }

  @override
  updateFirestore() async {
    await FirebaseFirestore.instance
        .collection("professor")
        .doc(id)
        .update(toMap());
  }
}
