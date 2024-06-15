import 'package:teia_dart/core/data/in_memory_data_source.dart';
import 'package:teia_dart/core/data/teia_configurations.dart';
import 'package:teia_dart/core/domain/entities/event.dart';
import 'package:teia_dart/core/domain/entities/event_list_extensions.dart';
import 'package:teia_dart/core/domain/entities/event_listener.dart';
import 'package:teia_dart/core/presentation/teia_interface.dart';

class Teia implements TeiaInterface {
  List<EventListener> listeners = [];
  TeiaConfigurations configurations = TeiaConfigurations(
    dataSourceAdapter: InMemoryDataSource(),
  );

  @override
  void add(Event event) {
    configurations.dataSourceAdapter.add(event);
    update();
  }

  @override
  void delete(Event event) {
    configurations.dataSourceAdapter.delete(event);
    update();
  }

  @override
  void update() {
    for (final listener in listeners) {
      // calculate events that changed
      final currentEvents = configurations.dataSourceAdapter.where(listener.on);
      if (currentEvents == listener.pastEvents) continue;

      final eventsChanged = currentEvents
          .where((event) => !listener.pastEvents.contains(event))
          .toList();
      final eventsDeleted = listener.pastEvents
          .where((event) => !currentEvents.contains(event))
          .toList();
      listener.then(currentEvents, eventsChanged, eventsDeleted);
      listener.pastEvents = currentEvents.deepCopied;
    }
  }

  @override
  void listen({
    required bool Function(Event event) on,
    required void Function(
      List<Event> allEvents,
      List<Event> eventsChanged,
      List<Event> eventsDeleted,
    ) then,
  }) {
    listeners.add(EventListener(
      on: on,
      then: then,
    ));
  }

  @override
  List<Event> eventsWhere(bool Function(Event event) test) {
    return configurations.dataSourceAdapter.where(test);
  }
}
