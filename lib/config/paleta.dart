import 'package:flutter/material.dart';

const kWhiteColor = Color(0xFFFFFFFF);
const kBarraColor = Color(0xFF4A3298);
const kWhiteColorlogin = Color(0xFFFFFFFE);
const kBlackColor = Color(0xFF000000);
const kTextColor = Color(0xFF1D150B);
const kPrimaryColor = Color(0xFFFF7643);
const kSecondaryColor = Color(0xFFFDDB3A);
const kBorderColor = Color(0xFFDDDDDD);
const kBackSplas = Color(0xFFffbd32);
const kFundo = Color(0xFF2A282A);
const kFundoBtn = Color(0xFF3D3C3E);
const ktrans = Colors.transparent;
const kForegroundColor = Colors.black54;
const Color corPrimaria = Color(0xff075E54);
const Color corDestaque = Color(0xff25D366);
const Color corFundo = Color(0xffD9DBD5);
const Color corFundoBarra = Color(0xffededed);
const Color corFundoBarraClaro = Color(0xfff6f6f6);
const kCorFundo = Color(0xFFFFFFFF);
const kTextLightColor = Color(0xFF747474);
const kBarraColorGrad = LinearGradient(
    colors: [
      Colors.pink,
      Colors.purple,
      Colors.purpleAccent,
    ]
);

const kDefaultPadding = 20.0;
const ConstantePadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

