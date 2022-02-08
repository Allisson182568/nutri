import 'package:flutter/material.dart';
import 'package:nutri/config/paleta.dart';


class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.purple,
              Colors.deepPurple,
            ]
        ),
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: ktrans,
            child: Image.asset('assets/images/relogio_co.png'),
            //backgroundImage: NetworkImage(user.photoURL!),
          ),
          SizedBox(width: 15,),
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(text: "     Comece agora\n"),
                TextSpan(
                  text: "Jejum Intermitente",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}