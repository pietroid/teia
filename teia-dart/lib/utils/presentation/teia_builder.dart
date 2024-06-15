import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teia_dart/core/domain/entities/event.dart';
import 'package:teia_dart/core/domain/teia.dart';

class TeiaBuilder extends StatefulWidget {
  final bool Function(Event event) on;
  final Widget Function(
    BuildContext context,
    List<Event> allEvents,
    List<Event> eventsChanged,
    List<Event> eventsDeleted,
  ) builder;
  const TeiaBuilder({
    super.key,
    required this.on,
    required this.builder,
  });

  @override
  State<TeiaBuilder> createState() => _TeiaBuilderState();
}

class _TeiaBuilderState extends State<TeiaBuilder> {
  late List<Event> allEvents;
  List<Event> eventsChanged = [];
  List<Event> eventsDeleted = [];

  @override
  void initState() {
    allEvents = context.read<Teia>().eventsWhere(widget.on);
    context.read<Teia>().listen(
          on: widget.on,
          then: (allEvents, eventsChanged, eventsDeleted) {
            setState(() {
              this.allEvents = allEvents;
              this.eventsChanged = eventsChanged;
              this.eventsDeleted = eventsDeleted;
            });
          },
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      allEvents,
      eventsChanged,
      eventsDeleted,
    );
  }
}
