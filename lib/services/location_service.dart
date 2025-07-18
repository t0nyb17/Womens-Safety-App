import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class LocationService {
  Future<void> shareLocation(BuildContext context) async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Getting location...'),
          ],
        ),
      ),
    );

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      Navigator.pop(context);
      
      // Create location message
      String locationMessage = '${AppConstants.locationMessage}https://maps.google.com/?q=${position.latitude},${position.longitude}';
      
      // Show options dialog
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Location Via',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.message, color: Colors.green),
                title: const Text('WhatsApp'),
                onTap: () async {
                  Navigator.pop(context);
                  final whatsappUrl = 'https://wa.me/91${AppConstants.emergencyNumber}?text=${Uri.encodeComponent(locationMessage)}';
                  await launchUrl(Uri.parse(whatsappUrl));
                },
              ),
              ListTile(
                leading: const Icon(Icons.sms, color: Colors.blue),
                title: const Text('SMS'),
                onTap: () async {
                  Navigator.pop(context);
                  final smsUri = Uri(
                    scheme: 'sms',
                    path: AppConstants.emergencyNumber,
                    queryParameters: {'body': locationMessage},
                  );
                  await launchUrl(smsUri);
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.red),
                title: const Text('Email'),
                onTap: () async {
                  Navigator.pop(context);
                  final emailUri = Uri(
                    scheme: 'mailto',
                    queryParameters: {
                      'subject': 'EMERGENCY - Location Alert',
                      'body': locationMessage,
                    },
                  );
                  await launchUrl(emailUri);
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get location')),
      );
    }
  }
}