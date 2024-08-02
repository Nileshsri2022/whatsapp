import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  File? image;
  void selectImage() async {
    image = await pickImageFromGallary(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    print("name=>"+name);
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Stack(
            children: [
              image == null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
                      radius: 64,
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        image!,
                      ),
                      radius: 64,
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(onPressed: selectImage, icon: Icon(Icons.add)))
            ],
          ),
          Row(
            children: [
              Container(
                width: size.width * 0.85,
                padding: EdgeInsets.all(20),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Enter your name')),
              ),
              IconButton(onPressed: storeUserData, icon: Icon(Icons.done))
            ],
          )
        ],
      ))),
    );
  }
}

// what the data the user sent we sent to auth_repository through auth_controller to save data to FirebaseFireStore