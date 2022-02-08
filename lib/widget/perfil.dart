import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri/chat/provider/conversa_provider.dart';
import 'package:nutri/config/paleta.dart';
import 'package:nutri/food/profile_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'medidas_corporais.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController _controllerCampoAltura = TextEditingController();

  String _altura = "Altura";


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

    return WillPopScope(
      onWillPop: ()async{
        print('back buton pressed');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          backgroundColor: Theme.of(context).primaryColor,//remover botao volta padrao
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: corFundo,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    user.displayName!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [],
                  ),
                  SizedBox(height: 20,),
                  Text('Medidas Corporais'),
                  SizedBox(height: 20,),
                  ProfileMenu(
                    text: "Medidas Corporais",
                    icon: "assets/icons/receipt.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return medidasCorporais();
                        }),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: "Deslogar",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      final provider =
                      Provider.of<ConversaProvider>(context,listen: false);//alterei provider googleProviver
                      provider.logout();
                    },
                  ),


                ],

              ),
            ),
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
      ),
    );
  }
}
