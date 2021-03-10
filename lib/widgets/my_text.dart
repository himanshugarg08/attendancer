import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;

  const MyText(
      {Key key,
      @required this.text,
      @required this.size,
      this.weight = FontWeight.w500,
      this.color = kFontColor_b})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.fade,
      style: textStyle(size, weight, color),
    );
  }
}
