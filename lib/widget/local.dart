import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Local extends StatefulWidget {
  const Local({Key? key}) : super(key: key);

  @override
  _LocalState createState() => _LocalState();
}

class _LocalState extends State<Local> {

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
      adUnitId: "ca-app-pub-3795771068897786/6662346813",
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Local'),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                        child: Image.asset('assets/images/logolaizenutri.png')),
                ),
              ),
            ],
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
