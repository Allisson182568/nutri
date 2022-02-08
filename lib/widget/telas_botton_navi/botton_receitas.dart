import 'package:flutter/material.dart';
import 'package:nutri/config/paleta.dart';
import 'package:nutri/produto_you/lista_categorias.dart';
import 'package:nutri/produto_you/product.dart';
import 'package:nutri/produto_you/produtcard.dart';

class bottomReceitas extends StatefulWidget {
  const bottomReceitas({Key? key}) : super(key: key);

  @override
  _bottomHomeState createState() => _bottomHomeState();
}

class _bottomHomeState extends State<bottomReceitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Receitas'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        //color: kPrimaryColor,
        //padding: EdgeInsets.only(top: 2),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              //ListaCategorias(),
              //SizedBox(height: 20 / 2,),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 590),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      child: ListView.builder(
                        //here we use our demo products list
                        itemCount: products.length,
                        itemBuilder: (context, index) => ProductCard(
                          itemIndex: index,
                          product: products[index],
                          press: (){},
                          image: '',

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}