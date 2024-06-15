import 'package:teia_dart/domain/entities/event.dart';

class EventListener {
  final bool Function(Event event) on;
  final void Function(
    List<Event> allEvents,
    List<Event> eventsChanged,
    List<Event> eventsDeleted,
  ) then;

  List<Event> pastEvents = [];

  EventListener({
    required this.on,
    required this.then,
  });
}
