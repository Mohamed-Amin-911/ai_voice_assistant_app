import 'package:ai_voice_assistant_app/chatgpt_front.dart';
import 'package:ai_voice_assistant_app/dalle_front.dart';
import 'package:ai_voice_assistant_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/chatgpt': (context) => const ChatGptFront(),
        '/dall-e': (context) => const DalleFront(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Assista',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
