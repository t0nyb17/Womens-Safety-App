import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'fake_call_screen.dart';
import 'safe_walk_screen.dart';
import 'report_screen.dart';
import 'terms_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildProfileHeader(),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSection(
                    title: 'App Features',
                    children: [
                      _buildFeatureRow(
                          icon: Icons.shield_rounded,
                          color: AppColors.sosRed,
                          title: 'SOS Alert',
                          subtitle: 'One-tap emergency alert'),
                      _buildFeatureRow(
                          icon: Icons.location_on_rounded,
                          color: const Color(0xFF1565C0),
                          title: 'Live Location',
                          subtitle: 'Share GPS via WhatsApp, SMS, Email'),
                      _buildFeatureRow(
                          icon: Icons.phone_in_talk_rounded,
                          color: const Color(0xFF2E7D32),
                          title: 'Fake Call',
                          subtitle: 'Simulate an incoming call'),
                      _buildFeatureRow(
                          icon: Icons.timer_rounded,
                          color: const Color(0xFFBF360C),
                          title: 'Safe Walk',
                          subtitle: 'Auto-SOS countdown timer'),
                      _buildFeatureRow(
                          icon: Icons.contacts_rounded,
                          color: const Color(0xFF4A148C),
                          title: 'Emergency Contacts',
                          subtitle: 'Quick access to trusted people',
                          isLast: true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: 'App Info',
                    children: [
                      _buildInfoRow(label: 'Version', value: AppConstants.appVersion),
                      _buildInfoRow(label: 'Developer', value: AppConstants.developerName, isLast: true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: 'Help & Support',
                    children: [
                      _buildTappableRow(
                        icon: Icons.bug_report_outlined,
                        title: 'Report an Issue',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const ReportScreen())),
                      ),
                      _buildTappableRow(
                        icon: Icons.phone_in_talk_rounded,
                        title: 'Fake Call',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const FakeCallScreen())),
                      ),
                      _buildTappableRow(
                        icon: Icons.timer_rounded,
                        title: 'Safe Walk Timer',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const SafeWalkScreen())),
                      ),
                      _buildTappableRow(
                        icon: Icons.code_rounded,
                        title: 'View Source on GitHub',
                        onTap: () => launchUrl(Uri.parse(AppConstants.githubUrl)),
                      ),
                      _buildTappableRow(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        onTap: () => _showInfoDialog(context, 'Privacy Policy',
                            'We collect location data only when you explicitly share it.\n\nYour emergency contacts are stored locally on your device.\n\nWe do not share your data with third parties.\n\nLast updated: 2025'),
                      ),
                      _buildTappableRow(
                        icon: Icons.gavel_rounded,
                        title: 'Terms & Conditions',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const TermsScreen())),
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () => _showExitDialog(context),
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: const Text('Exit App'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: BorderSide(color: AppColors.error.withOpacity(0.4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7A0A2E),
            Color(0xFFC90F47),
            Color(0xFFE03060),
          ],
          stops: [0.0, 0.6, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Safely',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Women's Safety App",
                    style: TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildFeatureRow({required IconData icon, required Color color, required String title, required String subtitle, bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ])),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, indent: 68, endIndent: 16, color: Colors.grey.shade100),
      ],
    );
  }

  Widget _buildInfoRow({required String label, required String value, bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
      ],
    );
  }

  Widget _buildTappableRow({required IconData icon, required String title, required VoidCallback onTap, bool isLast = false}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: isLast ? const BorderRadius.vertical(bottom: Radius.circular(18)) : BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(width: 14),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary))),
                Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textHint),
              ],
            ),
          ),
        ),
        if (!isLast) Divider(height: 1, indent: 50, color: Colors.grey.shade100),
      ],
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        content: SingleChildScrollView(child: Text(content, style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5))),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Exit App?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to exit Safely?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary))),
          ElevatedButton(onPressed: SystemNavigator.pop, style: ElevatedButton.styleFrom(backgroundColor: AppColors.error), child: const Text('Exit', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
