import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConteudoTurma extends StatefulWidget {
  const ConteudoTurma({super.key});

  @override
  State<ConteudoTurma> createState() => _ConteudoTurmaState();
}

class _ConteudoTurmaState extends State<ConteudoTurma> {
  late Future<List<QueryDocumentSnapshot<Map>>> getTopicos;
  List<List<bool?>> checkeds = [];
  List<Future<List<QueryDocumentSnapshot<Map>>>> subFuture = [];

  Future<List<QueryDocumentSnapshot<Map>>> _getTopicos() async {
    var docs = await FirebaseFirestore.instance
        .collection("topicos")
        .get()
        .then((value) => value.docs);
    checkeds = List.generate(docs.length, (index) => []);
    print(checkeds);
    getSubTopicos(docs);
    return docs;
  }

  Future<List<QueryDocumentSnapshot<Map>>> getSubTopicos(
      List<QueryDocumentSnapshot<Map>> docs) async {
    subFuture = [];
    for (var i = 0; i < docs.length; i++) {
      subFuture.add(FirebaseFirestore.instance
          .collection("topicos")
          .doc(docs[i].id)
          .collection("subTopicos")
          .get()
          .then((value) {
        checkeds[i] = List.generate(value.docs.length, (index) => true);
        return value.docs;
      }));
    }

    checkeds = List.generate(docs.length, (index) => []);
    return docs;
  }

  @override
  void initState() {
    super.initState();
    getTopicos = _getTopicos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<QueryDocumentSnapshot<Map>>>(
          future: getTopicos,
          builder: (context, snap) {
            return snap.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ...(snap.data!.map((element) {
                          return ExpansionTile(
                            onExpansionChanged: (val) {},
                            title: Container(
                                child: Row(
                              children: [
                                Checkbox(
                                    tristate: true,
                                    value: checkeds[snap.data!.indexOf(element)]
                                            .every((element) => element == true)
                                        ? true
                                        : checkeds[snap.data!.indexOf(element)]
                                                .every((element) =>
                                                    element == false)
                                            ? false
                                            : null,
                                    onChanged: (val) {
                                      setState(() {
                                        checkeds[snap.data!.indexOf(element)] =
                                            checkeds[
                                                    snap.data!.indexOf(element)]
                                                .map((e) => val ?? false)
                                                .toList();
                                      });
                                    }),
                                Text(element["titulo"])
                              ],
                            )),
                            children: [
                              FutureBuilder<List<QueryDocumentSnapshot<Map>>>(
                                future: subFuture[snap.data!.indexOf(element)],
                                builder: (context, snapSub) => Container(
                                  // child: Text(snapSub.data.toString())
                                  margin: const EdgeInsets.only(left: 50),
                                  child: snapSub.hasData
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: snapSub.data!
                                              .map((e) => Row(
                                                    children: [
                                                      Checkbox(
                                                          value: checkeds[snap
                                                                      .data!
                                                                      .indexOf(
                                                                          element)]
                                                                  .isEmpty
                                                              ? false
                                                              : checkeds[snap
                                                                      .data!
                                                                      .indexOf(
                                                                          element)][snapSub
                                                                      .data!
                                                                      .indexOf(
                                                                          e)] ??
                                                                  false,
                                                          // value: true,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              checkeds[snap
                                                                  .data!
                                                                  .indexOf(
                                                                      element)][snapSub
                                                                  .data!
                                                                  .indexOf(
                                                                      e)] = val;
                                                            });
                                                            print(checkeds);
                                                            print(checkeds[snap
                                                                    .data!
                                                                    .indexOf(
                                                                        element)]
                                                                .every(
                                                                    (element) =>
                                                                        element ==
                                                                        true));
                                                          }),
                                                      Text(e.data()["nomeTema"])
                                                    ],
                                                  ))
                                              .toList())
                                      : const LinearProgressIndicator(),
                                ),
                              )
                            ],
                          );
                        }))
                      ])
                : const LinearProgressIndicator();
          }),
    );
  }
}

class TopicoTile extends StatefulWidget {
  const TopicoTile(this.titulo, this.reference, {super.key});
  final String titulo;
  final QueryDocumentSnapshot reference;

  @override
  State<TopicoTile> createState() => _TopicoTileState();
}

class _TopicoTileState extends State<TopicoTile> {
  Future<List<QueryDocumentSnapshot<Map>>> getSubTopicos(String id) async {
    var docs = await FirebaseFirestore.instance
        .collection("topicos")
        .doc(id)
        .collection("subTopicos")
        .get()
        .then((value) => value.docs);
    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
