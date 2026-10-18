# AI Study Planner 📚🤖

An intelligent study companion built with Flutter that transforms your syllabus into personalized, difficulty-weighted study schedules. Featuring Pomodoro focus timers, break alarms with voice announcements, interactive flashcards, progress analytics, and exam countdowns.

---

## ✨ Features

- **🎯 Smart Timetable Generation**: Automatically allocates study duration based on subject difficulty (Hard, Medium, Easy) and total available daily hours.
- **⏱️ Pomodoro Focus Timer**: Built-in 25-min study & 5-min break cycles (with a quick 10s/5s demo mode for testing).
- **🔊 Voice Announcements & Vibration**: Text-to-speech voice notifications (`flutter_tts`) and haptic feedback (`vibration`) when sessions begin, end, or breaks are overdue.
- **🔔 Local Notifications**: System-level notifications (`flutter_local_notifications`) for study sessions and break reminders.
- **📊 Real-Time Progress Analytics**: Track completed, in-progress, and pending topics with interactive progress indicators.
- **🗂️ Interactive Concept Flashcards**: Auto-generated revision flashcards for key concepts with flip-to-reveal explanations and practice questions.
- **🛡️ Risk & Readiness Analysis**: Exam countdown combined with topic completion velocity to highlight study risk levels.
- **📷 Timetable & Notes Scanner Integration**: Ready with Google ML Kit text recognition for document scanning.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Material 3)
- **Language**: [Dart](https://dart.dev/)
- **State & Local Services**:
  - `flutter_tts` - Text-to-Speech voice prompts
  - `flutter_local_notifications` - Local reminder alerts
  - `vibration` - Haptic feedback alerts
  - `google_mlkit_text_recognition` - OCR text scanning
  - `sqflite` & `shared_preferences` - Local persistence

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.3.0 < 4.0.0)
- Android Studio / VS Code with Flutter extension
- An Android device or emulator (Android SDK 21+)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/vinod881/aistudyplanner.git
   cd aistudyplanner
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📱 Screenshots & Demo

- Welcome & Onboarding with Goal Selection
- Subject & Syllabus Setup with Difficulty Weighting
- Timetable Dashboard with Integrated Pomodoro Timer
- Progress Tracker & Subject Risk Analysis
- Concept Flashcards for Quick Revision

---

## 📄 License

This project is open-source under the MIT License.
