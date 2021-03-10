import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppIcon extends StatelessWidget {
  final IconData icon;
  final AlignmentGeometry alignment;

  const MyAppIcon({Key key, this.icon, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getHeight(2.5)),
      child: Align(
        alignment: alignment,
        child: FaIcon(icon),
      ),
    );
  }
}
