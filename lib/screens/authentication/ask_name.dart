// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_text_style.dart';
import 'package:swift_user1/screens/home.dart';
import 'package:swift_user1/widgets/text_field_input.dart';

class AskName extends StatelessWidget {
  AskName({super.key});
  var nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Let\'s start by\n  knowing your name.\n    It\'ll make things more fun!',
                  //style: AppTextStyle.onboaringTitle.copyWith(
                  //  color: AppColor.appThemecolor, fontFamily: "Josefin Sans"),
                  style: TextStyle(
                    color: AppColor.appThemeColor,
                    fontFamily: "Josefin Sans",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 50),
              TextFieldInput(
                hintText: 'Enter your name',
                textInputType: TextInputType.name,
                //TODO: Upload the name to provider
                textEditingController: nameController,
              ),
              const SizedBox(height: 260),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColor.btnColorYellow,
                    ),
                  ),
                  onPressed: () {
                    nameController.text != Null
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                userName: nameController.text,
                                role: "user",
                              ),
                            ),
                          )
                        : 0;
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: AppColor.appThemeColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
