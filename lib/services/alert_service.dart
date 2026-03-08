import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/contacts_manager.dart';
import '../data/emergency_numbers_data.dart';

class AlertService {
  final Telephony _telephony = Telephony.instance;

  /// Full SOS: vibrate → get location → SMS all contacts →
  /// WhatsApp first contact → direct call first contact.
  Future<void> sendSOSAlert(BuildContext context) async {
    HapticFeedback.heavyImpact();

    // Loading dialog
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
            Expanded(
              child: Text(
                'Sending SOS alert…',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );

    // ── 1. Get GPS location ──────────────────────────────────────
    Position? position;
    try {
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm != LocationPermission.deniedForever) {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        ).timeout(const Duration(seconds: 6));
      }
    } catch (_) {}

    final String locationSnippet = position != null
        ? '\n📍 My location: https://maps.google.com/?q=${position.latitude},${position.longitude}'
        : '';

    final String sosMessage =
        'EMERGENCY SOS! I need immediate help!$locationSnippet\n– Sent via Women\'s Safety App';

    final contacts = ContactsManager.instance.contacts;

    // ── 2. Send SMS to EVERY emergency contact ───────────────────
    bool smsPermission = false;
    try {
      smsPermission =
          (await _telephony.requestPhoneAndSmsPermissions) == true;
    } catch (_) {}

    for (final contact in contacts) {
      try {
        if (smsPermission) {
          _telephony.sendSms(
            to: contact.number,
            message: sosMessage,
            statusListener: (SendStatus status) {},
            isMultipart: true,
          );
        } else {
          // Fallback: open SMS app for first contact only
          final smsUri = Uri(
            scheme: 'sms',
            path: contact.number,
            queryParameters: {'body': sosMessage},
          );
          await launchUrl(smsUri);
          break; // url_launcher opens one at a time
        }
      } catch (_) {}
    }

    // ── 3. Send WhatsApp to first contact ────────────────────────
    if (contacts.isNotEmpty) {
      try {
        final number =
            contacts.first.number.replaceAll(RegExp(r'[^0-9]'), '');
        final waUrl =
            'https://wa.me/$number?text=${Uri.encodeComponent(sosMessage)}';
        await launchUrl(Uri.parse(waUrl),
            mode: LaunchMode.externalApplication);
      } catch (_) {}
    }

    // ── 4. Direct call to first contact ─────────────────────────
    if (contacts.isNotEmpty) {
      try {
        await FlutterPhoneDirectCaller.callNumber(contacts.first.number);
      } catch (_) {
        try {
          await launchUrl(
              Uri.parse('tel:${contacts.first.number}'));
        } catch (_) {}
      }
    }

    // Dismiss loading dialog
    if (context.mounted) Navigator.pop(context);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'SOS sent to ${contacts.length} contact(s)${position != null ? " with location" : ""}!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void showHotlineOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Emergency Hotlines',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap to call immediately',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.darkText.withOpacity(0.55)),
            ),
            const SizedBox(height: 16),
            ...emergencyHotlines.map((h) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        await FlutterPhoneDirectCaller
                            .callNumber(h.number);
                      } catch (_) {
                        await launchUrl(
                            Uri.parse('tel:${h.number}'));
                      }
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: h.color.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: h.color.withOpacity(0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: h.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child:
                                Icon(h.icon, color: h.color, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(h.name,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkText)),
                                Text(h.number,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.darkText
                                            .withOpacity(0.55))),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: h.color,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Icon(Icons.call_rounded,
                                color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
