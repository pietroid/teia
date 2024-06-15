import 'package:teia_dart/domain/entities/event.dart';

abstract class TeiaInterface {
  void add(Event event);
  void delete(Event event);
  void update();

  void eventsWhere(bool Function(Event event) test);
  void listen({
    required bool Function(Event event) on,
    required void Function(
      List<Event> allEvents,
      List<Event> eventsChanged,
      List<Event> eventsDeleted,
    ) then,
  });
}
