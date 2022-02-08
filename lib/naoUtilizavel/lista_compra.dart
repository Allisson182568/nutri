import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri/config/paleta.dart';

//nao utilizavel

class ListaCompra extends StatefulWidget {
  const ListaCompra({Key? key}) : super(key: key);

  @override
  _SegundaState createState() => _SegundaState();
}


class _SegundaState extends State<ListaCompra> {

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
      adUnitId: 'ca-app-pub-3795771068897786/2047017215',
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
      adUnitId: "ca-app-pub-3795771068897786/1607839992",
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

  @override
  Widget build(BuildContext context) {

    var collection = FirebaseFirestore.instance.collection('lista');

    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas Corporais'),
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
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10,top: 20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('lista').snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  decoration: BoxDecoration(

                  ),
                  child: ListView(
                    children: snapshot.data!.docs.map((documents){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          //trailing: Icon(Icons.delete),
                          title: Text(documents["item"],style: TextStyle(fontSize: 20),),
                          onLongPress: (){
                             collection.doc().delete();
                          },
                        ),
                      );
                    }).toList(),
                  ),

                );
              }
          ),
        ),
        bottomNavigationBar: Container(
            height: 80,
            child: Column(
              children: [
                Spacer(),
                isLoaded
                    ? Container(
                      height: 70,
                      width: 468,
                      child: AdWidget(
                    ad: bannerAd!,
                  ),
                )
                    : SizedBox(),

              ],
            )
        ),
      ),
    );
  }
}

