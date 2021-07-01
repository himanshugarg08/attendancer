import 'package:attendancer_final_code/backend/dashboard_data_provider.dart';
import 'package:attendancer_final_code/backend/database_helper.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/configs/utils.dart';
import 'package:attendancer_final_code/screens/dashboard.dart';
import 'package:attendancer_final_code/widgets/input_container.dart';
import 'package:attendancer_final_code/widgets/my_button.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserNameInput extends StatefulWidget {
  @override
  _UserNameInputState createState() => _UserNameInputState();
}

class _UserNameInputState extends State<UserNameInput> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: color5,
          child: Stack(
            children: [
              Column(
                children: [
                  VerticalSpacing(of: 8),
                  Image.asset("assets/attendance_logo2.png"),
                ],
              ),
              Column(
                children: [
                  VerticalSpacing(of: 60),
                  buildInputContainer(firstNameController, "Enter First Name:"),
                  VerticalSpacing(of: 2),
                  buildInputContainer(lastNameController, "Enter Last Name:"),
                  VerticalSpacing(of: 3),
                  Consumer<DashBoardDataProvider>(
                    builder: (context, data, child) => GestureDetector(
                        onTap: () async {
                          if (firstNameController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: MyText(
                              text: "First Name can't be empty.",
                              size: 18,
                              color: kFontColor,
                            )));
                          } else if (lastNameController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: MyText(
                              text: "Last Name can't be empty.",
                              size: 18,
                              color: kFontColor,
                            )));
                          } else {
                            userData = {
                              'FirstName': StringUtils.capitalize(
                                  firstNameController.text),
                              'LastName': StringUtils.capitalize(
                                  lastNameController.text),
                              'StartDate': DateTime.now().day.toString(),
                              'LastDate': DateTime.now().day.toString(),
                              'DarkMode': 0
                            };
                            int userId = await DatabaseHelper.instance
                                .addUserData(userData);
                            if (userId != null) {
                              // Provider.of<DashBoardDataProvider>(context)
                              //     .textToDisplay(firstNameController.text,
                              //         lastNameController.text);
                              data.textToDisplay(
                                  StringUtils.capitalize(Utils()
                                      .getStringWithoutSpace(
                                          firstNameController.text)),
                                  StringUtils.capitalize(Utils()
                                      .getStringWithoutSpace(
                                          lastNameController.text)));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return DashBoard();
                              }));
                            }
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.getWidth(8)),
                            child: MyButton(displayText: "Start"))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildInputContainer(TextEditingController cont, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(8)),
      child: InputContainer(
        cont: cont,
        displayText: text,
      ),
    );
  }
}
