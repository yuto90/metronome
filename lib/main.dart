import 'package:flutter/material.dart';
import 'home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Metronome());
}

class Metronome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'metronome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
