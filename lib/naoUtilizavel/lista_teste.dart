import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri/config/paleta.dart';

class ListaTeste extends StatefulWidget {
  const ListaTeste({Key? key}) : super(key: key);

  @override
  _SegundaState createState() => _SegundaState();
}


class _SegundaState extends State<ListaTeste> {

  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3795771068897786/7324361251",
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
    String? idUsuario = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cardapio',style: TextStyle(color: kBorderColor),),
        foregroundColor: kBorderColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,top: 20),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('treino').snapshots(),
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
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: snapshot.data!.docs.map((documents){
                      return ListTile(
                        title: Text(documents[idUsuario],style: TextStyle(fontSize: 20),),
                        //subtitle: Text(documents["segunda"],style: TextStyle(fontSize: 20),),
                      );
                    }).toList(),
                  ),
                ),


              );
            }
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
    );
  }
}

