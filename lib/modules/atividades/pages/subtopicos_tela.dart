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
  const SubTopicosPage({super.key});

  @override
  State<SubTopicosPage> createState() => _SubTopicosPageState();
}

class _SubTopicosPageState extends State<SubTopicosPage> {
  final TickerProvider provider = TickerProviderImpl();
  late TabController _tabController = TabController(length: 4, vsync: provider);
  int selectedIndex = 1;
  List<Widget> lista = [];

  List<Widget> _buildPageIndicator() {
    for (int i = 0; i < 4; i++) {
      lista.add(i == selectedIndex ? _indicator(true) : _indicator(false));
    }
    return lista;
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: const Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PageView.builder(
      onPageChanged: (int page) {
        setState(() {
          selectedIndex = page;
        });
      },
      itemCount: 4,
      itemBuilder: (context, index) {
        return Scaffold(
          body: Column(
            children: [
              BackButtonNormas(),
              TelaSubtopicos(
                titulo: "Margens",
                corpo: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "3cm",
                      style: TextStyle(
                        fontFamily: "PassionOne",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "3cm",
                          style: TextStyle(
                            fontFamily: "PassionOne",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Folha(),
                        Text(
                          "2cm",
                          style: TextStyle(
                            fontFamily: "PassionOne",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const Text(
                      "2cm",
                      style: TextStyle(
                        fontFamily: "PassionOne",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                descricao:
                    "O padrão de margens que foi estabelecido pela ABNT é:\n\nTopo: 3cm\nDireita: 2cm\nBaixo: 2cm\nEsquerda: 3cm",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 1),
                      TabPageSelector(
                        controller: _tabController,
                        color: lilas,
                        selectedColor: roxo,
                        borderStyle: BorderStyle.none,
                        indicatorSize: 16,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 40,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
