# Voice Notes App 🎤

A Flutter application that converts speech to text for effortless note-taking with local storage and search capabilities.

## ✨ Features
- **Voice-to-Text**: Real-time speech recognition with auto-title generation
- **Secure Auth**: Email/password login with session persistence
- **CRUD Operations**: Create, read, update, delete notes with swipe gestures
- **Instant Search**: Real-time filtering of notes
- **Responsive UI**: Light/dark themes with smooth animations

## 🚀 Quick Start

### Installation
```bash
git clone https://github.com/yourusername/voice-notes-app.git
cd voice-notes-app
flutter pub get
flutter run
```

### Permissions
**Android** (`AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

**iOS** (`Info.plist`):
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Voice recording for notes</string>
```

## 📱 Screenshots
| Login | Home | Recording | Search |
|-------|------|-----------|--------|
| <img width="311" height="513" alt="image" src="https://github.com/user-attachments/assets/625be674-86b9-403b-834b-59afaa701969"/><br>
) | ![Home](screenshots/home.png) | ![Recording](screenshots/recording.png) | ![Search](screenshots/search.png) |

## 🏗️ Project Structure
```
lib/
├── main.dart
├── Authentication/     # Login & Signup
├── Controllers/       # GetX controllers
├── Data/             # Hive models
├── Views/            # Screens
└── Widgets/          # Reusable components
```

## 📦 Dependencies
- `get`: State management & navigation
- `hive`: Local database
- `speech_to_text`: Voice recognition
- `shared_preferences`: User preferences
- `flutter_slidable`: Swipe actions
- `google_fonts`: Typography
- `intl`: Date formatting

## 🛠️ Usage
1. **Create Account**: Sign up with email/password
2. **Record Note**: Tap `+` → Mic icon → Speak → Save
3. **Manage**: Swipe left to edit/delete notes
4. **Search**: Type in search bar for instant filtering
5. **Logout**: Tap logout icon in top-right

## 📄 License
MIT License - see [LICENSE](LICENSE) file.

---

⭐ **Star this repo if you find it useful!**
