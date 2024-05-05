import 'package:flutter/material.dart';
import 'package:swift_user1/models/driver.dart';
import 'package:swift_user1/screens/booking.dart'; // Import the booking screen

class RidesDsipo extends StatelessWidget {
  final List<DriverInfo> avaiDrivers;

  RidesDsipo({required this.avaiDrivers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rides Availability'),
        backgroundColor: Color(0xFF6B4CE5),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: avaiDrivers.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(avaiDrivers[index].driverName),
              subtitle: Text(avaiDrivers[index].vehicleDetails),
              trailing: Text('ETA: ${avaiDrivers[index].eta} mins'),
              onTap: () {
                // Handle driver selection and navigate to booking screen
                _navigateToBookingScreen(context, avaiDrivers[index]);
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
