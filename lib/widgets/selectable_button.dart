import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_text_style.dart';

class SelectableButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectableButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (isSelected)
          Container(
            margin: EdgeInsets.only(top: 4),
            width: 40,
            height: 8,
            decoration: BoxDecoration(
              color: AppColor.appThemeColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(text,
                style: AppTextStyle.signuplablestyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }
}

// a class that handles the selection of two selectable buttons
class ButtonSelectionDemo extends StatefulWidget {
  @override
  _ButtonSelectionDemoState createState() => _ButtonSelectionDemoState();
}

class _ButtonSelectionDemoState extends State<ButtonSelectionDemo> {
  int selectedButtonIndex = 0;

  void selectButton(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableButton(
            text: 'اشتراك',
            isSelected: selectedButtonIndex == 0,
            onPressed: () => selectButton(0),
          ),
          SizedBox(width: 20),
          SelectableButton(
            text: 'تسجيل الدخول',
            isSelected: selectedButtonIndex == 1,
            onPressed: () => selectButton(1),
          ),
        ],
      ),
    );
  }
}
