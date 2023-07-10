import 'package:flutter/material.dart';

import '../data/constants.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  List<ChatMessage> messages = [
    ChatMessage(message: 'Hey! This is your personal counselor. You can ask your queries here either about your course content or your academics.', isUserMessage: false),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .15,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                color: Constants.dark,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    const Text(
                      "Chat with Counselor!",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ])),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/chat.jpg'),
                      opacity: 0.4,
                      fit: BoxFit.fill)),
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatMessageWidget(
                    message: message.message,
                    isUserMessage: message.isUserMessage,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border.fromBorderSide(
                    BorderSide(color: Colors.black, width: 2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontWeight: FontWeight.w600),
                        hintText: 'Enter your query...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String message = _textEditingController.text;
                      if (message.isNotEmpty) {
                        setState(() {
                          messages.insert(
                            0,
                            ChatMessage(
                              message: message,
                              isUserMessage: true,
                            ),
                          );
                        });
                        _textEditingController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isUserMessage;

  ChatMessage({required this.message, required this.isUserMessage});
}

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const ChatMessageWidget(
      {super.key, required this.message, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Constants.dark : Colors.grey[300],
          borderRadius: BorderRadius.circular(17.0),
        ),
        child: Text(
          message,
          style: TextStyle(
              fontSize: 16.0,
              color: !isUserMessage ? Constants.dark : Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
