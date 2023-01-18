import 'package:abntplaybic/modules/home/pages/telas/classificacao.dart';
import 'package:abntplaybic/modules/home/pages/telas/conquistas.dart';
import 'package:abntplaybic/modules/home/pages/telas/inicio.dart';
import 'package:abntplaybic/modules/home/pages/telas/perfil.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    ClassificacaoPage(),
    ConquistasPage(),
    PerfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:[ 
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.house, color: Color.fromARGB(255, 64, 1, 53),),
            icon: Icon(Icons.house_outlined, color: Color.fromARGB(255, 64, 1, 53),),
            label: ""
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.leaderboard, color: Color.fromARGB(255, 64, 1, 53),),
            icon: Icon(Icons.leaderboard_outlined, color: Color.fromARGB(255, 64, 1, 53),),
            label: ""
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.military_tech, color: Color.fromARGB(255, 64, 1, 53),),
            icon: Icon(Icons.military_tech_outlined, color: Color.fromARGB(255, 64, 1, 53),),
            label: ""
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, color: Color.fromARGB(255, 64, 1, 53),),
            icon: Icon(Icons.person_outline, color: Color.fromARGB(255, 64, 1, 53),),
            label: ""
          ),
        ]
      ),
    );
  }
}