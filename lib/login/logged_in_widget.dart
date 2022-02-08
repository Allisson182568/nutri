import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nutri/notificacao/locaol_notification_service.dart';
import 'package:nutri/perfil_master/body_basic.dart';
import 'package:nutri/perfil_master/body_master.dart';

//inicio do app com botomappbar



class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {

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

    final user = FirebaseAuth.instance.currentUser!;



    //validacao de usuario para abrir bodyMaster
    var login = false;

    var idUser = 'laizefrancimare.nutri@gmail.com';
      if(idUser == user.email){
        login=true;
      }


    return Scaffold(

      //usado para criar perfil master
         body: login == true
            ?bodyMaster()
            :bodyBasic()


    );
  }
}
