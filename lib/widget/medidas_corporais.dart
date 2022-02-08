import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri/config/paleta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class medidasCorporais extends StatefulWidget {
  const medidasCorporais({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<medidasCorporais> {
  TextEditingController _controllerCampoAltura = TextEditingController();

  String _altura = "Altura";

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
        .collection("medidasCorporais")
        .doc(user.email)
        .collection(user.email.toString())
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
                          .collection("medidasCorporais")
                          .doc(user.email)
                          .collection(user.email.toString())
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

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //config para anuncio interstitial
  InterstitialAd? _insterstitialAd;
  bool isLoadedInter = false;

  // config para anuncio banner
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //config para anuncio interstitial
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3795771068897786/9067721133',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad){
          setState(() {
            isLoadedInter = true;
            this._insterstitialAd = ad;
          });
        },
        onAdFailedToLoad: (error){
          print('erro ao carregar interstitial ');
        },
      ),
    );

    // config para anuncio banner
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3795771068897786/1954490207",
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
        print("Banner Ad Loaded");
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      request: AdRequest(),
    );
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas Corporais'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),

                SizedBox(height: 20,),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("medidasCorporais")
                      .doc(user.email)
                      .collection(user.email.toString())
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
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  elevation: 4,
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : ""),
                                    ),

                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Text((documentSnapshot != null)
                                          ? ((documentSnapshot["todoDesc"] != null)
                                          ? documentSnapshot["todoDesc"]
                                          : "")
                                          : ""),
                                    ),




                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          //todos.removeAt(index);
                                          deleteTodo((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : "");
                                        });
                                      },
                                    ),
                                  ),
                                )
                            );
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

              ],

            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Adicinar Item"),
                  content: Container(
                    width: 400,
                    height: 150,
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Item'
                          ),
                          onChanged: (String value) {
                            title = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Medida'
                          ),
                          onChanged: (String value) {
                            description = value;
                          },
                        ),




                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //todos.add(title);
                            createToDo();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Adicionar"))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
          height: 60,
          child: Column(
            children: [
              Spacer(),
              isLoaded
                  ? Container(
                height: 60,
                width: 468,
                child: AdWidget(
                  ad: bannerAd!,
                ),
              )
                  : SizedBox()
            ],
          )),
    );
  }
}
