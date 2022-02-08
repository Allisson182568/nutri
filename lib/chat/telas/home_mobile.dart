import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutri/chat/componentes/lista_contatos.dart';
import 'package:nutri/chat/componentes/lista_conversas.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Chat"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
              tabs: [
                Tab(text: "Conversas",),
                Tab(text: "Contatos",),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListaConversas(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListaContatos(),
                )

              ],
            ),
          ),

        )
    );
  }
}
