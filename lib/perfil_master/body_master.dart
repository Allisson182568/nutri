import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nutri/notificacao/locaol_notification_service.dart';
import 'package:nutri/widget/telas_botton_navi/bottomConfigMaster.dart';
import 'package:nutri/widget/telas_botton_navi/botton_chat.dart';
import 'package:nutri/widget/telas_botton_navi/botton_home.dart';
import 'package:nutri/widget/telas_botton_navi/botton_perfil.dart';
import 'package:nutri/widget/telas_botton_navi/botton_receitas.dart';

class bodyMaster extends StatefulWidget {
  const bodyMaster({Key? key}) : super(key: key);

  @override
  _bodyMasterState createState() => _bodyMasterState();
}

class _bodyMasterState extends State<bodyMaster> {

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
      bottonConfiMaster(),
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
              label: 'Master',
              icon: Icon(Icons.edit)
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




/*import 'package:flutter/material.dart';
import 'package:nutri/chat/provider/conversa_provider.dart';
import 'package:nutri/chat/telas/home.dart';
import 'package:nutri/food/profile_menu.dart';
import 'package:nutri/food/profile_pic.dart';
import 'package:nutri/image/image.dart';
import 'package:nutri/lista/lista.dart';
import 'package:nutri/widget/cauculo_imc.dart';
import 'package:nutri/naoUtilizavel/lista_compra.dart';
import 'package:nutri/widget/local.dart';
import 'package:nutri/widget/menu.dart';
import 'package:nutri/widget/perfil.dart';
import 'package:nutri/widget/salvar_dados.dart';
import 'package:provider/provider.dart';


class BodyMaster extends StatefulWidget {

  @override
  State<BodyMaster> createState() => _BodyState();
}

class _BodyState extends State<BodyMaster> {



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Nutri'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.only(top:128.0),
          child: Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Minha Conta",
                icon: "assets/icons/User Icon.svg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Perfil();
                    }),
                  );
                },
              ),
              ProfileMenu(
                text: "Cardapio",
                icon: "assets/icons/Phone.svg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Menu();
                    }),
                  );
                },
              ),

              /*ProfileMenu(
                text: "Lista de Compra",
                icon: "assets/icons/receipt.svg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ListaCompra();
                    }),
                  );
                },
              ),

               */


              ProfileMenu(
                text: "Calculadora IMC",
                icon: "assets/icons/Plus Icon.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return calculadoraImc();
                    }),
                  );
                },
              ),
              ProfileMenu(
                text: "Lista de Mercado",
                icon: "assets/icons/receipt.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return listaMercado();
                    }),
                  );
                },
              ),
              ProfileMenu(
                text: "Local",
                icon: "assets/icons/Location point.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Local();
                    }),
                  );
                },
              ),
              ProfileMenu(
                text: "chat",
                icon: "assets/icons/Chat bubble Icon.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Home();
                    }),
                  );
                },
              ),
              /*
              ProfileMenu(
                text: "image",
                icon: "assets/icons/Camera Icon.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MainPageImage();
                    }),
                  );
                },
              ),

               */
              ProfileMenu(
                text: "Cadastrar item",
                icon: "assets/icons/Plus Icon.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return SalvarDados();
                    }),
                  );
                },
              ),



              ProfileMenu(
                text: "Deslogar",
                icon: "assets/icons/Log out.svg",
                press: () {
                  final provider =
                  Provider.of<ConversaProvider>(context,listen: false);//alterei provider googleProviver
                  provider.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 */