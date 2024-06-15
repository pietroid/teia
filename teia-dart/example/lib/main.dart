import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teia_dart/core/domain/teia.dart';
import 'package:teia_dart_example/list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => Teia(),
        child: const Scaffold(
          body: ListPage(),
        ));
  }
}
