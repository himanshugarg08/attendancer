import 'package:attendancer_final_code/backend/data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/screens/dashboard.dart';
//import 'package:attendancer_final_code/screens/swipe_screen.dart';
import 'package:attendancer_final_code/widgets/input_container.dart';
import 'package:attendancer_final_code/widgets/my_button.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClass extends StatelessWidget {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _suffixController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kIconColor_b),
        backgroundColor: kTransparentColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Consumer<BackEnd>(
        builder: (context, data, child) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.getWidth(7),
              vertical: SizeConfig.getHeight(4)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: "Add Class:", size: 36, weight: FontWeight.w400),
                VerticalSpacing(
                  of: 8,
                ),
                Form(
                  child: Column(
                    children: [
                      InputContainer(
                        displayText: "Enter Class Name:",
                        cont: _classNameController,
                      ),
                      VerticalSpacing(),
                      InputContainer(
                          displayText: "Enter Prefix:",
                          cont: _prefixController),
                      VerticalSpacing(),
                      InputContainer(
                          displayText: "Enter Suffix:",
                          cont: _suffixController),
                      VerticalSpacing(),
                      InputContainer(
                        displayText: "Enter Start of ID:",
                        cont: _startController,
                        textInputType: TextInputType.number,
                      ),
                      VerticalSpacing(),
                      InputContainer(
                        displayText: "Enter End of ID:",
                        cont: _endController,
                        textInputType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(
                  of: 8,
                ),
                GestureDetector(
                    onTap: () {
                      if (_classNameController.text != "" &&
                          _startController.text != "" &&
                          _endController.text != "") {
                        data.addclass(
                            StringUtils.capitalize(_classNameController.text),
                            int.parse(_startController.text),
                            int.parse(_endController.text),
                            _prefixController.text,
                            _suffixController.text);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DashBoard();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const MyText(
                            text: "Input Fields can't be null",
                            size: 16,
                            color: kFontColor,
                          ),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                    },
                    child: MyButton(displayText: "Add Class")),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
