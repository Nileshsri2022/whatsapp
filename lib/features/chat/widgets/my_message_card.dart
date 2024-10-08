import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/features/chat/widgets/display_text_image_git.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  // for reply
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard(
      {Key? key,
      required this.message,
      required this.date,
      required this.type,
      required this.onLeftSwipe,
      required this.repliedText,
      required this.repliedMessageType,
      required this.username, required this.isSeen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("video url" + message);
    final isReplying = repliedText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: (details) => onLeftSwipe(),
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 25),
                  child: Column(
                    children: [
                      //if collection will allow only one widget and with ... allow multiple widget
                      if (isReplying) ...[
                        Text(
                          username,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: DisplayTextImageGIF(
                            message: repliedText,
                            type: repliedMessageType,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                      DisplayTextImageGIF(
                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                       Icon(
                        isSeen?
                        Icons.done_all:Icons.done,
                        size: 20,
                        color:isSeen?Colors.blue: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
