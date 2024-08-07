import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/features/chat/widgets/bottom_chat_field.dart';
import 'package:whatsapp_ui/models/user_model.dart';
import 'package:whatsapp_ui/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  final String name;
  final String uid;
  static const String routeName = 'mobile-chat-screen';
  const MobileChatScreen({Key? key, required this.name, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              print("data=>");
              print(snapshot.data!.isOnline);
              if (!snapshot.hasData) {
                return Text(name);
              }
              return Column(
                children: [
                  Text(name),
                  Text(snapshot.data!.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(fontSize: 13,
                  fontWeight: FontWeight.normal),),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
           Expanded(
            child: ChatList(recieverUserId:uid ,),
          ),
          BottomChatField(
            recieverUserId: uid,
          ),
        ],
      ),
    );
  }
}

