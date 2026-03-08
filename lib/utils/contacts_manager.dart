import '../models/contact.dart';

/// Singleton that keeps emergency contacts in memory so both
/// ContactsScreen and AlertService share the same list.
class ContactsManager {
  static final ContactsManager instance = ContactsManager._();
  ContactsManager._();

  final List<Contact> contacts = [
    Contact(name: 'Mom',     number: '99999999999', id: '1'),
    Contact(name: 'Dad',     number: '8888888888',  id: '2'),
    Contact(name: 'Brother', number: '111111111',   id: '3'),
  ];
}
