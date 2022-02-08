import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutri/widget/telas_botton_navi/widget_para_botom/categories.dart';
import 'package:nutri/widget/telas_botton_navi/widget_para_botom/desconto_baner.dart';
import 'package:nutri/widget/telas_botton_navi/widget_para_botom/lista_banner_home.dart';
import 'package:nutri/widget/telas_botton_navi/widget_para_botom/popular_product.dart';
import 'package:nutri/widget/telas_botton_navi/widget_para_botom/special_offers.dart';

class bottomHome extends StatefulWidget {
  const bottomHome({Key? key}) : super(key: key);

  @override
  _bottomHomeState createState() => _bottomHomeState();
}

class _bottomHomeState extends State<bottomHome> {

  final user = FirebaseAuth.instance.currentUser!;

  List todos = List.empty();
  String title = "";
  String description = "";
  String time = "";
  String image = "";
  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey There"];
  }

  createToDo() {
    DocumentReference documentReference =
    FirebaseFirestore.instance
        .collection("listaBanneHome")
        .doc(user.email)
        .collection(user.uid)
        .doc(title);

    Map<String, String> todoList = {
      "todoTitle": title,
      "todoDesc": description,
      "todoImage": image,
      "time": DateTime.now().toString(),
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(item) {

    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('Deletar'),
          contentPadding: EdgeInsets.all(20.0),
          children: [
            Text('Certeza que deseja deletar'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: (){
                      DocumentReference documentReference =
                      FirebaseFirestore.instance
                          .collection("listaBanneHome")
                          .doc("listaBanneHome")
                          .collection("listaBanneHome")
                          .doc(item);

                      documentReference.delete().whenComplete(() => print("deleted successfully"));

                      Navigator.pop(context);

                    },
                    child: Text('Sim')
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Não')
                )
              ],
            )

          ],
        )
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nutri'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: (10)),
            botoesCategoria(),
            DiscountBanner(),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("listaBanneHome")
                  .doc("listaBanneHome")
                  .collection("listaBanneHome")
                  .orderBy('time',descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Algo deu errado');
                } else if (snapshot.hasData || snapshot.data != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot<Object?>? documentSnapshot =
                        snapshot.data?.docs[index];
                        return Dismissible(
                            key: Key(index.toString()),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Colors.purple,
                                      Colors.deepPurple,
                                    ]
                                ),
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  child: Image.network((documentSnapshot != null) ? (documentSnapshot["todoImage"]) : ""),
                                ),

                                title: Text((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : ""
                                  ,style: TextStyle(color: Colors.white),),

                                subtitle: Text((documentSnapshot != null)
                                    ? ((documentSnapshot["todoDesc"] != null)
                                    ? documentSnapshot["todoDesc"]
                                    : "")
                                    : "",style: TextStyle(fontSize: 24,
                                    fontWeight: FontWeight.bold,color: Colors.white),),





                              ),
                            ));
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red,
                    ),
                  ),
                );
              },
            ),
            SpecialOffers(),
            SizedBox(height: (30)),
            //PopularProducts(),
            Container(
              child: Image.asset('assets/images/banner_home.jpg'),
            ),

            SizedBox(height: (30)),


          ],
        ),


      )
    );
  }
}
