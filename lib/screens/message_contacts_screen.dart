import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../models/contact.dart';

class MessageContactsScreen extends StatelessWidget {
  final List<Contact> emergencyContacts = [
    Contact(name: 'Mother', number: '1234567890'),
    Contact(name: 'Father', number: '2345678901'),
    Contact(name: 'Brother', number: '3456789012'),
    Contact(name: 'Emergency Contact', number: AppConstants.emergencyNumber),
  ];

  const MessageContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: AppBar(
        title: const Text('Message Contacts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 300 + (index * 100)),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.buttonColor,
                        child: Text(
                          emergencyContacts[index].name[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        emergencyContacts[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(emergencyContacts[index].number),
                      trailing: IconButton(
                        icon: const Icon(Icons.message, color: AppColors.buttonColor),
                        onPressed: () async {
                          final smsUri = Uri(
                            scheme: 'sms',
                            path: emergencyContacts[index].number,
                            queryParameters: {
                              'body': AppConstants.safetyMessage
                            },
                          );
                          await launchUrl(smsUri);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}