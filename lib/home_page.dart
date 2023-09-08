import 'package:ai_voice_assistant_app/pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.background,
      appBar: AppBar(
        backgroundColor: Pallete.background,
        centerTitle: true,
        title: const Text(
          "Assista",
          style: TextStyle(
              letterSpacing: 1,
              fontSize: 30,
              fontFamily: "font",
              color: Pallete.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            //image
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                        color: Pallete.secondary, shape: BoxShape.circle),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/body.png"))),
                  ),
                )
              ],
            ),
            //what can I do for you?
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(22))
                      .copyWith(topLeft: Radius.zero)),
              child: const Text(
                "What can I do for you?",
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontFamily: "font",
                    color: Pallete.primary,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 50),
            //features
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "Features",
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 40,
                    fontFamily: "font",
                    color: Pallete.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //buttons
            Container(
              width: 400,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                  color: Pallete.secondary,
                  borderRadius:
                      BorderRadius.circular(22).copyWith(topLeft: Radius.zero)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chatgpt');
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Pallete.primary)),
                      child: const Text(
                        "ChatGpt",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 40,
                            fontFamily: "font",
                            color: Pallete.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/dall-e');
                      },
                      style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 60)),
                          backgroundColor:
                              MaterialStateProperty.all(Pallete.primary)),
                      child: const Text(
                        "Dall-E",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 40,
                            fontFamily: "font",
                            color: Pallete.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
