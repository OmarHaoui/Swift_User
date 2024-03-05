// Import necessary packages
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:swift_user1/screens/rides_diso.dart'; // Import the rides_dispo.dart file

class BookingScreen extends StatelessWidget {
  final DriverInfo driverInfo;
  final List<LatLng> routePoints; // Add the required parameter
  final Function(DriverInfo) onRideConfirmed; // Add the callback function
  BookingScreen({
    required this.driverInfo,
    required this.routePoints,
    required this.onRideConfirmed, // Add the callback function
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
        backgroundColor: Color(0xFF6B4CE5),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Driver: ${driverInfo.driverName}'),
            Text('Vehicle: ${driverInfo.vehicleDetails}'),
            Text('ETA: ${driverInfo.eta} mins'),
            // Display additional information, such as route map, fare details, etc.
            // Use the provided routePoints for displaying the route map
            // You can use the Google Maps Flutter plugin or any other map library for this purpose
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the callback function to inform about the confirmed ride
                onRideConfirmed(driverInfo);
                _confirmAndBookRide(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6B4CE5),
                foregroundColor: Colors.white,
              ),
              child: Text('Confirm and Book Ride'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to confirm and book the ride
  void _confirmAndBookRide(BuildContext context) {
    // Add your logic here to handle ride confirmation and booking
    // For example, show a confirmation dialog and navigate to the next screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ride Confirmed'),
          content: Text('Your ride has been confirmed. Enjoy your journey!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Add any additional actions after booking the ride
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
