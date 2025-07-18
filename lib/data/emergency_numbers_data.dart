import 'package:flutter/material.dart';
import '../models/emergency_number.dart';

final List<EmergencyNumber> emergencyHotlines = [
  EmergencyNumber(
    name: 'Police',
    number: '100',
    icon: Icons.local_police,
    color: Colors.blue,
  ),
  EmergencyNumber(
    name: 'Ambulance',
    number: '108',
    icon: Icons.local_hospital,
    color: Colors.red,
  ),
  EmergencyNumber(
    name: 'Women Helpline',
    number: '1091',
    icon: Icons.female,
    color: Colors.pink,
  ),
  EmergencyNumber(
    name: 'Child Helpline',
    number: '1098',
    icon: Icons.child_care,
    color: Colors.orange,
  ),
];