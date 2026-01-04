# 📝 Task Manager

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Material Design 3](https://img.shields.io/badge/Material%20Design%203-7C4DFF?style=for-the-badge&logo=materialdesign&logoColor=white)

A modern, beautiful, and real-time Task Management application built with **Flutter** and **Firebase**.
Designed with **Material 3** principles, focusing on simplicity, smooth animations, and a clean user experience.

---

## ✨ Features (What it does)

This application helps users organize their day by managing tasks in real-time.

* **🔐 Authentication:**
    * **Guest Mode:** Quick access without registration (Anonymous Auth).
    * **Email/Password:** Secure registration and login to save data permanently.
    * **Smart UI:** Elegant toggle between Sign Up and Login modes.
* **☁️ Real-time Database:**
    * Tasks are synced instantly across devices using **Cloud Firestore**.
    * Add, Complete, and Delete tasks with live updates.
* **🎨 Modern UI/UX:**
    * **Material 3 Design:** Uses the latest Flutter theming capabilities.
    * **Global Styling:** Consistent rounded corners, shadows, and fonts.
    * **Animations:** Smooth transitions for checking off tasks.
    * **Glassmorphism:** Modern, frosted-glass effect on the login screen.
* **⚡ Performance:** Lightweight and fast state management using `Provider`.




| Login / Sign Up | Task List |
|:---:|:---:|
| <br> <img width="300" height="430" alt="image" src="https://github.com/user-attachments/assets/8a53ee8d-55f4-4f61-b271-6f1c97b197b1" /> | <br> <img width="300" height="430" alt="image" src="https://github.com/user-attachments/assets/d3810c80-78de-46d9-88c4-15acdb111a25" />

---

## 🛠️ Tech Stack

Built with love and the following technologies:

| Category | Technology | Description |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) | Cross-platform UI toolkit. |
| **Language** | [Dart](https://dart.dev/) | Optimized for UI. |
| **Backend** | [Firebase Auth](https://firebase.google.com/products/auth) | User authentication management. |
| **Database** | [Cloud Firestore](https://firebase.google.com/products/firestore) | NoSQL real-time database. |
| **State Management** | [Provider](https://pub.dev/packages/provider) | Efficient dependency injection and state management. |
| **Design System** | Material 3 | Google's latest design language. |

---

## 🚀 Setup & Installation

Follow these steps to run the project locally.

### Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
* A connected device (Emulator or Physical phone) or Chrome browser.

### 1. Clone the repository
```bash
git clone [https://github.com/your-username/task-manager.git](https://github.com/your-username/task-manager.git)
cd task-manager
```
### 2. Install Dependencies
Download all the required packages listed in pubspec.yaml.
```bash
flutter pub get
```
### 3. Firebase Configuration
note: If you are the owner, ensure lib/firebase_options.dart is present. If you are cloning this as a template, you must configure your own Firebase project:
- Install Firebase CLI.

- Run "flutterfire configure" in the terminal.

- Select your project and platforms.

### 4. Run the App
Launch the app on your preferred platform (Android, iOS, or Web).
```bash
# Run on Chrome
flutter run -d chrome

# Run on Android Emulator
flutter run
```

## 📂 Project Structure
<img width="425" height="140" alt="image" src="https://github.com/user-attachments/assets/605d8394-8081-422f-90c7-20596c2be92e" />
