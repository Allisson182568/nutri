import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri/chat/telas/home.dart';
import 'package:nutri/config/paleta.dart';
import 'package:nutri/lista/lista.dart';
import 'package:nutri/widget/agenda.dart';

import '../../local.dart';
import '../../menu.dart';
import '../../perfil.dart';

class botoesCategoria extends StatefulWidget {
  const botoesCategoria({Key? key}) : super(key: key);

  @override
  _botoesCategoriaState createState() => _botoesCategoriaState();
}

class _botoesCategoriaState extends State<botoesCategoria> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Perfil();
                }),
              );
            },
            child: SizedBox(
              width: (55),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all((15)),
                    height: (55),
                    width: (55),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset('assets/icons/User.svg',color: kPrimaryColor,),
                  ),
                  SizedBox(height: 5),
                  Text('Perfil', textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Menu();
                }),
              );
            },
            child: SizedBox(
              width: (55),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all((15)),
                    height: (55),
                    width: (55),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/Phone.svg",color: kPrimaryColor,),
                  ),
                  SizedBox(height: 5),
                  Text("Menu", textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return listaMercado();
                }),
              );
            },
            child: SizedBox(
              width: (55),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all((15)),
                    height: (55),
                    width: (55),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  SizedBox(height: 5),
                  Text("Lista", textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Local();
                }),
              );
            },
            child: SizedBox(
              width: (55),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all((15)),
                    height: (55),
                    width: (55),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/Location point.svg",color: kPrimaryColor,),
                  ),
                  SizedBox(height: 5),
                  Text("Local", textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Home();
                }),
              );
            },
            child: SizedBox(
              width: (55),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all((15)),
                    height: (55),
                    width: (55),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/Chat bubble Icon.svg",color: kPrimaryColor,),
                  ),
                  SizedBox(height: 5),
                  Text("Chat", textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/User Icon.svg", "text": "Perfil"},
      {"icon": "assets/icons/Phone.svg", "text": "Cardapio"},
      {"icon": "assets/icons/Plus Icon.svg", "text": "IMC"},
      {"icon": "assets/icons/receipt.svg", "text": "Lista"},
      {"icon": "assets/icons/Discover.svg", "text": "Local"},
    ];
    return Padding(
      padding: EdgeInsets.all((20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
              (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {

            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}