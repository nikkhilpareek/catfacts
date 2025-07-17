# 🐱 Catto Facts

A Flutter app that brings you random cat facts paired with adorable cat images. Perfect for cat lovers.

## 📱 Features

- **Random Cat Facts**: Fetches interesting cat facts from the MeowFacts API
- **Cat Images**: Displays random cat images from The Cat API

## 🚀 Screenshots

*Add screenshots of your app here*

## 🛠️ Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **HTTP Client**: http package

## 📡 APIs Used

1. **MeowFacts API**: `https://meowfacts.herokuapp.com/`
   - Provides random cat facts
   - Returns JSON with cat facts in a data array

2. **Cataas API**: `https://cataas.com/cat/says/Welcome`
   - Used for welcome screen image
   - Customizable cat images with text overlay

## 🔧 Installation

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS Simulator or Physical Device

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/nikkhilpareek/catfacts.git
   cd catfacts
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  cached_network_image: ^3.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  device_preview: ^1.1.0
  flutter_lints: ^3.0.0
```

## 🏗️ Project Structure

```
lib/
├── main.dart              # App entry point with DevicePreview
├── home_page.dart         # Main UI and business logic
└── [other files]

android/
├── app/
│   └── src/main/
│       └── AndroidManifest.xml  # Internet permissions
└── [other Android files]

ios/
└── [iOS configuration files]
```

## 🎨 Design

### Color Scheme
- **Primary Blue**: `#347093` (App title, text)
- **Light Blue**: `#8DC2D2` (Containers, backgrounds)
- **Background**: `#E3F2FD` (App bar background)
- **White**: Card backgrounds and contrast

### Typography
- **App Title**: 24px, FontWeight.w900
- **Body Text**: 18px, FontWeight.w500
- **Button Text**: 18px, FontWeight.bold

## 🔄 App Flow

1. **Launch**: App shows welcome screen with static cat image and welcome message
2. **User Action**: User taps "Get New Cat Fact" button
3. **Loading**: App shows loading indicator while fetching data
4. **Display**: New cat fact and random cat image are displayed
5. **Repeat**: User can tap button again for new content

## 🌐 Network Configuration

### Android
Internet permission is added in `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS
Network requests work out of the box for HTTPS endpoints.


## 🔒 Error Handling

- Network connectivity issues
- API endpoint failures
- JSON parsing errors
- Image loading failures

## 🚀 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

> Even though I don't think anyone would be interested to contribute, still if you want to you can follow the steps

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🙏 Acknowledgments

- **MeowFacts API** for providing cat facts
- **Cataas API** for providing cat images
- **Flutter Team** for the amazing framework
- **Cat lovers everywhere** for inspiration! 🐾

## 📧 Contact

**Developer**: Nikhil Pareek
- GitHub: [@nikkhilpareek](https://github.com/nikkhilpareek)
- Portfolio: [nikhilpareek.me](https://nikhilpareek.me)

## 🐛 Known Issues
- None currently reported

## 🔮 Features to be Added in Future

- [ ] Favorite cat facts
- [ ] Share functionality
- [ ] Cat breed information
- [ ] Offline mode with cached content
- [ ] Theme customization
- [ ] Cat fact categories
- [ ] User preferences

---

Made by Nikhil Pareek to pass time. 
