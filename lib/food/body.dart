import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nutri/chat/modelos/usuario.dart';
import 'package:nutri/chat/provider/conversa_provider.dart';
import 'package:nutri/chat/telas/home.dart';
import 'package:nutri/lista/lista.dart';
import 'package:nutri/widget/cauculo_imc.dart';
import 'package:nutri/widget/local.dart';
import 'package:nutri/widget/menu.dart';
import 'package:nutri/widget/perfil.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {



  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uint8List? _arquivoImagemSelecionado;

  _uploadImagem(Usuario usuario){

    Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
    if( arquivoSelecionado != null ){
      Reference imagemPerfilRef = _storage.ref("imagens/perfil/${usuario.idUsuario}.jpg");
      UploadTask uploadTask = imagemPerfilRef.putData(arquivoSelecionado);

      uploadTask.whenComplete(() async {

        String urImagem = await uploadTask.snapshot.ref.getDownloadURL();
        usuario.urlImagem = urImagem;

        //Atualiza url e nome nos dados do usuário
        await _auth.currentUser?.updateDisplayName(usuario.nome);
        await _auth.currentUser?.updatePhotoURL(usuario.urlImagem);

        final usuariosRef = _firestore.collection("usuarios");
        usuariosRef.doc(usuario.idUsuario)
            .set( usuario.toMap() )
            .then((value){

          //tela principal
          Navigator.pushReplacementNamed(context, "/home");


        });

      });

    }

  }



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
          padding: const EdgeInsets.only(top:80.0),
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
                text: "Lista de mercado",
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
                text: "Chat",
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
              ProfileMenu(
                text: "Deslogar",
                icon: "assets/icons/Log out.svg",
                press: () {
                  final provider =
                  Provider.of<ConversaProvider>(context,listen: false); //alterei provider googleProviver
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