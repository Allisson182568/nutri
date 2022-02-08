import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'chat/provider/conversa_provider.dart';
import 'chat/rotas.dart';
import 'config/paleta.dart';
import 'login/Home_page.dart';
import 'login/google_sign_in.dart';

//Receber mensagem quando o aplicativo está em solução de fundo para uma mensagem
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //inicializacao firebase
  await Firebase.initializeApp();
  //inicializacao admob
  MobileAds.instance.initialize();
  //FirebaseMessaging adicionado para mandar push de notificaoca
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  //statusbar color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ktrans
  ));

  runApp(MyApp());
}

var theme = darkTheme;

var darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  fontFamily: 'Muli',
  appBarTheme: AppBarTheme(centerTitle: true),
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

var lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  primaryColor: kBarraColor,
  backgroundColor: Colors.white,
  fontFamily: 'Muli',
  appBarTheme: AppBarTheme(centerTitle: true),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//theme
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    changeTheme();
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangePlatformBrightness() {
    changeTheme();
  }

  changeTheme() {
    var brightness = WidgetsBinding.instance!.window.platformBrightness;
    brightness == Brightness.dark ? theme = darkTheme : theme = lightTheme;

    setState(() {});
  }


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ConversaProvider(),
      //create: (context) => ConversaProvider(),
      //create: (context) => GoogleSignInProvider(),


      child: MaterialApp(
        title: 'Flutter Themes',
        debugShowCheckedModeBanner: false,
        theme: theme,
        onGenerateRoute: Rotas.gerarRota,
        home: HomePage(),
      )
  );
}


