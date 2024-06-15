import 'package:flutter_test/flutter_test.dart';
import 'package:teia_dart/core/domain/entities/event.dart';
import 'package:teia_dart/core/domain/entities/event_type.dart';
import 'package:teia_dart/core/domain/teia.dart';

class MyEvent extends Event {
  MyEvent({this.data = ""}) : super(type: EventType(type: 'my_event'));

  @override
  Event get copy => MyEvent(data: data);

  String data;
}

void main() {
  group('Teia', () {
    group('when subject is listening to events', () {
      late Teia teia;
      MyEvent event = MyEvent();
      List<Event> allEvents_ = [];
      List<Event> eventsChanged_ = [];
      List<Event> eventsDeleted_ = [];
      setUp(() {
        teia = Teia();
        teia.listen(
            on: (event) => true,
            then: (allEvents, eventsChanged, eventsDeleted) {
              allEvents_ = allEvents;
              eventsChanged_ = eventsChanged;
              eventsDeleted_ = eventsDeleted;
            });
      });
      test('should detect a new added event', () {
        teia.add(MyEvent());

        expect(allEvents_.length, 1);
        expect(eventsChanged_.length, 1);
        expect(eventsDeleted_.length, 0);
      });

      test('should detect a modified event', () {
        teia.add(event);
        event.data = "modified";
        teia.update();

        expect(allEvents_.length, 1);
        expect(eventsChanged_.length, 1);
        expect(eventsDeleted_.length, 1);
      });
    });
  });
}
