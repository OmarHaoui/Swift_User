// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: CourseScreen(),
//     ),
//   );
// }

// class CourseScreen extends StatefulWidget {
//   const CourseScreen({Key? key}) : super(key: key);

//   @override
//   _CourseScreenState createState() => _CourseScreenState();
// }

// class _CourseScreenState extends State<CourseScreen> {
//   GoogleMapController? _controller;
//   TextEditingController _originController = TextEditingController();
//   TextEditingController _destinationController = TextEditingController();
//   LatLng? _origin;
//   LatLng? _destination;
//   Set<Polyline> _polylines = {};
//   bool _useMapIntegration = false;

//   @override
//   void initState() {
//     super.initState();
//     _originController.addListener(() => _searchLocation(true));
//     _destinationController.addListener(() => _searchLocation(false));
//   }

//   @override
//   void dispose() {
//     _originController.dispose();
//     _destinationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Define Course"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _originController,
//               decoration: InputDecoration(
//                 labelText: 'Origin',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(12),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _destinationController,
//               decoration: InputDecoration(
//                 labelText: 'Destination',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(12),
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showRoute();
//                     },
//                     child: Text('Show Route'),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 DropdownButton<bool>(
//                   value: _useMapIntegration,
//                   onChanged: (value) {
//                     setState(() {
//                       _useMapIntegration = value!;
//                     });
//                   },
//                   items: [
//                     DropdownMenuItem(
//                       value: false,
//                       child: Text('Manual Input'),
//                     ),
//                     DropdownMenuItem(
//                       value: true,
//                       child: Text('Map Integration'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: _useMapIntegration
//                   ? GoogleMap(
//                       onMapCreated: (controller) {
//                         setState(() {
//                           _controller = controller;
//                         });
//                       },
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(36.7528, 3.0420),
//                         zoom: 12.0,
//                       ),
//                       markers: Set.of([
//                         if (_origin != null)
//                           Marker(
//                             markerId: MarkerId("origin"),
//                             position: _origin!,
//                           ),
//                         if (_destination != null)
//                           Marker(
//                             markerId: MarkerId("destination"),
//                             position: _destination!,
//                           ),
//                       ]),
//                       polylines: _polylines,
//                       myLocationEnabled: true,
//                       myLocationButtonEnabled: true,
//                     )
//                   : Container(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add any additional functionality for the FAB
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _searchLocation(bool isOrigin) async {
//     TextEditingController controller =
//         isOrigin ? _originController : _destinationController;
//     String searchText = controller.text;

//     if (searchText.isNotEmpty) {
//       List<Location> locations = await locationFromAddress(searchText);

//       if (locations.isNotEmpty) {
//         LatLng locationLatLng =
//             LatLng(locations[0].latitude, locations[0].longitude);

//         setState(() {
//           if (isOrigin) {
//             _origin = locationLatLng;
//           } else {
//             _destination = locationLatLng;
//           }
//         });

//         _moveCamera();
//       } else {
//         // Handle case where no location is found
//         print("Location not found");
//       }
//     }
//   }

//   void _showRoute() async {
//     if (_origin != null && _destination != null) {
//       PolylinePoints polylinePoints = PolylinePoints();
//       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         'AIzaSyCEQQzxlXsvmykXtDyabgfThOplHcX8Udo', // Replace with your Google Maps API key
//         PointLatLng(_origin!.latitude, _origin!.longitude),
//         PointLatLng(_destination!.latitude, _destination!.longitude),
//       );

//       if (result.points.isNotEmpty) {
//         List<LatLng> routePoints = result.points
//             .map((point) => LatLng(point.latitude, point.longitude))
//             .toList();

//         setState(() {
//           _polylines.clear();
//           _polylines.add(Polyline(
//             polylineId: PolylineId('route'),
//             color: Colors.blue,
//             width: 5,
//             points: routePoints,
//           ));
//         });

//         _moveCamera();
//       } else {
//         // Handle case where no route is found
//         print("No route found");
//       }
//     } else {
//       // Handle case where either origin or destination is not set
//       print("Please set both origin and destination");
//     }
//   }

//   void _moveCamera() {
//     if (_controller != null && _origin != null && _destination != null) {
//       LatLngBounds bounds = LatLngBounds(
//         southwest: LatLng(
//           _origin!.latitude < _destination!.latitude
//               ? _origin!.latitude
//               : _destination!.latitude,
//           _origin!.longitude < _destination!.longitude
//               ? _origin!.longitude
//               : _destination!.longitude,
//         ),
//         northeast: LatLng(
//           _origin!.latitude > _destination!.latitude
//               ? _origin!.latitude
//               : _destination!.latitude,
//           _origin!.longitude > _destination!.longitude
//               ? _origin!.longitude
//               : _destination!.longitude,
//         ),
//       );

//       if (bounds.isValid()) {
//         _controller!.animateCamera(
//           CameraUpdate.newLatLngBounds(
//             bounds,
//             50.0, // Padding
//           ),
//         );
//       }
//     }
//   }
// }

// extension LatLngBoundsExtension on LatLngBounds {
//   bool isValid() {
//     return southwest.latitude <= northeast.latitude &&
//         southwest.longitude <= northeast.longitude;
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/screens/rides_diso.dart';
import 'package:swift_user1/utils/dummy_data.dart';

void main() {
  runApp(
    MaterialApp(
      home: CourseScreen(),
    ),
  );
}

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  GoogleMapController? _controller;
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  LatLng? _origin;
  LatLng? _destination;
  Set<Polyline> _polylines = {};
  bool _useMapIntegration = false;

  @override
  void initState() {
    super.initState();
    _originController.addListener(() => _searchLocation(true));
    _destinationController.addListener(() => _searchLocation(false));
  }

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Define Course"),
        backgroundColor: AppColor.appThemeColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _originController,
              decoration: InputDecoration(
                labelText: 'Origin',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Destination',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _confirmDestination(); // Call the function to navigate to RidesDsipo screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6B4CE5),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Show Route'),
                  ),
                ),
                SizedBox(width: 16),
                DropdownButton<bool>(
                  value: _useMapIntegration,
                  onChanged: (value) {
                    setState(() {
                      _useMapIntegration = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: false,
                      child: Text('Manual Input'),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text('Map Integration'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _useMapIntegration
                  ? GoogleMap(
                      onMapCreated: (controller) {
                        setState(() {
                          _controller = controller;
                        });
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(36.7528, 3.0420),
                        zoom: 12.0,
                      ),
                      markers: Set.of([
                        if (_origin != null)
                          Marker(
                            markerId: MarkerId("origin"),
                            position: _origin!,
                          ),
                        if (_destination != null)
                          Marker(
                            markerId: MarkerId("destination"),
                            position: _destination!,
                          ),
                      ]),
                      polylines: _polylines,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: Add any additional functionality for the FAB
        },
        backgroundColor: Color(0xFF6B4CE5),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void _searchLocation(bool isOrigin) async {
    TextEditingController controller =
        isOrigin ? _originController : _destinationController;
    String searchText = controller.text;

    if (searchText.isNotEmpty) {
      List<Location> locations = await locationFromAddress(searchText);

      if (locations.isNotEmpty) {
        LatLng locationLatLng =
            LatLng(locations[0].latitude, locations[0].longitude);

        setState(() {
          if (isOrigin) {
            _origin = locationLatLng;
          } else {
            _destination = locationLatLng;
          }
        });

        _moveCamera();
      } else {
        // Handle case where no location is found
        print("Location not found");
      }
    }
  }

  void _showRoute() async {
    if (_origin != null && _destination != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyCEQQzxlXsvmykXtDyabgfThOplHcX8Udo', // Replace with your Google Maps API key
        PointLatLng(_origin!.latitude, _origin!.longitude),
        PointLatLng(_destination!.latitude, _destination!.longitude),
      );

      if (result.points.isNotEmpty) {
        List<LatLng> routePoints = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            color: Color(0xFF6B4CE5),
            width: 5,
            points: routePoints,
          ));
        });

        _moveCamera();
      } else {
        // Handle case where no route is found
        print("No route found");
      }
    } else {
      // Handle case where either origin or destination is not set
      print("Please set both origin and destination");
    }
  }

  void _moveCamera() {
    if (_controller != null && _origin != null && _destination != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          _origin!.latitude < _destination!.latitude
              ? _origin!.latitude
              : _destination!.latitude,
          _origin!.longitude < _destination!.longitude
              ? _origin!.longitude
              : _destination!.longitude,
        ),
        northeast: LatLng(
          _origin!.latitude > _destination!.latitude
              ? _origin!.latitude
              : _destination!.latitude,
          _origin!.longitude > _destination!.longitude
              ? _origin!.longitude
              : _destination!.longitude,
        ),
      );

      if (bounds.isValid()) {
        _controller!.animateCamera(
          CameraUpdate.newLatLngBounds(
            bounds,
            50.0, // Padding
          ),
        );
      }
    }
  }

  void _confirmDestination() {
    if (_destination != null) {
      // Navigate to DriverAvailabilityScreen with available driver information
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RidesDsipo(availableDrivers: availableDrivers)),
        //TODO: Fetch or generate available driver information (replace with your data source)
      );
    } else {
      // Handle case where destination is not set
      print("Please set the destination first.");
    }
  }
}

extension LatLngBoundsExtension on LatLngBounds {
  bool isValid() {
    return southwest.latitude <= northeast.latitude &&
        southwest.longitude <= northeast.longitude;
  }
}
