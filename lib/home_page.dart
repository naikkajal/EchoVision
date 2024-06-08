import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/feature_box.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  final speechToText = SpeechToText();
  final flutterTts = TextToSpeech();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
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

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo"),
        centerTitle: true,
        leading: const Icon(CupertinoIcons.bars),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 27),
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(140),
                child: Image.asset(
                  'assets/images/chatbotimg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                generatedContent == null
                    ? "Hello!! How Can I Help You Today?"
                    : generatedContent!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text("Here are a few features",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: const [
                FeatureBox(
                    color: Color.fromARGB(255, 123, 197, 231),
                    header: 'ChatGPT',
                    description:
                        'A smarter way to stay organized and informed with ChatGPT'),
                FeatureBox(
                    color: Color.fromARGB(255, 199, 239, 154),
                    header: 'Dall-E',
                    description:
                        'Get inspired and stay creative with your personal assistant powered by Dall-E'),
                FeatureBox(
                    color: Color.fromARGB(255, 66, 187, 209),
                    header: 'Smart Voice Assistant',
                    description:
                        'Get the best of both words with a voice assistant powered by Ball-E and ChatGPT')
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 171, 236, 239),
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAIService.isArtPromptAPI(lastWords);
            if (speech.contains('https')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedImageUrl = null;
              generatedContent = speech;
              setState(() {});
              await systemSpeak(speech);
            }
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: Icon(CupertinoIcons.mic),
      ),
    );
  }
}
