// ignore_for_file: unnecessary_new
import 'dart:math' as math;

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/screens/rides_diso.dart';
import 'package:swift_user1/utils/utils.dart' as utils;
import 'package:swift_user1/constant/app_screen_size.dart';
import '../utils/dummy_data.dart';
import 'booking.dart';

class TrackingScreen2 extends StatefulWidget {
  static String id = 'tracking_screen2';
  LatLng? currentLocation;
  LatLng destination;
  LatLng pickup;
  TrackingScreen2(
      {super.key,
      required this.currentLocation,
      required this.destination,
      required this.pickup});

  @override
  State<TrackingScreen2> createState() => _TrackingScreen2State();
}

class _TrackingScreen2State extends State<TrackingScreen2> {
  bool isLoading = false;
  double sheetheightRatio = 0.4;
  late GoogleMapController _controller;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(widget.destination.toString()),
          position: widget.destination,
          infoWindow: const InfoWindow(
            title: 'destination',
          ),
        ),
      );

      _markers.add(
        Marker(
          markerId: MarkerId(widget.pickup.toString()),
          position: widget.pickup,
          infoWindow: const InfoWindow(
            title: 'pickup',
          ),
        ),
      );

      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route1'),
          visible: true,
          points: [widget.destination, widget.pickup],
          color: Colors.blue,
        ),
      );
    });

    final centerPoint = getCenterPoint(widget.destination, widget.pickup);
    final bounds = getLatLngBounds(widget.destination, widget.pickup);
    _controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100.0) // Adjust padding as needed
        );
  }

  LatLngBounds getLatLngBounds(LatLng marker1, LatLng marker2) {
    final southWestLat = math.min(marker1.latitude, marker2.latitude);
    final southWestLng = math.min(marker1.longitude, marker2.longitude);
    final northEastLat = math.max(marker1.latitude, marker2.latitude);
    final northEastLng = math.max(marker1.longitude, marker2.longitude);
    return LatLngBounds(
        southwest: LatLng(southWestLat, southWestLng),
        northeast: LatLng(northEastLat, northEastLng));
  }

  LatLng getCenterPoint(LatLng marker1, LatLng marker2) {
    final centerLatitude = (marker1.latitude + marker2.latitude) / 2;
    final centerLongitude = (marker1.longitude + marker2.longitude) / 2;
    return LatLng(centerLatitude, centerLongitude);
  }

  @override
  @override
  Widget build(BuildContext context) {
    Widget sheetContent() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 35.0),
              child: Text(': الانطلاق', style: TextStyle(fontSize: 15)),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'موقعك الحالي', // TODO: Get the name of the current loaction
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 10),
                Icon(Icons.blur_circular,
                    size: 30, color: AppColor.appThemeColor),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 13),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      ': الوجهة',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  DottedLine(
                    direction: Axis.vertical,
                    lineLength: 50, // Set the length of the dotted line
                    lineThickness: 2.0,
                    dashLength: 4.0,
                    dashColor: Colors.grey,
                    dashRadius: 10.0,
                    dashGapLength: 3.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //SizedBox(width: 10),
                Text(
                  'بوينان', // TODO: Get the name of the destination
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 10),
                Icon(Icons.location_pin, size: 30, color: Colors.red),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 85),
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RidesDsipo(
                        avaiDrivers: DummyData.availableDrivers,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'تأكيد مكان الوصول',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.appThemeColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            widget.currentLocation == null
                ? AppSceenSize.loadingIcon
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: widget.destination,
                      zoom: 14.0,
                    ),
                    onMapCreated: _onMapCreated,
                    onTap: (LatLng latLng) {
                      utils.showBottomSheet(
                        context,
                        sheetContent: sheetContent(),
                        latlng: widget.currentLocation,
                        screenHeightratio: sheetheightRatio,
                      );
                    },
                    markers: _markers,
                    polylines: _polylines,
                  ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () => utils.showBottomSheet(
                  context,
                  sheetContent: sheetContent(),
                  latlng: widget.currentLocation,
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
}
