import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../data/emergency_numbers_data.dart';

class AlertService {
  Future<void> sendSOSAlert(BuildContext context) async {
    // Vibrate
    HapticFeedback.heavyImpact();
    
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Sending SOS Alert...'),
          ],
        ),
      ),
    );

    // Send SMS
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: AppConstants.emergencyNumber,
      queryParameters: {'body': AppConstants.sosMessage},
    );
    
    try {
      await launchUrl(smsUri);
      Navigator.pop(context);
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOS Alert sent successfully!'),
          backgroundColor: AppColors.successGreen,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send SOS alert'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  void showHotlineOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Emergency Hotlines',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...emergencyHotlines.map((hotline) => ListTile(
              leading: Icon(hotline.icon, color: hotline.color),
              title: Text(hotline.name),
              subtitle: Text(hotline.number),
              onTap: () async {
                Navigator.pop(context);
                await launchUrl(Uri.parse('tel:${hotline.number}'));
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
}