import 'package:teia_dart/core/data/data_source_adapter.dart';
import 'package:teia_dart/core/domain/entities/event.dart';

class InMemoryDataSource extends DataSourceAdapter {
  final List<Event> _events = [];

  @override
  void add(Event event) {
    _events.add(event);
  }

  @override
  void delete(Event event) {
    _events.remove(event);
  }

  @override
  void update({
    required Event past,
    required Event current,
  }) {
    final index = _events.indexOf(past);
    if (index != -1) {
      _events[index] = current;
    }
  }

  @override
  List<Event> where(bool Function(Event event) test) {
    return _events.where(test).toList();
  }
}
