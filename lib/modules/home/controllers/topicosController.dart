import 'package:abntplaybic/modules/home/models/model_tema.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TopicosController extends ChangeNotifier{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getTopicos() async{ 
    var qs = await _firestore.collection("topicos").get();
    List<String> listaTopicos = [];

    if (qs.docs.isEmpty) {
      return [];
    }
    
    qs.docs.forEach((element) { 
      listaTopicos.add(
        element['titulo']
      );
    });
    return listaTopicos;
  }

  Future<List<String>> getSubTopicos(String topico) async{
    var qs = await _firestore.collection("topicos").get();
    List<String> listaSubTopicos = [];
    String idSubTopico = "";

    if (qs.docs.isEmpty) {
      return [];
    }
    
    qs.docs.forEach((element) {
      if(element['titulo'] == topico){
        idSubTopico = element.id;
      } 
    });

    var qs2 = await _firestore.collection("topicos").doc(idSubTopico).collection("subTopicos").get();
    
    if(qs2.docs.isEmpty) return [];

    qs2.docs.forEach((element1) {
      listaSubTopicos.add(element1['nomeTema']);
    });

    print(listaSubTopicos);
    return listaSubTopicos;
  }

  Future<List<Tema>> getAllSubTopicos(String topico, String subTopico) async{
    var qs = await _firestore.collection("topicos").get();
    List<Tema> listaTemas = [];
    String idSubTopico = "";
    String idTema = "";

    if (qs.docs.isEmpty) {
      return [];
    }
    
    qs.docs.forEach((element) {
      if(element['titulo'] == topico){
        idSubTopico = element.id;
      } 
    });

    var qs2 = await _firestore.collection("topicos").doc(idSubTopico).collection("subTopicos").get();

    if(qs2.docs.isEmpty) return [];
    
    qs2.docs.forEach((element1) {
      if (element1['nomeTema'] == subTopico) {
        idTema = element1.id;
      }
    });

    var qs3 = await _firestore.collection("topicos").doc(idSubTopico).collection("subTopicos").doc(idTema).get();
    
    if(!qs3.exists) return [];

    qs3.data()!.forEach((key, value) {
      if (key != 'nomeTema') {
        listaTemas.add(Tema.fromMap(value));
      }
    });

    print(listaTemas);
    return listaTemas;
  }

}