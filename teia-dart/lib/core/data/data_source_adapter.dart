import 'package:teia_dart/core/domain/entities/event.dart';

abstract class DataSourceAdapter {
  void add(Event event);
  void delete(Event event);
  void update({required Event past, required Event current});
  List<Event> where(bool Function(Event event) test);
}
