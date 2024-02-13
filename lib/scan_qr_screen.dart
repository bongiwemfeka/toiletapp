// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan QR Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScanQRScreen(),
    );
  }
}

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ScanTab(),
    const NotificationsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
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
  const ScanTab({super.key});

  @override
  State<ScanTab> createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  String scannedCode = '';
  String gpsLocation = '';

  Future<void> _scanQR() async {
    try {
      final ScanResult result = await BarcodeScanner.scan();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        scannedCode = result.rawContent;
        gpsLocation =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error scanning QR code: $e');
      }
    }
  }

  void _confirmJob() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Job Confirmation"),
          content: Text(
              "Toilet ID: $scannedCode has been confirmed.\nLocation: $gpsLocation"),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              child: InkWell(
                onTap: _scanQR,
                child: Container(
                  width:
                      MediaQuery.of(context).size.width * 0.6, // Adjust width
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0), // Adjust padding
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner,
                          size: 30.0, color: Colors.green),
                      SizedBox(height: 8),
                      Text('Scan QR Code',
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            if (scannedCode.isNotEmpty && gpsLocation.isNotEmpty) ...[
              Text(
                'Scanned Toilet ID: $scannedCode',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              Text(
                'GPS Location: $gpsLocation',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
            ],
            ElevatedButton(
              onPressed: scannedCode.isNotEmpty && gpsLocation.isNotEmpty
                  ? _confirmJob
                  : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: const Text('Confirm Job'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No new notifications.',
          style: TextStyle(fontSize: 18, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Profile information not set.',
          style: TextStyle(fontSize: 18, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
