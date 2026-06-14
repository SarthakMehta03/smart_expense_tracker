# Smart Expense Tracker

A modern Flutter + Firebase application that helps users manage their daily expenses, track spending habits, and visualize financial data through interactive analytics dashboards.

---

## Features

### Authentication

* User Registration
* User Login
* Secure Firebase Authentication
* Logout Functionality

### Expense Management

* Add Expense
* View Expense List
* Update Expense
* Delete Expense
* Real-time Firestore Updates

### Search & Filtering

* Search Expenses by Title
* Search Expenses by Category

### Analytics Dashboard

* Total Expenses
* Monthly Expenses
* Today's Expenses
* Category-wise Expense Distribution
* Pie Chart Analytics
* Monthly Spending Bar Chart

### User Experience

* Dark Mode Support
* Loading Indicators
* Error Handling with SnackBars
* Responsive UI
* Real-time Data Synchronization

---

## Tech Stack

### Frontend

* Flutter
* Dart

### Backend

* Firebase Authentication
* Cloud Firestore

### State Management

* Provider

### Charts & Analytics

* fl_chart

---

## Project Structure

```text
lib/
├── models/
├── providers/
│   └── theme_provider.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── expense/
│   │   └── add_expense_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── expense_list_screen.dart
│   ├── analytics/
│   │   ├── analytics_screen.dart
│   │   ├── expense_pie_chart.dart
│   │   └── monthly_bar_chart.dart
│   └── profile/
│       └── profile_screen.dart
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
├── utils/
│   ├── light_theme.dart
│   └── dark_theme.dart
├── firebase_options.dart
└── main.dart
```

---

## Screenshots

### Login Screen

(Add Screenshot Here)

### Register Screen

(Add Screenshot Here)

### Home Screen

(Add Screenshot Here)

### Analytics Dashboard

(Add Screenshot Here)

### Profile Screen

(Add Screenshot Here)

---

## Installation

### Clone Repository

```bash
git clone https://github.com/SarthakMehta03/smart_expense_tracker.git
```

```bash
cd smart_expense_tracker
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Firebase Setup

### Step 1: Create Firebase Project

1. Open Firebase Console
2. Create a new project
3. Enable Authentication
4. Enable Cloud Firestore

### Step 2: Configure FlutterFire

```bash
flutterfire configure
```

### Step 3: Install Firebase Packages

```bash
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
```

### Step 4: Initialize Firebase

Ensure Firebase is initialized in `main.dart`.

---

## Dependencies

```yaml
firebase_core
firebase_auth
cloud_firestore
provider
fl_chart
```

---

## Current Features Completed

* Firebase Authentication
* Expense CRUD Operations
* Firestore Integration
* Search Functionality
* Analytics Dashboard
* Pie Chart Visualization
* Monthly Bar Chart
* Dark Mode Toggle
* Profile Screen
* Loading States
* Error Handling
* Responsive UI

---

## Future Enhancements

* PDF Export
* CSV Export
* Budget Planning
* Expense Categories Report
* Notifications & Reminders
* Cloud Backup
* Multi-device Synchronization
* AI-powered Expense Insights
* Expense Prediction Analytics

---

## Author

**Sarthak Mehta**

MSc Information Technology Student

Built with Flutter, Firebase, and Dart.

---

## License

This project is for educational and portfolio purposes.
