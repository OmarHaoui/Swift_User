// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import 'package:uber_pro_kolkata/constant/app_color.dart';
// import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
// import 'package:uber_pro_kolkata/services/location_service.dart';
// import 'package:uber_pro_kolkata/utils/utils.dart';
// import 'package:uber_pro_kolkata/view/screens/home/home.dart';
// import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController nameController = TextEditingController();
//   bool isLoading = false;
//   TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               "Set up your MY RIDE account",
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Your name helps driver to find your identity An Email Address let us share update information about us",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 25),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 hintText: "Full name",
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 hintText: "Email",
//               ),
//             ),
//             SizedBox(height: 100),
//             isLoading
//                 ? AppSceenSize.loadingIcon
//                 : Container(
//                     width: AppSceenSize.getWidth(context) * 0.45,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             AppColor.btncoloryellow),
//                       ),
//                       onPressed: () async {
//                         if (nameController.text.isEmpty ||
//                             emailController.text.isEmpty) {
//                           context.showSnackBar(
//                               message: "Please fill all the information");
//                           return;
//                         }
//                         changeLoading();
//                         Map<String, dynamic> body = {
//                           "first_name": nameController.text,
//                           "email": emailController.text,
//                         };
//                         CustomerProfile _provider =
//                             Provider.of<CustomerProfile>(context,
//                                 listen: false);
//                         await _provider.updateProfile(context, body);
//                         await LocationServices().checkPermissions();
//                         Position position =
//                             await LocationServices().currentLocation();

//                         changeLoading();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Home(startingPosition: position),
//                             ));
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [Text('Register')],
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   void changeLoading() {
//     setState(() {
//       isLoading = !isLoading;
//     });
//   }
// }
