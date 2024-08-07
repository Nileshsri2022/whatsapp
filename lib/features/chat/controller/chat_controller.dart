import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/features/chat/repositories/chat_repository.dart';

final ChatControllerProvider = Provider((ref){
  final chatRepository=ref.watch(ChatRepositoryProvider);
  return ChatController(
    chatRepository:chatRepository,
    ref:ref
  );
});
class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});
  void sendTextMessage(
      BuildContext context, String text, String recieverUserId) {
        // not the best way userDataAuthProvider it call Firebase when the data is there it is not good practice
        ref.read(userDataAuthProvider).whenData((value)=>chatRepository.sendTextMessage(
        context: context,
        text: text,
        recieverUserId: recieverUserId,
        senderUser: value!));

  }
}