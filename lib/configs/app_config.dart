import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Colors.pink;
const kSecondarycolor = Colors.blue;
const kTransparentColor = Colors.transparent;

const color1 = Color(0xffe0c4cf);
const color2 = Color(0xffbb7c93);
const color3 = Color(0xffb26d86);
const color4 = Color(0xffa34e6d);
const color5 = Color(0xff7c0b34);

const kFontColor = Colors.white;
const kIconColor = Colors.white;
const kFontColor_b = Colors.black;
const kIconColor_b = Colors.black;

const kDefaultHeight = 2.0;

TextStyle textStyle(double size, FontWeight weight, Color color) {
  return TextStyle(
      fontFamily: "Poppins", fontSize: size, fontWeight: weight, color: color);
  // GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
}

class SizeConfig {
  static MediaQueryData mediaQuery;
  static double screenHeight;
  static double screenWidth;
  static double screenHeightWithPadding;
  static double screenWidthWithPadding;
  static double screenWidthPadding;
  static double screenHeightPadding;

  void init(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;
    screenWidthPadding = mediaQuery.padding.left + mediaQuery.padding.right;
    screenHeightPadding = mediaQuery.padding.top + mediaQuery.padding.bottom;
    screenHeightWithPadding = screenHeight - screenHeightPadding;
    screenWidthWithPadding = screenWidth - screenWidthPadding;
  }

  static double getHeight(double height) {
    return (screenHeightWithPadding / 100) * height;
  }

  static double getWidth(double width) {
    return (screenWidthWithPadding / 100) * width;
  }
}

class VerticalSpacing extends StatelessWidget {
  final double of;

  const VerticalSpacing({Key key, this.of = kDefaultHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.getHeight(of),
    );
  }
}
