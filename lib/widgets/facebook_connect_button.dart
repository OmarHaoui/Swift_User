import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_asset_image.dart';
import 'package:swift_user1/constant/app_color.dart';

class FacebookConnectButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FacebookConnectButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.fbColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssetImage.fbLogo,
            height: 30.0,
            width: 30.0,
          ),
          const SizedBox(width: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: const Text(
              'Connect with Facebook',
              style: TextStyle(
                color: AppColor.fbColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
