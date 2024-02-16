// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: ScanQRScreen()));

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  int _currentIndex = 0; // Index for the selected tab

  final List<Widget> _tabs = [
    ScanTab(),
    NotificationsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Toilet'),
        backgroundColor: Colors.green,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
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
  const ScanTab({Key? key}) : super(key: key);

  @override
  _ScanTabState createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  String scannedCode = '';
  String gpsLocation = '';
  String toiletLocation = ''; // Variable to hold the extracted toilet location

  Future<void> _scanQR() async {
    try {
      final result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        setState(() {
          scannedCode = result.rawContent;

          toiletLocation = result
              .rawContent; // Variable to hold the extracted toilet location
        });
        await _getGPSLocation(); // Fetch the GPS location after scanning
      }
    } catch (e) {
      print('Error scanning QR code: $e');
    }
  }

  Future<void> _getGPSLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        gpsLocation =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
      // Consider saving the toilet status or showing the confirmation dialog here if needed
    } catch (e) {
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content:
              Text("Toilet Name: $scannedCode\nGPS Location: $gpsLocation"),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width * 0.4; // 40% of screen width
    double cardHeight =
        MediaQuery.of(context).size.height * 0.2; // 20% of screen height

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.green, width: 2.0),
                ),
                child: InkWell(
                  onTap: _scanQR,
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner,
                            size: 60.0, color: Colors.green),
                        SizedBox(
                            height:
                                8), // Add some space between the icon and text
                        Text('Scan QR Code', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (scannedCode.isNotEmpty)
                Text('Toilet Name: $scannedCode',
                    style: TextStyle(fontSize: 16)),
              if (toiletLocation.isNotEmpty)
                //Text('GPS Location: $gpsLocation',
                // style: TextStyle(fontSize: 16)),
                Text('Location: $toiletLocation',
                    style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: scannedCode.isNotEmpty && toiletLocation.isNotEmpty
                    ? _showConfirmationDialog
                    : null, // Button is enabled only if both QR code is scanned and location is fetched
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('Confirm Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notifications.',
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
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile .',
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
