# Women's Safety App 🗱️

A modern, comprehensive **Flutter application** designed to enhance women's safety by providing instant access to emergency features and vital resources.

---

## 👨‍💻 Developer

**Tanmay Bangar**\
GitHub: [tanmaybangar](https://github.com/tanmaybangar)

---

## 📱 Screenshots

<img width="1920" height="1080" alt="Screenshot (1671)" src="https://github.com/user-attachments/assets/37cb3b2d-5612-4505-bc6f-7989083010bd" />
<img width="1920" height="1080" alt="Screenshot (1670)" src="https://github.com/user-attachments/assets/9836a5fd-4577-47aa-b6fa-577ae19619d8" />
<img width="1920" height="1080" alt="Screenshot (1672)" src="https://github.com/user-attachments/assets/11ff6dc9-47b8-4c4d-8357-54cac1f33f32" />
<img width="1920" height="1080" alt="Screenshot (1681)" src="https://github.com/user-attachments/assets/4021fadf-d5c4-4828-a966-82049837f288" />
<img width="1920" height="1080" alt="Screenshot (1680)" src="https://github.com/user-attachments/assets/5d1ef645-d5c8-42b3-901a-f217fea80fb9" />
<img width="1920" height="1080" alt="Screenshot (1679)" src="https://github.com/user-attachments/assets/ea9620f9-d2df-497b-982c-fefe5cb50afd" />
<img width="1920" height="1080" alt="Screenshot (1678)" src="https://github.com/user-attachments/assets/f9244a31-cda9-4651-b460-e95edbf4b330" />
<img width="1920" height="1080" alt="Screenshot (1676)" src="https://github.com/user-attachments/assets/695b9817-1173-4f31-9174-c32d8b80f11c" />
<img width="1920" height="1080" alt="Screenshot (1674)" src="https://github.com/user-attachments/assets/ebbfc54c-425f-456f-9239-6831898a9ca6" />
<img width="1920" height="1080" alt="Screenshot (1673)" src="https://github.com/user-attachments/assets/a3fb1c7f-e44c-42f7-9b52-daf6ba577cf8" />
<img width="1920" height="1080" alt="Screenshot (1684)" src="https://github.com/user-attachments/assets/aa22d7f9-d4b2-4a95-a289-a8ee59ba272d" />
<img width="1920" height="1080" alt="Screenshot (1683)" src="https://github.com/user-attachments/assets/ac60a218-5529-4ae4-a55c-6e28e2729e59" />
<img width="1920" height="1080" alt="Screenshot (1682)" src="https://github.com/user-attachments/assets/1aed2362-dbb0-411c-b915-7354a384a50c" />

---

## ✨ Features

### 🛘 SOS Alert System

- One-tap emergency alert with haptic feedback
- Sends immediate SMS to your trusted contact (e.g., `9321245XXX`)
- Animated SOS button with pulsating effects
- Loading indicators & success feedback notifications

### 📍 Location Sharing

- Real-time GPS tracking
- Multiple sharing options: WhatsApp, SMS (with Google Maps link), Email
- Error handling for denied permissions

### 👥 Emergency Contacts

- Preloaded contacts (Mother, Father, Brother)
- Add/Delete contacts via popup dialogs
- Quick call/message actions
- Animated, responsive contact cards

### 📞 Emergency Hotlines

- Quick dial numbers:\
  `100` (Police), `108` (Ambulance), `1091` (Women Helpline), `1098` (Child Helpline)
- One-tap direct dial support

### 💡 Safety Tips

- 8 essential safety tips, each explained in detail with card-based design

### 📝 Report & Feedback

- Bug, Feature Request, Feedback options
- Validated feedback forms with submission confirmation

### ℹ️ More Options

- App Info, Feature Overview, Legal (Privacy Policy & Terms), Exit App functionality

---

## 🎨 UI/UX Highlights

- Material Design with custom **pink theme** (#FFC0CB)
- Responsive layouts, smooth animations, splash screen effects
- Accessible color schemes with high contrast and clear icons
- Bottom navigation with: Home, Report, Contacts, More

---

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: setState
- **Architecture**: Clean Architecture + Repository Pattern
- **Platforms**: Android, iOS, Web

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  url_launcher: ^6.1.14
  geolocator: ^10.1.0
  permission_handler: ^11.0.1
  cupertino_icons: ^1.0.2
```

---

## 🚀 Installation

```bash
git clone https://github.com/tanmaybangar/womens-safety-app.git
cd womens-safety-app
flutter pub get
flutter run
```

---

## 📁 Project Structure

```
womens_safety_app/
├── lib/
│   ├── main.dart
│   ├── data/
│   ├── models/
│   ├── screens/
│   ├── services/
│   ├── utils/
│   └── widgets/
├── android/
├── ios/
└── pubspec.yaml
```

---

## ⚙️ Configuration

### Android (`AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.CALL_PHONE" />
```

### iOS (`Info.plist`)

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app requires location access for emergency situations.</string>
```

---

## 🔒 Privacy & Security

- Location data is accessed only when user-triggered
- No external server storage or user tracking
- All data is locally stored and permission-controlled

---

## 🌟 Core Functionalities

- **Emergency Alerts** with haptics & SMS notifications
- **Location Sharing** via multiple platforms
- **Emergency Contact Management**
- **Preloaded Safety Tips**
- **Quick Dial Hotlines**

---

## 🤝 Contributing

Contributions are welcome!\
**Steps:**

1. Fork the repo
2. Create your branch: `git checkout -b feature/AmazingFeature`
3. Commit: `git commit -m "Add AmazingFeature"`
4. Push: `git push origin feature/AmazingFeature`
5. Open a pull request

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgements

- Flutter team
- Open-source contributors
- Material Design resources

---

## 🌟 Future Roadmap

- Voice-activated SOS
- Live location sharing
- Fake call feature
- Audio/Video recording
- Multi-language support
- Dark mode
- Shake-to-alert feature
- Safe route suggestions
- Community reporting system

---

## 🌟 Show Your Support

If you like this project, consider giving it a ⭐️!

---

Made with ❤️ by **Tanmay Bangar**\
**Stay Safe. Stay Empowered.** 💪

