part of 'reminder_bloc.dart';

@immutable
sealed class ReminderState {}

final class ReminderInitial extends ReminderState {}

final class ReminderLoading extends ReminderState {}

final class RemindersLoaded extends ReminderState {
  final List<ReminderModel> reminders;

  RemindersLoaded({required this.reminders});
}

final class ReminderAddSuccess extends ReminderState {}

final class ReminderFailed extends ReminderState {
  final String error;

  ReminderFailed({required this.error});
}
