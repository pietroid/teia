import 'package:teia_dart/domain/entities/event.dart';

extension EventListExtensions on List<Event> {
  List<Event> get deepCopied => map((e) => e.copy).toList();
}
