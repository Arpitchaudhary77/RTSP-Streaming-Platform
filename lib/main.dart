import 'package:flutter/material.dart';
import 'package:weather_app/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
// rtsp://192.168.1.6:5540/ch0
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'RTSP Stream', home: HomeScreen());
  }
}
