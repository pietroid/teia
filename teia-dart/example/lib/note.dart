import 'package:teia_dart/teia_dart.dart';

class Note extends Event {
  final String title;
  final String content;

  Note({
    required this.title,
    required this.content,
  }) : super(type: EventType(type: "note"));

  @override
  Note get copy => Note(
        title: title,
        content: content,
      );
}
