import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SalvarDados extends StatefulWidget {
  const SalvarDados({Key? key}) : super(key: key);

  @override
  _SalvarDadosState createState() => _SalvarDadosState();
}

class _SalvarDadosState extends State<SalvarDados> {

  TextEditingController limparTituloControler = TextEditingController();
  TextEditingController limparDescricaoControler = TextEditingController();
  TextEditingController limparEmailControler = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  // limpar campos de texto
  void _resetFieldEmail(){
    limparEmailControler.text = "";
  }
  void _resetFieldTitulo(){
    limparTituloControler.text = "";
  }
  void _resetFieldDescricao(){
    limparDescricaoControler.text = "";
  }

  late String item1;
  late String item2;
  String emailDieta = "allisson182568@gmail.com";

  final user = FirebaseAuth.instance.currentUser!;


  List todos = List.empty();
  String title = "";
  String description = "";
  String time = "";
  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey There"];
  }

  createToDo() {
    DocumentReference documentReference =
    FirebaseFirestore.instance
        .collection("menuDieta")
        .doc(emailDieta)
        .collection(emailDieta)
        .doc(title);

    Map<String, String> todoList = {
      "todoTitle": title,
      "todoDesc": description,
      "time": DateTime.now().toString(),
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance
        .collection("menuDieta")
        .doc(emailDieta)
        .collection(emailDieta)
        .doc(item);

    documentReference.delete().whenComplete(() => print("deleted successfully"));
  }





  @override
  Widget build(BuildContext context) {

    //salvar dados no firebase atraves de textfild
    CollectionReference users = FirebaseFirestore.instance.collection(emailDieta);



    return Scaffold(
      appBar: AppBar(
        title: Text('Salvar Dados'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: 80,),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: limparEmailControler,
                      onChanged: (value){
                        emailDieta = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'email paciente',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _resetFieldEmail,
                    icon: Icon(Icons.refresh),
                  )
                ],
              ),

              SizedBox(height: 20,),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: limparTituloControler,
                      onChanged: (value){
                        title = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Titulo',
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: _resetFieldTitulo,
                    icon: Icon(Icons.refresh),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: limparDescricaoControler,
                      onChanged: (value){
                        description = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Descrição',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _resetFieldDescricao,
                    icon: Icon(Icons.refresh),
                  )
                ],
              ),

              SizedBox(height: 25,),

              ElevatedButton(
                  style: ButtonStyle(

                  ),
                  onPressed: ()async{
                    setState(() {
                      //emailDieta;
                      createToDo();
                    });
                    //mensagem de salvo
                    Fluttertoast.showToast(
                        msg: "Salvo com Sucesso",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    /*
                    await users.add({
                      'todoDesc': title,
                      'dieta': description,
                    }).then((value) => print('salvo com sucesso'));
                    */
                  },

                  child: Text('salvar',style: TextStyle(fontSize: 20,),)


              ),
              SizedBox(height: 50,),

              /*ElevatedButton(
                  onPressed: (){
                    db.collection(emailDieta).doc().delete();
                  },
                  child: Text('Excluir')
              ),

               */
              Text(''),


            ],
          ),
        ),
      ),
    );
  }
}

