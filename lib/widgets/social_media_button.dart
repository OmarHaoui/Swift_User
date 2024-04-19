import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_asset_image.dart';
import 'package:swift_user1/constant/app_color.dart';

class SocialMediaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String buttonImage;
  final Color buttonColor;
  final Color textColor;

  const SocialMediaButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonImage,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            buttonImage,
            height: 30.0,
            width: 30.0,
          ),
          const SizedBox(width: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
