import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CriarAtividade extends StatefulWidget {
  const CriarAtividade({super.key});

  @override
  State<CriarAtividade> createState() => _CriarAtividadeState();
}

class _CriarAtividadeState extends State<CriarAtividade> {
  late Future<List<Map>> topicos;
  Future<List<Map>> subTopicos = Future.wait([]);
  Map? selectedTopico;
  Map? selectedSubTopico;

  TextEditingController titulo = TextEditingController();
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();
  TextEditingController d = TextEditingController();
  TextEditingController resposta = TextEditingController();

  Future<List<Map>> getTopicos() async {
    var value = await FirebaseFirestore.instance
        .collection("topicos")
        .get()
        .then((value) =>
            value.docs.map((e) => {"id": e.id, ...e.data()}).toList());

    return value;
  }

  Future<List<Map>> getSubTopicos(String topico) async {
    return await FirebaseFirestore.instance
        .collection("topicos")
        .doc(topico)
        .collection("subTopicos")
        .orderBy("indice")
        .get()
        .then((value) =>
            value.docs.map((e) => {"id": e.id, ...e.data()}).toList());
  }

  @override
  void initState() {
    super.initState();
    topicos = getTopicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Map>>(
            future: topicos,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      DropdownButton<Map>(
                          value: selectedTopico,
                          items: snap.data!
                              .map((e) => DropdownMenuItem<Map>(
                                    value: e,
                                    child: Text(e["titulo"]),
                                  ))
                              .toList(),
                          onChanged: (e) {
                            setState(() {
                              selectedTopico = e;
                              subTopicos = getSubTopicos(e!["id"]);
                              selectedSubTopico = null;
                            });
                          }),
                      Visibility(
                          visible: selectedTopico != null,
                          child: FutureBuilder<List<Map>>(
                              future: subTopicos,
                              builder: (context, snap2) {
                                if (snap2.connectionState ==
                                    ConnectionState.done) {
                                  return DropdownButton<Map>(
                                      value: selectedSubTopico,
                                      items: snap2.data!
                                          .map((e) => DropdownMenuItem<Map>(
                                                value: e,
                                                child: Text(e["nomeTema"]),
                                              ))
                                          .toList(),
                                      onChanged: (e) {
                                        setState(() {
                                          selectedSubTopico = e;
                                        });
                                      });
                                }
                                return const CircularProgressIndicator();
                              })),
                      TextFormField(controller: titulo),
                      const Text("A"),
                      TextFormField(controller: a),
                      const Text("B"),
                      TextFormField(controller: b),
                      const Text("C"),
                      TextFormField(controller: c),
                      const Text("D"),
                      TextFormField(controller: d),
                      const Text("Resposta"),
                      TextFormField(controller: resposta),
                      TextButton(
                        child: const Text("Cadastra"),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("topicos")
                              .doc(selectedTopico!["id"])
                              .collection("subTopicos")
                              .doc(selectedSubTopico!["id"])
                              .collection("tarefa")
                              .add({
                            "titulo": titulo.text,
                            "alternativas": {
                              "a": a.text,
                              "b": b.text,
                              "c": c.text,
                              "d": d.text,
                            },
                            "resposta": resposta.text
                          }).then((value) {
                            print(value.path);
                          });

                          a.text = "";
                          b.text = "";
                          c.text = "";
                          d.text = "";
                          resposta.text = "";
                          titulo.text = "";
                        },
                      )
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
