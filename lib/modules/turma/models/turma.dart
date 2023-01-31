import 'package:cloud_firestore/cloud_firestore.dart';

class Turma {
  String id;
  String nome;
  Map<String, List> topicosAtivos;
  String profID;

  Turma(this.id, this.nome, this.topicosAtivos, this.profID);

  Turma.fromFirestore(QueryDocumentSnapshot<Map> doc)
      : this(
            doc.id,
            doc.data()["nome"],
            Map<String, List>.from(doc.data()["topicosAtivos"]),
            doc.data()["profID"]);

  Map<String, Object?> toFirestore() {
    return {"nome": nome, "topicosAtivos": topicosAtivos, "profID": profID};
  }
}
