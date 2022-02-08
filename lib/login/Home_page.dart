import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutri/login/sign_up_widget.dart';

import 'logged_in_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if (snapshot.hasData){
          return LoggedInWidget();
        }else if (snapshot.hasError){
          return Center(child: Text('algo deu errado!'));
        }else{
          return SignUpWidget();
        }
        return SignUpWidget();
      },
    ),
  );
}
