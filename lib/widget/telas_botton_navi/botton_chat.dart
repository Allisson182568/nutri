import 'package:flutter/material.dart';
import 'package:nutri/chat/telas/home.dart';

class bottomChat extends StatefulWidget {
  const bottomChat({Key? key}) : super(key: key);

  @override
  _bottomHomeState createState() => _bottomHomeState();
}

class _bottomHomeState extends State<bottomChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Home()
      ),
    );
  }
}