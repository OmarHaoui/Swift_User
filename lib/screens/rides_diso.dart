import 'package:flutter/material.dart';
import 'package:swift_user1/screens/booking.dart'; // Import the booking screen

class RidesDsipo extends StatelessWidget {
  final List<DriverInfo> availableDrivers;

  RidesDsipo({required this.availableDrivers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rides Availability'),
        backgroundColor: Color(0xFF6B4CE5),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: availableDrivers.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(availableDrivers[index].driverName),
              subtitle: Text(availableDrivers[index].vehicleDetails),
              trailing: Text('ETA: ${availableDrivers[index].eta} mins'),
              onTap: () {
                // Handle driver selection and navigate to booking screen
                _navigateToBookingScreen(context, availableDrivers[index]);
              },
            ),
          );
        },
      ),
    );
  }

  // Function to navigate to the booking screen
  void _navigateToBookingScreen(
      BuildContext context, DriverInfo selectedDriver) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(
          driverInfo: selectedDriver,
          routePoints: [],
          onRideConfirmed: (DriverInfo) {},
        ),
      ),
    );
  }
}

class DriverInfo {
  final String driverName;
  final String vehicleDetails;
  final int eta;

  DriverInfo({
    required this.driverName,
    required this.vehicleDetails,
    required this.eta,
  });
}
