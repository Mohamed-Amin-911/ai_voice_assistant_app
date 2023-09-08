import 'package:ai_voice_assistant_app/chatgpt_back.dart';
import 'package:ai_voice_assistant_app/dalle_back.dart';
import 'package:ai_voice_assistant_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DalleFront extends StatefulWidget {
  const DalleFront({super.key});

  @override
  State<DalleFront> createState() => _DalleFrontState();
}

class _DalleFrontState extends State<DalleFront> {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = "";
  String? generatedUrl;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  Future<void> initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(
      onResult: onSpeechResult,
    );
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.background,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Pallete.primary,
            )),
        backgroundColor: Pallete.background,
        centerTitle: true,
        title: const Text(
          "Dall-E",
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 30),

            //answer
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(generatedUrl ?? ""),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await Dalle().dallEAPI(lastWords);
            generatedUrl = speech;
            print(lastWords);
            print(speech);
            setState(() {});
            await stopListening();
          } else {
            initSpeech();
          }
        },
        backgroundColor:
            speechToText.isNotListening ? Pallete.primary : Pallete.text,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
