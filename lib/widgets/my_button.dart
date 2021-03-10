import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String displayText;
  final double size;

  const MyButton({Key key, this.displayText, this.size = 100})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: SizeConfig.getWidth(size),
        padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(1.35)),
        child: Center(
          child: Text(displayText,
              textAlign: TextAlign.center,
              style: textStyle(20, FontWeight.w400, kFontColor)),
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
