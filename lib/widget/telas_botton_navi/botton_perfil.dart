import 'package:flutter/material.dart';
import 'package:nutri/widget/perfil.dart';

class bottomPerfil extends StatefulWidget {
  const bottomPerfil({Key? key}) : super(key: key);

  @override
  _bottomHomeState createState() => _bottomHomeState();
}

class _bottomHomeState extends State<bottomPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Perfil(),
      ),
    );
  }
}