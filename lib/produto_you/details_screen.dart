

import 'package:flutter/material.dart';
import 'package:nutri/config/paleta.dart';
import 'package:nutri/produto_you/produc_image.dart';
import 'package:nutri/produto_you/product.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product, required this.size, required this.image}) : super(key: key);

  final Product product;
  final Size size;
  final String image;

  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: Colors.black12, // Black color with 12% opacity
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
      appBar: buildAppBar(context),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: kCorFundo,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: '${product.id}',
                        child: ProductPoster(
                          size: size,
                          image: product.image,
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2),
                      child: Text(
                        product.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      '${product.price}G de Proteina',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kSecondaryColor,
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      child: Text(
                        product.description,
                        style: TextStyle(color: kTextLightColor),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kCorFundo,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(Icons.arrow_back_sharp,color: Colors.black54,),

        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}
