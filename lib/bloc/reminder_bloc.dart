import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reminder_app/helpers/database_helper.dart';
import 'package:reminder_app/models/reminder_model.dart';
import 'package:reminder_app/services/notification_service.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final NotificationService service = NotificationService();

  ReminderBloc() : super(ReminderInitial()) {
    on<LoadReminders>((event, emit) async {
      emit(ReminderLoading());
      final reminders = await dbHelper.queryAllReminders();
      emit(RemindersLoaded(reminders: reminders));
    });

    on<AddReminder>((event, emit) async {
      try {
        emit(ReminderLoading());

        final reminder = event.reminder;

        await service.scheduleNotification(
          reminder.id,
          reminder.title,
          reminder.notes,
          reminder.time,
        );

        final reminderDb = {
          'id': reminder.id,
          'time': reminder.time.toIso8601String(),
          'title': reminder.title,
          'notes': reminder.notes,
          'latitude': reminder.latitude,
          'longitude': reminder.longitude,
        };
        await dbHelper.insertReminder(reminderDb);

        emit(ReminderAddSuccess());
        final reminders = await dbHelper.queryAllReminders();
        emit(RemindersLoaded(reminders: reminders));
      } catch (e) {
        if (e is ArgumentError) {
          emit(ReminderFailed(error: e.message));
        } else {
          emit(ReminderFailed(error: e.toString()));
        }
        final reminders = await dbHelper.queryAllReminders();
        emit(RemindersLoaded(reminders: reminders));
      }
    });

    on<DeleteReminder>((event, emit) async {
      emit(ReminderLoading());
      if (event.reminder.time.isAfter(DateTime.now())) {
        await service.cancelNotification(event.reminder.id);
      }
      await dbHelper.deleteReminder(event.reminder.id);
      final reminders = await dbHelper.queryAllReminders();
      emit(RemindersLoaded(reminders: reminders));
    });
  }
}
