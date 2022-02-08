import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class listaMercado extends StatefulWidget {
  const listaMercado({Key? key}) : super(key: key);


  @override
  State<listaMercado> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<listaMercado> {


  

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
        .collection("listaMercado")
        .doc(user.email)
        .collection(user.uid)
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
                          .collection("listaMercado")
                          .doc(user.email)
                          .collection(user.uid)
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
    return WillPopScope(
      onWillPop: ()async{
        print('back buton pressed');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Lista Mercado'),
          //remover botao volta padrao
          automaticallyImplyLeading: false,
          //botao de volta para chamar anuncio
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  if(isLoadedInter){
                    _insterstitialAd!.show();
                  }
                  Navigator.of(context).pop(context);
                },
              );
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("listaMercado")
              .doc(user.email)
              .collection(user.uid)
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
                          elevation: 4,
                          child: ListTile(
                            title: Text((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : ""),

                            /*subtitle: Text((documentSnapshot != null)
                                ? ((documentSnapshot["todoDesc"] != null)
                                ? documentSnapshot["todoDesc"]
                                : "")
                                : ""),

                             */


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
                          /*TextField(
                            decoration: InputDecoration(
                                labelText: 'Medida'
                            ),
                            onChanged: (String value) {
                              description = value;
                            },
                          ),

                           */


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
            )
        ),
      ),
    );
  }
}