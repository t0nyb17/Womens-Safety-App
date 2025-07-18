import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../models/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;

  const ContactCard({
    Key? key,
    required this.contact,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contact.id ?? contact.number),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
      },
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
              contact.name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            contact.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(contact.number),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.phone, color: AppColors.buttonColor),
                onPressed: () async {
                  await launchUrl(
                    Uri.parse('tel:${contact.number}'),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.message, color: AppColors.buttonColor),
                onPressed: () async {
                  final smsUri = Uri(
                    scheme: 'sms',
                    path: contact.number,
                    queryParameters: {
                      'body': AppConstants.safetyMessage
                    },
                  );
                  await launchUrl(smsUri);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}