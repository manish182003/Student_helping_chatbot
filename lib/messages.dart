import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final List messages;
  const Messages({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (context, index) {
        var messagedata = widget.messages[index];
        return Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: messagedata['isusermessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(
                          messagedata['isusermessage'] ? 0 : 20),
                      topLeft: Radius.circular(
                          messagedata['isusermessage'] ? 20 : 0)),
                  color: messagedata['isusermessage']
                      ? Colors.grey.shade800
                      : Colors.grey.shade900.withOpacity(0.8),
                ),
                constraints: BoxConstraints(maxWidth: width * 2 / 3),
                child: AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        messagedata['message'].text.text[0],
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        //  speed: const Duration(milliseconds: 50),
                      ),
                    ]),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10),
        );
      },
      itemCount: widget.messages.length,
    );
  }
}
