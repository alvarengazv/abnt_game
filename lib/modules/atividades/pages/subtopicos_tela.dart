import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/home/models/model_tema.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/normas/back_button.dart';
import 'package:abntplaybic/shared/components/normas/folha.dart';
import 'package:abntplaybic/shared/components/normas/linha_folha.dart';
import 'package:abntplaybic/shared/components/normas/subtopicos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubTopicosPage extends StatefulWidget {
  final String topico;
  final String subTopico;

  const SubTopicosPage(
      {super.key, required this.topico, required this.subTopico});

  @override
  State<SubTopicosPage> createState() => _SubTopicosPageState();
}

class _SubTopicosPageState extends State<SubTopicosPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final TickerProvider provider = TickerProviderImpl();
  TopicosController _topicosController = TopicosController();
  late TabController? _tabController;
  int selectedIndex = 0;
  bool loading = true;
  List<Widget> lista = [];
  List<Tema> listaTemas = [];

  @override
  void initState() {
    super.initState();
    getTopicos();
  }

  getTopicos() async {
    listaTemas = await _topicosController.getAllSubTopicos(
        widget.topico, widget.subTopico);
    _tabController = TabController(
        length: listaTemas.isNotEmpty ? listaTemas.length : 1, vsync: provider);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        BackButtonNormas(),
        Expanded(
          child: !loading && listaTemas.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      flex: 4,
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
                              corpo: Text(listaTemas.elementAt(index).conteudo),
                              descricao: listaTemas.elementAt(index).descricao,
                            );
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                                  size: 32,
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
                                indicatorSize: 16,
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
                                  }
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  size: 32,
                                  color:
                                      selectedIndex + 1 < _tabController!.length
                                          ? primary
                                          : Colors.transparent,
                                ),
                                splashColor:
                                    selectedIndex + 1 < _tabController!.length
                                        ? null
                                        : Colors.transparent,
                                highlightColor:
                                    selectedIndex + 1 < _tabController!.length
                                        ? null
                                        : Colors.transparent,
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
                      child: AutoSizeText(
                        "Não há tema cadastrado com este nome!",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "PassionOne",
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    ),
        )
      ],
    ));
  }
}
