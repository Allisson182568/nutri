import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri/config/paleta.dart';

class calculadoraImc extends StatefulWidget {
  const calculadoraImc({Key? key}) : super(key: key);



  @override
  _calculadoraImcState createState() => _calculadoraImcState();
}

class _calculadoraImcState extends State<calculadoraImc> {

  TextEditingController weightControler = TextEditingController();
  TextEditingController heightControler = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados";

  void _resetField(){
    weightControler.text = "";
    heightControler.text = "";
    setState(() {
      _infoText = "Informe seus Dados: ";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate(){
    setState(() {
      double weigth = double.parse(weightControler.text);
      double heigth = double.parse(heightControler.text) /100;
      double imc = weigth / (heigth*heigth);
      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.5 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40){
        _infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(3)})";
      }
    });

  }

  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3795771068897786/4195965577",
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Calculadora IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Image.asset('assets/images/imclogo.png',height: 190,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 18.0, right: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 50,
                        color: kBlackColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (Kg)",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          alignLabelWithHint: false,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          )),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25
                      ),
                      controller: weightControler,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Insira seu Peso";
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 30,left: 18.0, right: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 50,
                        color: kBlackColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                          )),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25
                      ),
                      controller: heightControler,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Insira sua Altura";
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32, 30, 32, 30),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "calcular",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                    //color: Colors.green,
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //color: Colors.green,
                    fontSize: 25
                ),
              ),
            ],
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
          )
      ),
    );
  }
}
