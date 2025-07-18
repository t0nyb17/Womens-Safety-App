Women's Safety App 🛡️
A comprehensive Flutter application designed to enhance women's safety through quick access to emergency features and safety resources.
👨‍💻 Developer
Tanmay Bangar
GitHub: https://github.com/tanmaybangar
📱 Screenshots

✨ Features
🚨 SOS Alert System
<img <img width="1920" height="1080" alt="Screenshot (1671)" src="https://github.com/user-attachments/assets/37463d51-ffc5-4b71-bf17-ec7ffa136272" />
<img width="1920" height="1080" alt="Screenshot (1670)" src="https://github.com/user-attachments/assets/65087a41-70d9-46c5-85cf-b6d07e4a0839" />
w<img wid<img width="1920" height="1080" alt="Screenshot (1684)" src="https://github.com/user-attachments/assets/1d5c6d25-b6cf-41bd-8a64-9c29c9a87046" />
<img width="1920" height="1080" alt="Screenshot (1683)" src="https://github.com/user-attachments/assets/0e16ff8a-8816-4e92-a56e-32ad7c1baa5a" />
<img width="1920" height="1080" alt="Screenshot (1682)" src="https://github.com/user-attachments/assets/6c4089f6-b147-4726-b164-5954059d015e" />
<img width="1920" height="1080" alt="Screenshot (1681)" src="https://github.com/user-attachments/assets/a987f3d2-c3e9-43b5-a24f-4278b3aa4b51" />
<img width="1920" height="1080" alt="Screenshot (1680)" src="https://github.com/user-attachments/assets/fa3e47ba-c842-48e1-b8c6-11ba0768072e" />
<img width="1920" height="1080" alt="Screenshot (1679)" src="https://github.com/user-attachments/assets/a1d9c3e4-d732-4a03-91e1-85f99df9ee60" />
<img width="1920" height="1080" alt="Screenshot (1678)" src="https://github.com/user-attachments/assets/4a9b4edb-ea1d-4c6a-ae8b-578454297b85" />
<img width="1920" height="1080" alt="Screenshot (1676)" src="https://github.com/user-attachments/assets/2cb93202-8856-4b44-89ba-9184d155af6c" />
<img width="1920" height="1080" alt="Screenshot (1674)" src="https://github.com/user-attachments/assets/a08491c3-bc58-40a2-a1d4-da441626ef01" />
<img width="1920" height="1080" alt="Screenshot (1673)" src="https://github.com/user-attachments/assets/66b2afaa-6ffd-42b0-91e2-290acad7df11" />
<img width="1920" height="1080" alt="Screenshot (1672)" src="https://github.com/user-attachments/assets/df7697ed-9171-43a7-95fe-718ca4896fed" />

One-tap emergency alert button with haptic feedback
Sends immediate SMS alert to pre-configured emergency contact (9321245XXX)
Animated SOS button with pulsating effect for easy visibility
Loading indicators and success feedback
Green success notification bar confirms alert sent

📍 Location Sharing

Real-time GPS location tracking with permission handling
Multiple sharing options:

WhatsApp integration for instant location sharing
SMS with Google Maps link
Email with location coordinates


Browser-based location permission prompt
Automatic error handling for denied permissions

👥 Emergency Contacts

Pre-configured emergency contact list (Mother, Father, Brother)
Add new contacts with popup dialog
Delete contacts functionality
Quick call and message buttons for each contact
Animated contact cards with smooth transitions
Success notifications for contact operations

📞 Emergency Hotlines

Quick access to emergency services:

Police: 100
Ambulance: 108
Women Helpline: 1091
Child Helpline: 1098


Direct dial functionality from the app

💡 Safety Tips

Comprehensive safety guidelines with 8 essential tips:

Trust Your Instincts
Share Your Location
Stay Alert
Learn Self-Defense
Emergency Contacts
Safe Transportation
Avoid Isolated Areas
Carry Safety Tools


Beautiful card-based layout with shield icons
Detailed descriptions for each safety tip

📝 Report & Feedback

Dropdown menu for report types:

Bug
Feature Request
Feedback
Other


Text area for detailed descriptions
Form validation
Submit button with pink theme

ℹ️ More Options

App Info Section:

Version: 1.0.0
Developer: Tanmay Bangar


Features Overview:

SOS Alert description
Live Location Sharing
Emergency Contacts
Safety Tips


Connect Section:

GitHub link to source code


