import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class LocationService {
  Future<void> shareLocation(BuildContext context) async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.deniedForever) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Location permission permanently denied'),
              backgroundColor: AppColors.error),
        );
      }
      return;
    }

    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
          content: const Row(
            children: [
              CircularProgressIndicator(
                  color: AppColors.buttonColor, strokeWidth: 3),
              SizedBox(width: 20),
              Text('Getting your location…',
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (context.mounted) Navigator.pop(context);

      final msg =
          '${AppConstants.locationMessage}https://maps.google.com/?q=${position.latitude},${position.longitude}';
      if (context.mounted) _showShareSheet(context, msg);
    } catch (_) {
      if (context.mounted) Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not get location. Try again.'),
              backgroundColor: AppColors.error),
        );
      }
    }
  }

  void _showShareSheet(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Share Location Via',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText)),
            const SizedBox(height: 4),
            Text('Choose how to send your location',
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.darkText.withOpacity(0.5))),
            const SizedBox(height: 16),
            _ShareTile(
              icon: Icons.chat_rounded,
              label: 'WhatsApp',
              subtitle: 'Send via WhatsApp',
              color: const Color(0xFF25D366),
              onTap: () async {
                Navigator.pop(context);
                final url =
                    'https://wa.me/91${AppConstants.emergencyNumber}?text=${Uri.encodeComponent(message)}';
                await launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication);
              },
            ),
            const SizedBox(height: 10),
            _ShareTile(
              icon: Icons.sms_rounded,
              label: 'SMS',
              subtitle: 'Send as text message',
              color: const Color(0xFF1565C0),
              onTap: () async {
                Navigator.pop(context);
                await launchUrl(Uri(
                  scheme: 'sms',
                  path: AppConstants.emergencyNumber,
                  queryParameters: {'body': message},
                ));
              },
            ),
            const SizedBox(height: 10),
            _ShareTile(
              icon: Icons.email_rounded,
              label: 'Email',
              subtitle: 'Send via email',
              color: const Color(0xFFD32F2F),
              onTap: () async {
                Navigator.pop(context);
                await launchUrl(Uri(
                  scheme: 'mailto',
                  queryParameters: {
                    'subject': 'EMERGENCY – Location Alert',
                    'body': message,
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ShareTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(11)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkText)),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.darkText.withOpacity(0.5))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 13,
                color: AppColors.darkText.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}
