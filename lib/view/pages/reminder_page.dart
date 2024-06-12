import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/bloc/reminder_bloc.dart';
import 'package:reminder_app/services/notification_service.dart';
import 'package:reminder_app/view/pages/add_reminder_page.dart';
import 'package:reminder_app/view/widgets/reminder_card.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  static const String routeName = '/';

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    super.initState();

    NotificationService().requestPermission();

    context.read<ReminderBloc>().add(LoadReminders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          if (state is RemindersLoaded) {
            if (state.reminders.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ReminderBloc>().add(LoadReminders());
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.reminders.length,
                  itemBuilder: (context, index) => ReminderCard(reminder: state.reminders[index]),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                ),
              );
            }
            return const Center(child: Text('Please add some reminders'));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddReminderPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
