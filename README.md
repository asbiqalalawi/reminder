# Reminder App Challenge

## Objective
Build a reminder app using Flutter with the BLoC pattern.

## Requirements
- **Time Reminders**: Users can set multiple reminders throughout the day (e.g., 9:00 AM, 10:00 AM, 12:00 PM).
- **Storage**: Utilize a local database solution like Hive, Sqflite, or similar to store reminders persistently on the device. Alternatively, consider using Firebase Firestore or Realtime Database for a cloud-based approach.
- **Notifications**: Trigger local notifications on the device at the designated reminder times.
- **Focus on UI/UX**: Create a user-friendly and visually appealing interface for adding, managing, and viewing reminders.
- **Bonus**: Implement location-based reminders (e.g., remind the user at a specific location).

## Features
- **Set Multiple Reminders**: Users can schedule multiple reminders throughout the day.
- **Persistent Storage**: Reminders are stored persistently using Sqflite.
- **Local Notifications**: Reminders trigger local notifications on the device at the specified times.
- **User-Friendly UI/UX**: Intuitive interface for adding, managing, and viewing reminders.
- **Location-Based Reminders** (Bonus): Users can set reminders to trigger at specific locations.

## Project Structure

```plaintext
- lib/
  - bloc/
  - helpers/
  - models/
  - services/
  - view/
    - widgets/
    - pages/
- pubspec.yaml
- README.md
```

## Getting Started

### Prerequisites
- Flutter SDK
- Dart

### Installation
1. Clone the repository:
    ```bash
    git clone <repository-url>
    ```

2. Navigate to the project directory:
    ```bash
    cd reminder_app
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

### Running the App
1. Run the app on an emulator or connected device:
    ```bash
    flutter run
    ```

## Notes
- This project uses the BLoC pattern for state management.
- Notifications are implemented using local notifications.
- The app uses Sqflite for local storage of reminders.
- Developed using Flutter version 3.22.2.

## Questions
If you have any questions about the assignment, please don't hesitate to ask!

Thank you for the opportunity to work on this challenge. I look forward to completing it and demonstrating my skills.

Best regards,  
Asbiq Al Alawi
