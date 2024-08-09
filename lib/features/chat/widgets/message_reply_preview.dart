import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';
import 'package:whatsapp_ui/features/chat/widgets/display_text_image_git.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({super.key});
  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);



    return Container(
      width: 350,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),

        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                messageReply!.isMe ? 'isMe' : 'Opposite',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              GestureDetector(
                child: Icon(
                  Icons.close,
                  size: 16,
                ),
                onTap:()=> cancelReply(ref),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          DisplayTextImageGIF(message: messageReply.message, type: messageReply.messageEnum)
        ],
      ),
    );
  }
}
