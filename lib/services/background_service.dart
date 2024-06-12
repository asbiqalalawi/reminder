// services/background_service.dart

import 'package:reminder_app/helpers/database_helper.dart';
import 'package:reminder_app/models/reminder_model.dart';
import 'package:reminder_app/services/location_service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:geolocator/geolocator.dart';
import 'notification_service.dart';

class BackgroundService {
  static const String checkLocationTask = "checkLocationTask";

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == checkLocationTask) {
        final dbHelper = DatabaseHelper();
        final notificationService = NotificationService();
        final locationService = LocationService();

        Position currentPosition = await locationService.getCurrentLocation();
        int reminderId = inputData!['reminderId'];
        ReminderModel? reminder = await dbHelper.getReminderById(reminderId);

        if (reminder != null && reminder.latitude != null && reminder.longitude != null) {
          final distance = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            reminder.latitude!,
            reminder.longitude!,
          );

          if (distance < 100) {
            notificationService.showNotification(reminder.id, reminder.title, reminder.notes ?? '');
          } else {
            notificationService.cancelNotification(reminder.id);
          }
        }
      }
      return Future.value(true);
    });
  }

  static void registerLocationCheckTask(int reminderId, DateTime scheduledTime) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerOneOffTask(
      "locationCheckTask_$reminderId",
      checkLocationTask,
      inputData: {'reminderId': reminderId},
      initialDelay: scheduledTime.difference(DateTime.now()),
    );
  }
}
