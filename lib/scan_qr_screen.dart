import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  int _currentIndex = 0; // Index for the selected tab

  // Define your tabs/screens here
  final List<Widget> _tabs = [
    const ScanTab(),
    const NotificationsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Toilet'),
        backgroundColor: Colors.green,
      ),
      body: _tabs[_currentIndex], // Show the selected tab content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ScanTab extends StatefulWidget {
  const ScanTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScanTabState createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  String scannedCode = '';
  String gpsLocation = '';

  bool? get kDebugMode => null;

  Future<void> _scanQR() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        scannedCode = result.rawContent;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error scanning QR code: $e');
    }
  }

  Future<void> _getGPSLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        gpsLocation =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });

      // Save toilet status to the database
      await saveToiletStatus(scannedCode, 'emptied', DateTime.now(),
          position.latitude, position.longitude);
    } catch (e) {
      // ignore: avoid_print
      print('Error getting GPS location: $e');
    }
  }

  Future<void> saveToiletStatus(String toiletId, String status,
      DateTime scanDateTime, double latitude, double longitude) async {
    const apiUrl = 'https://www.rdrf.co.za/save_toilet_status.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'toilet_id': toiletId,
          'status': status,
          'scan_date': scanDateTime.toLocal().toString().split(' ')[0],
          'scan_time': scanDateTime.toLocal().toString().split(' ')[1],
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
      );

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(
            'Toilet status saved successfully. Status code: ${response.statusCode}');
      } else {
        // ignore: avoid_print
        print('Failed to save toilet status');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error saving toilet status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Scan Toilet',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20), // Adjust spacing
          Text(
            scannedCode,
            style: const TextStyle(color: Colors.green, fontSize: 18),
          ),
          const SizedBox(height: 20), // Adjust spacing
          ElevatedButton(
            onPressed: _scanQR,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 16), // Adjust button size
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Scan QR Code'),
          ),
          const SizedBox(height: 20), // Adjust spacing
          const Text(
            'GPS Location',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20), // Adjust spacing
          Text(
            gpsLocation,
            style: const TextStyle(color: Colors.green, fontSize: 18),
          ),
          const SizedBox(height: 20), // Adjust spacing
          ElevatedButton(
            onPressed: _getGPSLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 16), // Adjust button size
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Confirm Job'),
          ),
        ],
      ),
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Add your notifications tab content here
    return const Center(
      child: Text(
        'Notifications',
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Add your profile tab content here
    return const Center(
      child: Text(
        'Profile',
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
