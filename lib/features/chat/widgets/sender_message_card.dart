import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/features/chat/widgets/display_text_image_git.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard(
      {Key? key, required this.message, required this.date, required this.type, required this.onRightSwipe, required this.repliedText, required this.username, required this.repliedMessageType})
      : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;

  @override
  Widget build(BuildContext context) {
    print("video url"+message);
    final isReplying = repliedText.isNotEmpty;
    return SwipeTo(
      onRightSwipe: (details)=>onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: senderMessageColor,
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
                  child:  Column(
                    children: [
                      //if collection will allow only one widget and with ... allow multiple widget
                      if(isReplying)...[
                        Text(username,style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: backgroundColor.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: DisplayTextImageGIF(
                          message: repliedText,
                          type: repliedMessageType,
                                                ),


                        ),
                        SizedBox(height: 8,)

                      ],
                      DisplayTextImageGIF(
                        message: message,
                        type: type,
                      ),

                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
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
