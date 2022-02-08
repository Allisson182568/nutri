import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutri/chat/provider/conversa_provider.dart';
import 'package:nutri/config/paleta.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kWhiteColorlogin,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("assets/images/logolaizenutri.png"),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Olá, Bem vindo",
                    style: TextStyle(
                      //color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Faça login na sua conta para continuar",
                    //style: TextStyle(fontSize: 16, color: Colors.black54 ),
                  ),
                ),
              ),
              Spacer(),


              FloatingActionButton.extended(

                onPressed: (){
                  final provider =
                  Provider.of<ConversaProvider>(context, listen: false);//alterei provider googleProviver
                  provider.googleLogin();
                },
                icon: Image.asset("assets/images/logogoogle.png",height: 32,width: 32,),
                label: Text('Cadastre-se com o Google',style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),



              Spacer(),


            ],
          ),
        ),
      ),
    );
  }
}