Legal Section:

Privacy Policy
Terms of Service


Exit App button with confirmation dialog

🎨 UI/UX Features

Material Design with custom pink theme (#FFC0CB background)
Responsive Layout adapts to different screen sizes
Smooth Animations:

Splash screen fade-in effect
SOS button pulsating animation
Card entry animations
Page transitions


Bottom Navigation Bar with 4 sections:

Home
Report
Contacts
More


Color Scheme:

Primary Pink: #FFC0CB
Button Color: #B83C5E
Dark Text: #6D2940
Success Green for notifications


Accessibility Features:

Clear typography
Large touch targets
High contrast elements
Intuitive icons



🛠️ Technical Stack

Framework: Flutter
Language: Dart
State Management: setState (StatefulWidget)
Architecture: Clean Architecture with separation of concerns
Design Pattern: Repository pattern for services
Platform: Web (Chrome), Android, iOS

📦 Dependencies
yamldependencies:
  flutter:
    sdk: flutter
  url_launcher: ^6.1.14
  geolocator: ^10.1.0
  permission_handler: ^11.0.1
  cupertino_icons: ^1.0.2
🚀 Installation

Clone the repository
bashgit clone https://github.com/tanmaybangar/womens-safety-app.git
cd womens-safety-app

Install dependencies
bashflutter pub get

Run the app
bashflutter run


📂 Project Structure
womens_safety_app/
├── lib/
│   ├── main.dart
│   ├── data/
│   │   ├── emergency_numbers_data.dart
│   │   └── safety_tips_data.dart
│   ├── models/
│   │   ├── contact.dart
│   │   ├── emergency_number.dart
│   │   └── safety_tip.dart
│   ├── screens/
│   │   ├── contacts_screen.dart
│   │   ├── home_screen.dart
│   │   ├── main_screen.dart
│   │   ├── message_contacts_screen.dart
│   │   ├── more_screen.dart
│   │   ├── report_screen.dart
│   │   ├── safety_tips_screen.dart
│   │   └── splash_screen.dart
│   ├── services/
│   │   ├── alert_service.dart
│   │   └── location_service.dart
│   ├── utils/
│   │   ├── colors.dart
│   │   └── constants.dart
│   └── widgets/
│       ├── action_button.dart
│       ├── contact_card.dart
│       ├── safety_tip_card.dart
│       └── sos_button.dart
├── android/
├── ios/
├── screenshots/
└── pubspec.yaml
⚙️ Configuration
Android Permissions (AndroidManifest.xml)
xml<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.VIBRATE" />
iOS Permissions (Info.plist)
xml<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to share your location in emergencies</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs location access to share your location in emergencies</string>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>sms</string>
    <string>tel</string>
    <string>mailto</string>
    <string>whatsapp</string>
</array>
🔒 Privacy & Security

Location data is only accessed when explicitly shared by the user
No data storage on external servers
All emergency contacts are stored locally on device
No user tracking or analytics
Permission-based access for all sensitive features

🌟 Key Functionalities
Emergency Response Flow

User taps SOS button
App vibrates for haptic feedback
SMS alert sent to emergency contact
Success notification displayed
User can share location via multiple channels

Contact Management

Add contacts through dialog popup
View all contacts in a scrollable list
Quick actions: Call or Message
Swipe to delete (if implemented)
Real-time updates to contact list

Safety Features

Immediate SOS alerts without navigation
One-click location sharing
Pre-loaded emergency numbers
Offline safety tips always accessible
Quick exit option for emergencies

🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

Fork the Project
Create your Feature Branch (git checkout -b feature/AmazingFeature)
Commit your Changes (git commit -m 'Add some AmazingFeature')
Push to the Branch (git push origin feature/AmazingFeature)
Open a Pull Request

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
🙏 Acknowledgments

Flutter team for the amazing framework
All contributors who help improve women's safety
The open-source community for various packages used
Icons and design inspiration from Material Design

📞 Support
For support, email tanmaybangar@gmail.com or raise an issue on GitHub.
🎯 Future Enhancements

 Voice-activated SOS
 Live location tracking
 Fake call feature
 Audio/Video recording
 Multi-language support
 Dark mode
 Shake to alert
 Safe route suggestions
 Community reporting
 Emergency contact sync

🌟 Show your support
Give a ⭐️ if this project helped you!

Made with ❤️ by Tanmay Bangar
Stay Safe, Stay Empowered 💪
