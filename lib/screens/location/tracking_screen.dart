// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:search_map_location/search_map_location.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
import 'package:swift_user1/constant/apiendpoints.dart';
import 'package:swift_user1/screens/location/location_screen.dart';
import 'package:swift_user1/utils/utils.dart' as utils;
import 'package:location/location.dart' as loc;
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_screen_size.dart';

import 'package:swift_user1/screens/tracking_2.dart';

class TrackingScreen extends StatefulWidget {
  static String id = 'tracking_screen';
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  bool isLoading = false;
  LatLng? latlng;
  LatLng? currentLocation;
  double sheetheightRatio = 0.2;
  var destination;
  var pickup;

  // get the current location of the user in the init state
  void getCurrentLocation() async {
    setState(() => isLoading = true);
    loc.Location location = new loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() => isLoading = false);
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        setState(() => isLoading = false);
        return;
      }
    }

    locationData = await location.getLocation();
    Uri locationUrl =
        Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
      'latlng': '${locationData.latitude},${locationData.longitude}',
      'key': 'AIzaSyCEQQzxlXsvmykXtDyabgfThOplHcX8Udo',
    });

    final response = await http.get(locationUrl);
    final responseData = jsonDecode(response.body);
    //final address = responseData['results'][0]['formatted_address'];

    log(locationData.latitude!.toString());
    log(locationData.longitude!.toString());
    //log(address!.toString());

    latlng = new LatLng(
        locationData.latitude!.toDouble(), locationData.longitude!.toDouble());
    //TODO: Add the user's location to the database and provider
    currentLocation = latlng;
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            latlng == null
                ? AppSceenSize.loadingIcon
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: latlng!,
                      zoom: 14,
                    ),
                    onTap: (LatLng latLng) {
                      setState(() {
                        latlng = latLng;
                      });
                      utils.showBottomSheet(
                        context,
                        sheetContent: sheetContent(),
                        latlng: latlng,
                        screenHeightratio: sheetheightRatio,
                      );
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('m1'),
                        position: latlng!,
                      ),
                    },
                  ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () => utils.showBottomSheet(
                  context,
                  sheetContent: sheetContent(),
                  latlng: latlng,
                  screenHeightratio: sheetheightRatio,
                ),
                child: const Icon(Icons.info_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sheetContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //the iphone line in the top
          Container(
            height: 5,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 206, 204, 204),
            ),
          ),
          const SizedBox(height: 40),
          // the fake text field + the location icon
          Container(
            margin: const EdgeInsets.only(left: 10),
            // child: SearchLocation(
            //   iconColor: Colors.red,
            //   icon: Icons.location_pin,
            //   placeholder: 'Where to ?',
            //   apiKey: mapApiKey,
            //   onSelected: (Place place) async {
            //     final geolocation = await place.geolocation;
            //     print(place.description);
            //     print(geolocation!.coordinates);
            //     setState(() {
            //       pickup = geolocation.coordinates;
            //     });
            //   },
            // ),
            child: Row(
              children: [
                //loctation icon
                const Icon(Icons.location_pin, color: Colors.red, size: 40),
                const SizedBox(width: 15),
                // the fake text field
                GestureDetector(
                  onTap: () {
                    //TODO:MAKE A NEW SCREEN
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LocationScreen(),
                      ),
                    );
                  },
                  child: Material(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      width: AppSceenSize.getWidth(context) / 1.5,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        "Where to ?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Add additional information about the location based on your needs
        ],
      ),
    );
  }
}
