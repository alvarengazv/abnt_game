import 'package:abntplaybic/modules/atividades/pages/finalLicao.dart';
import 'package:abntplaybic/modules/atividades/pages/ganhaXP.dart';
import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/home/models/model_tema.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/normas/back_button.dart';
import 'package:abntplaybic/shared/components/normas/subtopicos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../perfil/controller/perfilProvider.dart';

class SubTopicosPage extends StatefulWidget {
  final String? topico;
  final String? subTopico;
  final Map topicoAtual;

  const SubTopicosPage(
      {super.key, required this.topicoAtual, this.topico, this.subTopico});

  @override
  State<SubTopicosPage> createState() => _SubTopicosPageState();
}

class _SubTopicosPageState extends State<SubTopicosPage> with SingleTickerProviderStateMixin{
  final PageController _pageController = PageController(initialPage: 0);
  final TopicosController _topicosController = TopicosController();
  final TickerProvider provider = TickerProviderImpl();
  late TabController? _tabController;
  int selectedIndex = 0;
  bool loading = true;
  List<Widget> lista = [];
  List<Tema> listaTemas = [];
  List<Future<String>?> images = [];
  double indicatorSize = 16;
  double chevronSize = 32;


  @override
  void initState() {
    super.initState();
    getTopicos();
  }

  @override
  void dispose(){
    _topicosController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  getTopicos() async {
    listaTemas = await _topicosController.getAllAulasSubTopicos(
        widget.topicoAtual["idTopico"], widget.topicoAtual["id"]);
    for (var item in listaTemas) {
      if (item.conteudo.toString().startsWith("gs:")) {
        getImage(item.conteudo);
      } else {
        images.add(null);
      }
    }
    _tabController = TabController(
        length: listaTemas.isNotEmpty ? listaTemas.length : 1, vsync: this);

    if(listaTemas.length >= 10){
      indicatorSize = 10;
      chevronSize = 28;
    }
    
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getImage(String url) async {
    images.add(FirebaseStorage.instance.refFromURL(url).getDownloadURL());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        const BackButtonNormas(),
        Expanded(
          child: !loading && listaTemas.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              selectedIndex = page;
                              _tabController!.index = page;
                            });
                          },
                          itemCount: listaTemas.length,
                          itemBuilder: (context, index) {
                            return TelaSubtopicos(
                              titulo: listaTemas.elementAt(index).titulo,
                              corpo: listaTemas
                                      .elementAt(index)
                                      .conteudo
                                      .toString()
                                      .startsWith("gs:")
                                  ? FutureBuilder<String>(
                                      future: images[index],
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          return SizedBox(
                                              width: size.width * 0.75,
                                              child: Image.network(snap.data!));
                                        } else {
                                          return Center(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child:
                                                  const LinearProgressIndicator(
                                                color: primary,
                                                backgroundColor: lilas,
                                              ),
                                            ),
                                          );
                                        }
                                      })
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            listaTemas
                                                .elementAt(index)
                                                .conteudo
                                                .replaceAll("\\n", "\n"),
                                            style: const TextStyle(
                                                fontFamily: "PassionOne",
                                                fontSize: 35),
                                          ),
                                        ],
                                      ),
                                    ),
                              descricao: listaTemas
                                  .elementAt(index)
                                  .descricao
                                  .replaceAll("\\n", "\n"),
                            );
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (selectedIndex + 1 > 1) {
                                    _pageController.animateToPage(
                                        selectedIndex - 1,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                    setState(() {
                                      _tabController!.index = selectedIndex;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.chevron_left,
                                  size: chevronSize,
                                  color: selectedIndex + 1 > 1
                                      ? primary
                                      : Colors.transparent,
                                ),
                                splashColor: selectedIndex + 1 > 1
                                    ? null
                                    : Colors.transparent,
                                highlightColor: selectedIndex + 1 > 1
                                    ? null
                                    : Colors.transparent,
                              ),
                              TabPageSelector(
                                controller: _tabController,
                                color: lilas,
                                selectedColor: roxo,
                                borderStyle: BorderStyle.none,
                                indicatorSize: indicatorSize,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (selectedIndex + 1 <
                                      _tabController!.length) {
                                    _pageController.animateToPage(
                                        selectedIndex + 1,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                    setState(() {
                                      _tabController!.index = selectedIndex;
                                    });
                                  } else {
                                    var perfil = context
                                        .read<PerfilProvider>()
                                        .perfilAtual;
                                    var ganhaXP = true;
                                    if (perfil is PerfilAluno) {
                                      perfil.marcaAula(
                                          widget.topicoAtual["idTopico"],
                                          widget.topicoAtual["id"]);
                                      bool aulaFeita = perfil.feitos?[widget
                                                      .topicoAtual["idTopico"]]
                                                  ?[widget.topicoAtual["id"]]
                                              ?["aula"] ??
                                          false;
                                      if (aulaFeita) {
                                        ganhaXP = false;
                                      }
                                    }

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => ganhaXP
                                                ? GanhaXP(
                                                    xpGanho: 5,
                                                    porCompletar:
                                                        "mais uma aula!",
                                                    nextRoute: MaterialPageRoute(
                                                        builder: (context) =>
                                                            FinalLicaoPage(
                                                                widget.topicoAtual[
                                                                    "idTopico"],
                                                                widget.topicoAtual[
                                                                    "id"])),
                                                  )
                                                : FinalLicaoPage(
                                                    widget.topicoAtual[
                                                        "idTopico"],
                                                    widget.topicoAtual["id"])));
                                  }
                                },
                                icon: Icon(Icons.chevron_right,
                                    size: chevronSize, color: primary),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : listaTemas.isEmpty && !loading
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: size.height * 0.36),
                      child: const AutoSizeText(
                        "N??o h?? tema cadastrado com este nome!",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "PassionOne",
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const LinearProgressIndicator(
                          color: primary,
                          backgroundColor: lilas,
                        ),
                      ),
                    ),
        )
      ],
    ));
  }
}
