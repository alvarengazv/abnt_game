class Atividade {
  final String _title;
  final String _id;
  final String _resposta;
  final List<Alternativa> _alternativas;

  Atividade(this._id, this._title, this._alternativas, this._resposta);

  bool checkCorrect(Alternativa respostaClicada) {
    if (respostaClicada._id == _resposta) {
      return true;
    } else {
      return false;
    }
  }

  Atividade.fromFirestore(Map data)
      : this(
            data["id"],
            data["titulo"],
            (Map<String, String>.from(data["alternativas"]))
                .map((key, value) => MapEntry(key, Alternativa(key, value)))
                .values
                .toList(),
            data["resposta"]);

  toFirestore() {
    return {
      "id": id,
      "titulo": title,
      "resposta": _resposta,
      "alternativas": _alternativas.map((e) => e.toFirestore())
    };
  }

  String get title => _title;
  String get id => _id;
  List<Alternativa> get altenativas => _alternativas;
}

class Alternativa {
  final String _id;
  final String _value;

  Alternativa(this._id, this._value);

  toFirestore() {
    return MapEntry(id, value);
  }

  get id => _id;
  get value => _value;
}
