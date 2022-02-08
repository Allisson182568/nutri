import 'package:flutter/material.dart';
import 'package:nutri/chat/provider/conversa_provider.dart';
import 'package:nutri/chat/telas/home.dart';
import 'package:nutri/food/profile_menu.dart';
import 'package:nutri/food/profile_pic.dart';
import 'package:nutri/lista/lista.dart';
import 'package:nutri/perfil_master/body_master.dart';
import 'package:nutri/perfil_master/salvar_lista_banner_home.dart';
import 'package:provider/provider.dart';

import '../cauculo_imc.dart';
import '../local.dart';
import '../menu.dart';
import '../perfil.dart';
import '../../perfil_master/salvar_dados.dart';

class bottonConfiMaster extends StatefulWidget {
  const bottonConfiMaster({Key? key}) : super(key: key);

  @override
  _bottonConfiMasterState createState() => _bottonConfiMasterState();
}

class _bottonConfiMasterState extends State<bottonConfiMaster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil Master'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.only(top:28.0),
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
                text: "Cadastrar item cardapio",
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
                text: "Cadastrar item home",
                icon: "assets/icons/Plus Icon.svg",
                press: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return salvarListaBanneHome();
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
