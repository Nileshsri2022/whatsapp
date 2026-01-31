import 'package:flutter_riverpod/legacy.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(
      {required this.message, required this.isMe, required this.messageEnum});
}

// hence the message is vary so use StateProvider
final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);
