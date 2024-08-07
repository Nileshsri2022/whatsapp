import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/select_contacts/screens/select_contact_screen.dart';
import 'package:whatsapp_ui/models/user_model.dart';
import 'package:whatsapp_ui/features/chat/screens/mobile_chat_screen.dart';

// repo->controller->screens
final selectContactsRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
      else{
        print('Permission denied');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      if (userCollection.docs.isEmpty) {
        showSnackBar(context: context, content: "No users found.");
        return;
      }
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());

        //if you not use withProperties: true the number property gave you empty string

        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNum.isEmpty) {
          showSnackBar(
              context: context,
              content: "Selected contact has no phone number.");
          return;
        }
        if (selectedPhoneNum[0] != '+') {
          selectedPhoneNum = '+91${selectedPhoneNum}';
        }
        print(selectedPhoneNum);
        print("no=>" + userData.phoneNumber);
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName,
              arguments: {'name': userData.name, 'uid': userData.uid});
          break;
        }
      }
      if (!isFound) {
        showSnackBar(context: context, content: "This no does\'t exist");
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
