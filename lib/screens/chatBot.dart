import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> sendMessageToAPI(String message) async {
  const apiUrl =
      'http://murtaza1-001-site1.htempurl.com/api/ChatBot'; // Replace with your actual API URL
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'Text': message}),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData[0];
  } else {
    throw Exception('Failed to load response from API');
  }
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  bool _isSendingMessage = false;
  List<ChatMessage> messages = [
    const ChatMessage(
        message:
            'Hey! This is your personal counselor. You can ask your queries here either about your course content or your academics.',
        isUserMessage: false),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  void _sendMessage() async {
    final userMessage = _textEditingController.text;
    _textEditingController.clear();
    if (userMessage.isNotEmpty) {
      setState(() {
        messages.insert(
          0,
          ChatMessage(
            message: userMessage,
            isUserMessage: true,
          ),
        );
        _isSendingMessage = true; // Set _isSendingMessage to true while the API call is in progress
      });

      // Call the API and get the chatbot's response
      try {
        final apiResponse = await sendMessageToAPI(userMessage);

        // Add the chatbot's response as a new message in the chat
        setState(() {
          messages.insert(
            0,
            ChatMessage(
              message: apiResponse,
              isUserMessage: false,
            ),
          );
          _isSendingMessage = false; // Set _isSendingMessage back to false after receiving the API response
        });
      } catch (e) {
        // Handle API call errors
        print('Error: $e');
        _isSendingMessage = false; // Set _isSendingMessage back to false on API call error
      }

      _textEditingController.clear(); // Clear the input field after sending message
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Color(0xff231123), shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              'assets/bot.png',
                              height: 40,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Counselor",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Image.asset(
                          'assets/next.png',
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: const BoxDecoration(color: Color(0xfff2f3f7)),
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ChatMessage(
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
                    !_isSendingMessage?
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                    ):
                        const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isUserMessage
                      ? const Color(0xffA7CCED)
                      : const Color(0xffF4C095),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
