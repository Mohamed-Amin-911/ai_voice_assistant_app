import 'package:ai_voice_assistant_app/chatgpt_back.dart';
import 'package:ai_voice_assistant_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatGptFront extends StatefulWidget {
  const ChatGptFront({super.key});

  @override
  State<ChatGptFront> createState() => _ChatGptFrontState();
}

class _ChatGptFrontState extends State<ChatGptFront> {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = "";
  String? generatedContent;

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
      // listenFor: const Duration(seconds: 30),
      // localeId: "en_En",
      // cancelOnError: false,
      // partialResults: false,
      // listenMode: ListenMode.confirmation,
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
          "ChatGPT",
          style: TextStyle(
              letterSpacing: 1,
              fontSize: 30,
              fontFamily: "font",
              color: Pallete.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: 400,
              height: 400,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                  color: Pallete.secondary,
                  borderRadius:
                      BorderRadius.circular(22).copyWith(topLeft: Radius.zero)),
              child: SingleChildScrollView(
                child: Text(
                  generatedContent ?? "",
                  style: const TextStyle(
                      // letterSpacing: 1,
                      fontSize: 25,
                      fontFamily: "font",
                      color: Pallete.primary,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30, top: 25),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {
            //           ChatGpt().messages.clear();
            //         },
            //         style: const ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(Pallete.primary)),
            //         child: const Text(
            //           "new session",
            //           style: TextStyle(
            //               // letterSpacing: 1,
            //               fontSize: 20,
            //               fontFamily: "font",
            //               color: Pallete.background,
            //               fontWeight: FontWeight.w400),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await ChatGpt().chatGPTAPI(lastWords);

            generatedContent = speech;
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
