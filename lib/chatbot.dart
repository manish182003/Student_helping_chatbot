import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:studentchatbot/messages.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  DialogFlowtter? dialogFlowtter;
  final TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('message is empty');
    } else {
      setState(
        () {
          addmessage(
            Message(
              text: DialogText(
                text: [text],
              ),
            ),
            true,
          );
        },
      );

      DetectIntentResponse response = await dialogFlowtter!.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: text),
        ),
      );

      if (response.message == null) {
        return;
      } else {
        setState(() {
          addmessage(response.message!);
        });
      }
    }
  }

  void addmessage(Message message, [bool isusermessage = false]) {
    messages.add({
      'message': message,
      'isusermessage': isusermessage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Helping Bot'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(messages: messages),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.deepPurple,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(controller.text);
                      controller.clear();
                    },
                    icon: Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
