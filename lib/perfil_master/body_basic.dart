import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nutri/notificacao/locaol_notification_service.dart';
import 'package:nutri/widget/telas_botton_navi/botton_chat.dart';
import 'package:nutri/widget/telas_botton_navi/botton_home.dart';
import 'package:nutri/widget/telas_botton_navi/botton_perfil.dart';
import 'package:nutri/widget/telas_botton_navi/botton_receitas.dart';

class bodyBasic extends StatefulWidget {
  const bodyBasic({Key? key}) : super(key: key);

  @override
  _bodyBasicState createState() => _bodyBasicState();
}

class _bodyBasicState extends State<bodyBasic> {

  //cloud Notification linha 25 a 62

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });

  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //selecao da barra de navegacao
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      bottomHome(),
      bottomReceitas(),
      bottomChat(),
      bottomPerfil(),

    ];

    return Scaffold(


      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        fixedColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: 'Inicio',
              icon: Icon(Icons.home_outlined)
          ),
          BottomNavigationBarItem(

              label: 'Receitas',
              icon: Icon(Icons.bookmark_add_outlined)
          ),
          BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(Icons.chat_bubble_outline)
          ),
          BottomNavigationBarItem(
              label: 'Perfil',
              icon: Icon(Icons.perm_identity )
          )
        ],
      ),

      //usado para criar perfil master
      /* body: login == true
            ?BodyMaster()
            :Body()

         */

    );
  }
}
