// ignore_for_file: unnecessary_new
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
// import 'package:search_map_location/widget/search_widget.dart';
import 'package:swift_user1/constant/apiendpoints.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_screen_size.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var pickupController = new TextEditingController();
  var destinationController = new TextEditingController();
  var destination;
  var pickup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the card in the top of the screen
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Color.fromARGB(255, 66, 37, 37),
                ),
              ],
              color: AppColor.primaryColor,
            ),
            height: AppSceenSize.getHeight(context) * 0.33,
            padding:
                const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 10),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          //location icon
                          const Icon(
                            Icons.blur_circular,
                            color: AppColor.appThemeColor,
                            size: 30,
                          ),
                          const SizedBox(width: 15),
                          // the text field
                          Material(
                            elevation: 5,
                            child: Container(
                              width: AppSceenSize.getWidth(context) / 1.5,
                              height: 47,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(2)),
                              child: TextField(
                                onTap: () async {
                                  //TODO:
                                  Prediction? p = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: mapApiKey,
                                    language: "pt",
                                    components: [
                                      Component(Component.country, "mz"),
                                    ],
                                  );

                                  if (p != null) {}
                                },
                                decoration: const InputDecoration(
                                    constraints: BoxConstraints.expand(),
                                    border: InputBorder.none,
                                    hintText: 'Enter pickup point',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          //location icon
                          const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 30,
                          ),
                          const SizedBox(width: 15),
                          // the text field
                          Material(
                            elevation: 5,
                            child: Container(
                              width: AppSceenSize.getWidth(context) / 1.5,
                              height: 47,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(2)),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Where to ?',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text(
              "Saved places",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: AppColor.appThemeColor,
                  size: 30,
                ),
                Icon(
                  Icons.search,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
              ],
            ),
            onTap: () {
              //TODO:
            },
          ),
          ListTile(
            title: const Text(
              "Set loction on map",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 30,
                ),
                Icon(
                  Icons.location_on_outlined,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
              ],
            ),
            onTap: () {
              //TODO:
            },
          ),
        ],
      ),
    );
  }
}
