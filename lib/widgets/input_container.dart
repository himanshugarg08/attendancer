import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final String displayText;
  final TextEditingController cont;
  final TextInputType textInputType;

  const InputContainer({
    Key key,
    @required this.displayText,
    @required this.cont,
    this.textInputType = TextInputType.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: cont,
        style: textStyle(18, FontWeight.normal, kFontColor),
        keyboardType: textInputType,
        cursorHeight: 20,
        cursorColor: kFontColor,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: displayText,
          hintStyle: textStyle(18, FontWeight.w400, kFontColor),
        ),
      ),
      //height: screenDimention.height * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor.shade400,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
