import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/feature_box.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo"),
        centerTitle: true,
        leading: Icon(CupertinoIcons.bars),
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
                          border: Border.all(
                               color: Colors.black
                          ),
                          borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                          ),
               ),
             child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                 child: Text(
                      "Hello!! How Can I Help You Today?",
                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
               ),
         ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text("Here are a few features",
                     style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: const [
                FeatureBox(color: Color.fromARGB(255, 123, 197, 231),
                 header: 'ChatGPT', 
                 description: 'A smarter way to stay organized and informed with ChatGPT'),
                FeatureBox(color: Color.fromARGB(255, 199, 239, 154),
                 header: 'Dall-E', 
                 description: 'Get inspired and stay creative with your personal assistant powered by Dall-E'),
                FeatureBox(color: Color.fromARGB(255, 66, 187, 209),
                 header: 'Smart Voice Assistant', 
                 description: 'Get the best of both words with a voice assistant powered by Ball-E and ChatGPT')
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 171, 236, 239),
        onPressed: () {},
      child: Icon(CupertinoIcons.mic),),
    );
  }
}

