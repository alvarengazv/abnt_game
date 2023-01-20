import 'package:abntplaybic/modules/perfil/screens/codigoTurma.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'ABNT Play',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CodigoTurmaScreen(),
    );
  }
}
