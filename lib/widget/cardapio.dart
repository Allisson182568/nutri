import 'package:flutter/material.dart';
import 'package:nutri/widget/menu.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({Key? key}) : super(key: key);

  @override
  _CardapioState createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Menu();
                  }),
                );
              },
              child: Text('Menu'))
        ],
      ),
    );
  }
}
