import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../utils/terms_service.dart';
import 'main_screen.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7A0A2E), Color(0xFFC90F47), Color(0xFFE03060)],
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('Safely',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Terms & Conditions',
                          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text('Please read and agree before continuing',
                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ),
            // Scrollable T&C content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _TcSection(
                      number: '1',
                      title: 'About Safely',
                      body:
                          'Safely is a free personal safety app built for women. It lets you send emergency alerts to people you trust, share your location, simulate a fake incoming call to get out of uncomfortable situations, and set a safety timer when walking alone. This app was built by an individual developer, not a company.',
                    ),
                    _TcSection(
                      number: '2',
                      title: 'Always Call Emergency Services First',
                      body:
                          'Safely is not a replacement for calling the police or an ambulance. If you are in immediate danger, call 112, 100, or your local emergency number first. This app is a backup tool to alert your personal contacts — it cannot dispatch help on its own.',
                    ),
                    _TcSection(
                      number: '3',
                      title: 'Your Data Stays on Your Device',
                      body:
                          'Safely does not have a server, a database, or any cloud storage. Everything you add — contacts, settings — is saved only on your phone. Your location is only ever read when you tap Share Location or SOS. Nothing is collected or sent anywhere in the background.',
                    ),
                    _TcSection(
                      number: '4',
                      title: 'Permissions We Need',
                      body:
                          'Safely asks for a few permissions to do its job. Location is needed to include your GPS coordinates in SOS messages. SMS access is needed to send alerts directly to your contacts. Phone access is needed to place a call without the dialer popping up. These are only used when you actively trigger a feature — never in the background.',
                    ),
                    _TcSection(
                      number: '5',
                      title: 'Things to Keep in Mind',
                      body:
                          'SOS alerts depend on your phone having signal and battery. If you have no network, messages may not go through. Make sure your emergency contacts are real, saved correctly, and know they might receive an alert from you someday. Do not use the SOS button as a prank — your contacts will genuinely worry.',
                    ),
                    _TcSection(
                      number: '6',
                      title: 'No Guarantees',
                      body:
                          'This app is built with care but it is not perfect. The developer cannot guarantee that every SOS message will be delivered — networks fail, phones die, and carriers have restrictions. Do not rely on this app as your only safety plan. Always have a backup.',
                    ),
                    _TcSection(
                      number: '7',
                      title: 'Other Apps',
                      body:
                          'When you use features like Share Location or Report an Issue, Safely opens other apps on your phone such as WhatsApp or your email app. What you do inside those apps is your own business and governed by their own rules.',
                    ),
                    _TcSection(
                      number: '8',
                      title: 'Updates',
                      body:
                          'If these terms change in a future update, you will be asked to read and agree again before using the app. Updates are pushed to fix bugs and improve the experience.',
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Version 2.0  ·  March 2026  ·  Made by Tanmay Bangar',
                      style: TextStyle(fontSize: 11, color: AppColors.textHint),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Buttons
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          await TermsService.accept();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => const MainScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: const Text('I Agree',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => SystemNavigator.pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Disagree, Exit App',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TcSection extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  const _TcSection({required this.number, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.primaryFaint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(number,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Text(body,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textSecondary, height: 1.55)),
          ),
        ],
      ),
    );
  }
}
