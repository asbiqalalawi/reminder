import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:reminder_app/bloc/reminder_bloc.dart';
import 'package:reminder_app/services/notification_service.dart';
import 'package:reminder_app/view/pages/add_reminder_page.dart';
import 'package:reminder_app/view/pages/reminder_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: {
          ReminderPage.routeName: (_) => const ReminderPage(),
          AddReminderPage.routeName: (_) => const AddReminderPage(),
        },
      ),
    );
  }
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
