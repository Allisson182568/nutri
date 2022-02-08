import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Usuario{

  final user = FirebaseAuth.instance.currentUser!;

  String idUsuario;
  String nome;
  String email;
  String urlImagem;

  Usuario(
      this.idUsuario,
      this.nome,
      this.email,
      {this.urlImagem = ""}
      );

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "idUsuario" : user.uid,
      "nome" : user.displayName,
      "email" : user.email,
      "urlImagem" : user.photoURL,
    };

    return map;

  }

}