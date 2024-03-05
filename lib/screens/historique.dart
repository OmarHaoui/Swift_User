import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_user1/screens/booking.dart';
import 'package:swift_user1/screens/rides_diso.dart';

class Ride {
  final String name;
  final bool isCompleted;

  Ride({required this.name, required this.isCompleted});
}

class HistoriqueScreen extends StatelessWidget {
  final List<Ride> completedRides = [
    Ride(name: 'Ride 1', isCompleted: true),
    Ride(name: 'Ride 2', isCompleted: true),
    // Add more completed rides
  ];

  final List<Ride> upcomingRides = [
    Ride(name: 'Ride 3', isCompleted: false),
    Ride(name: 'Ride 4', isCompleted: false),
    // Add more upcoming rides
  ];

  // Define routePoints as a list of LatLng
  final List<LatLng> rideRoutePoints = [
    LatLng(
        37.7749, -122.4194), // Example route points, replace with actual values
    LatLng(37.7749, -122.4294),
    // Add more route points as needed
  ];

  HistoriqueScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historique'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Previous Trips'),
              Tab(text: 'Upcoming Trips'),
            ],
            indicatorColor: Color(0xFF6B4CE5),
            labelColor: Color(0xFF6B4CE5),
            unselectedLabelColor: Colors.black54,
          ),
        ),
        body: TabBarView(
          children: [
            _buildRideList('Completed Rides', completedRides),
            _buildRideList('Upcoming Rides', upcomingRides),
          ],
        ),
      ),
    );
  }

  Widget _buildRideList(String title, List<Ride> rides) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4CE5)),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            itemCount: rides.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(rides[index].name),
                  subtitle: Text(
                    rides[index].isCompleted ? 'Completed' : 'Upcoming',
                    style: TextStyle(color: Color(0xFF6B4CE5)),
                  ),
                  onTap: () {
                    // Handle the tap on the ride (optional)
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Method to handle the addition of completed rides
  void addCompletedRide(DriverInfo driverInfo) {
    completedRides.add(Ride(name: driverInfo.driverName, isCompleted: true));
  }

  void _navigateToBookingScreen(
      BuildContext context, DriverInfo selectedDriver) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(
          driverInfo: selectedDriver,
          routePoints: rideRoutePoints,
          onRideConfirmed: addCompletedRide,
        ),
      ),
    );
  }
}
