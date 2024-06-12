part of 'reminder_bloc.dart';

@immutable
sealed class ReminderEvent {}

class LoadReminders extends ReminderEvent {}

class AddReminder extends ReminderEvent {
  final ReminderModel reminder;

  AddReminder(this.reminder);
}

class DeleteReminder extends ReminderEvent {
  final ReminderModel reminder;

  DeleteReminder(this.reminder);
}
