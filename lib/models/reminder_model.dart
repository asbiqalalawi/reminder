class ReminderModel {
  final int id;
  final DateTime time;
  final String title;
  final String? notes;
  final double? latitude;
  final double? longitude;

  ReminderModel({
    required this.id,
    required this.time,
    required this.title,
    required this.notes,
    this.latitude,
    this.longitude,
  });

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      time: DateTime.tryParse(map['time']) ?? DateTime.now(),
      title: map['title'],
      notes: map['notes'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
