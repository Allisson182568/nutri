import 'package:flutter/material.dart';
import 'package:nutri/chat/telas/home.dart';
import 'package:nutri/chat/telas/login.dart';
import 'package:nutri/chat/telas/mensagens.dart';

import 'modelos/usuario.dart';

class Rotas{

  static Route<dynamic> gerarRota(RouteSettings settings){

    final args = settings.arguments;

    switch( settings.name ){
      case "/":
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/login":
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/home":
        return MaterialPageRoute(
            builder: (_) => Home()
        );
      case "/mensagens":
        return MaterialPageRoute(
            builder: (_) => Mensagens(args as Usuario)
        );
    }

    return _erroRota();

  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: Text("Tela não encontrada!"),),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }

}