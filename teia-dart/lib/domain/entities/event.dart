import 'package:teia_dart/domain/entities/event_type.dart';

abstract class Event {
  final DateTime time;
  final EventType type;

  Event({
    required this.type,
  }) : time = DateTime.now();

  Event get copy;
}
