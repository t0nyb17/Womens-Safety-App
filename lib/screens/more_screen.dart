import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'App Info',
            children: [
              _buildInfoTile(
                icon: Icons.info_outline,
                title: 'Version',
                subtitle: AppConstants.appVersion,
              ),
              _buildInfoTile(
                icon: Icons.developer_mode,
                title: 'Developer',
                subtitle: AppConstants.developerName,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: 'Features',
            children: [
              _buildFeatureTile(
                icon: Icons.emergency,
                title: 'SOS Alert',
                description: 'One-tap emergency alert system',
              ),
              _buildFeatureTile(
                icon: Icons.location_on,
                title: 'Live Location Sharing',
                description: 'Share your location instantly',
              ),
              _buildFeatureTile(
                icon: Icons.contacts,
                title: 'Emergency Contacts',
                description: 'Quick access to trusted contacts',
              ),
              _buildFeatureTile(
                icon: Icons.tips_and_updates,
                title: 'Safety Tips',
                description: 'Essential safety guidelines',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: 'Connect',
            children: [
              ListTile(
                leading: const Icon(Icons.code, color: AppColors.darkText),
                title: const Text('GitHub'),
                subtitle: const Text('View source code'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  await launchUrl(Uri.parse(AppConstants.githubUrl));
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: 'Legal',
            children: [
              ListTile(
                leading: const Icon(Icons.privacy_tip, color: AppColors.darkText),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showPrivacyPolicy(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.description, color: AppColors.darkText),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showTermsOfService(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => _showExitDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Exit App',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.darkText),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.buttonColor.withOpacity(0.1),
        child: Icon(icon, color: AppColors.buttonColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Women\'s Safety App Privacy Policy\n\n'
            '1. We collect location data only when you explicitly share your location.\n'
            '2. Your emergency contacts are stored locally on your device.\n'
            '3. We do not share your personal data with third parties.\n'
            '4. We do not steal your information or impersonate.\n'
            '5. You can exit the app by tapping the exit button.\n'
            '5. Created the app for Womens Safety under development.\n'
            'Last updated: 2025',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Text(
            'Terms of Service\n\n'
            '1. This app is provided for emergency safety purposes.\n'
            '2. Users must provide accurate emergency contact information.\n',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}