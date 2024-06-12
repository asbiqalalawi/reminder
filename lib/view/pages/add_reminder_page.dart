import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/bloc/reminder_bloc.dart';
import 'package:reminder_app/models/reminder_model.dart';
import 'package:reminder_app/view/widgets/input.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  static const String routeName = '/add-reminder';

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final notesController = TextEditingController();

  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reminder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedTime = newDateTime;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Input(
                controller: titleController,
                label: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Input(
                controller: notesController,
                label: 'Notes',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              BlocConsumer<ReminderBloc, ReminderState>(
                listener: (context, state) {
                  if (state is ReminderAddSuccess) {
                    Navigator.pop(context);
                  } else if (state is ReminderFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ReminderLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ReminderBloc>().add(
                              AddReminder(
                                ReminderModel(
                                  id: selectedTime.hashCode,
                                  time: selectedTime,
                                  title: titleController.text,
                                  notes: notesController.text,
                                ),
                              ),
                            );
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
