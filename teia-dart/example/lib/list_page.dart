import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teia_dart/domain/teia.dart';
import 'package:teia_dart_example/note.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Note> notes = [];

  @override
  void initState() {
    // TODO: implement initState

    final teia = context.read<Teia>();
    teia.listen(
        on: (event) => event is Note,
        then: (notes, changedNotes, deletedNotes) {
          setState(() {
            this.notes = notes as List<Note>;
          });
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notes[index].title),
          subtitle: Text(notes[index].content),
        );
      },
      itemCount: notes.length,
    );
  }
}
