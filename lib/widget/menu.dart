import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri/config/paleta.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _SegundaState createState() => _SegundaState();
}

class _SegundaState extends State<Menu> {
  //config para anuncio interstitial
  InterstitialAd? _insterstitialAd;
  bool isLoadedInter = false;

  // config para anuncio banner
  BannerAd? bannerAd;
  bool isLoaded = false;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //config para anuncio interstitial
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3795771068897786/9067721133',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            isLoadedInter = true;
            this._insterstitialAd = ad;
          });
        },
        onAdFailedToLoad: (error) {
          print('erro ao carregar interstitial ');
        },
      ),
    );

    // config para anuncio banner
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3795771068897786/9641408535",
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

  var top = 0.0;

  List todos = List.empty();
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey There"];
  }

  createToDo() {
    DocumentReference documentReference =
        FirebaseFirestore.instance
            .collection("menuDieta")
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
        builder: (contex) => SimpleDialog(
              title: Text('Deletar'),
              contentPadding: EdgeInsets.all(20.0),
              children: [
                Text('Certeza que deseja deletar'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          DocumentReference documentReference =
                              FirebaseFirestore.instance
                                  .collection("menuDieta")
                                  .doc(user.email)
                                  .collection(user.email.toString())
                                  .doc(item);

                          documentReference.delete().whenComplete(
                              () => print("deleted successfully"));

                          Navigator.pop(context);
                        },
                        child: Text('Sim')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Não'))
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Cardapio',
          style: TextStyle(color: kBorderColor),
        ),
        //remover botao volta padrao
        automaticallyImplyLeading: false,
        //botao de volta para chamar anuncio
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                if (isLoadedInter) {
                  _insterstitialAd!.show();
                }
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          print('bavk buton pressed');
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("menuDieta")
                  .doc(user.email)
                  .collection(user.email.toString())
                  .orderBy('time',descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            return Dismissible(
                                key: Key(index.toString()),
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text((documentSnapshot != null)
                                        ? (documentSnapshot["todoTitle"])
                                        : ""),
                                    subtitle: Text((documentSnapshot != null)
                                        ? ((documentSnapshot["todoDesc"] !=
                                                null)
                                            ? documentSnapshot["todoDesc"]
                                            : "")
                                        : ""),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          //todos.removeAt(index);
                                          deleteTodo((documentSnapshot != null)
                                              ? (documentSnapshot["todoTitle"])
                                              : "");
                                        });
                                      },
                                    ),
                                  ),
                                ));
                          })),
                );
              }),
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
