import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_screen_size.dart';

/// Get the image from the user's device
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  //check if the user entered an image
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No image selected");
}

/// Show a snackbar with the provided content
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(child: Text(content))),
  );
}

/// Show a bottom sheet with the provided content
void showBottomSheet(BuildContext context,
    {required Widget sheetContent,
    required LatLng? latlng,
    required double screenHeightratio}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return _buildLocationInfoSheet(
        sheetContent,
        context,
        latlng,
        screenHeightratio,
      );
    },
  );
}

/// Build the bottom sheet with the provided content
Widget _buildLocationInfoSheet(
    Widget sheetContent, context, LatLng? latlng, double screenHeightratio) {
  if (latlng == null) {
    return const Center(child: Text("No location selected"));
  }
  // Add additional information about the location based on your needs (The sheet)
  return Container(
    decoration: const BoxDecoration(
      boxShadow: [
        BoxShadow(
          blurRadius: 2.0,
          color: Color.fromARGB(255, 66, 37, 37),
        ),
      ],
      color: AppColor.primaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    width: AppSceenSize.getWidth(context),
    height: AppSceenSize.getHeight(context) *
        screenHeightratio, // Adjust height as needed
    padding: const EdgeInsets.only(top: 14, left: 16, right: 16, bottom: 16),
    child: sheetContent,
  );
}
