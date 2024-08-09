import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/features/chat/repositories/chat_repository.dart';
import 'package:whatsapp_ui/models/chat_contact.dart';
import 'package:whatsapp_ui/models/message.dart';

final ChatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(ChatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContact();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(
      BuildContext context, String text, String recieverUserId) {
    final messageReply = ref.read(messageReplyProvider);
    // not the best way userDataAuthProvider it call Firebase when the data is there it is not good practice
    ref
        .read(userDataAuthProvider)
        .whenData((value) => chatRepository.sendTextMessage(
              context: context,
              text: text,
              recieverUserId: recieverUserId,
              senderUser: value!,
              messageReply: messageReply,
            ));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(BuildContext context, File file, String recieverUserId,
      MessageEnum messageEnum) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepository.sendFileMesssage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: value!,
            messageEnum: messageEnum,
            ref: ref,
            messageReply: messageReply));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
      BuildContext context, String gifUrl, String recieverUserId) {
    final messageReply = ref.read(messageReplyProvider);
    //this wont work
    //https://giphy.com/gifs/storyful-kamala-harris-via-storyful-you-see-what-i-did-there-NyrK2t2T1Ff4r14BC6.gif
    //store as below
    //https://i.giphy.com/media/NyrK2t2T1Ff4r14BC6/200.gif
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendGIFMessage(
              context: context,
              gifUrl: newgifUrl,
              recieverUserId: recieverUserId,
              senderUser: value!,
              messageReply: messageReply),
        );
    // is messageReply send and you not want to manually close
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void setChatMessageSeen(
    BuildContext context, String recieverUserId, String messageId,
  ) {
    chatRepository.setChatRepositorySeen(context, recieverUserId, messageId,);
  }
}

// agora depends on permission handler 9.2.0
