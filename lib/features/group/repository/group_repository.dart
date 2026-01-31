import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_ui/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/models/group.dart' as model;

final groupRepositoryProvider=Provider((ref)=>GroupRepository(firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance, ref: ref,),);

class GroupRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final Ref ref;

  GroupRepository(
      {required this.firestore, required this.auth, required this.ref});
  void createGroup(BuildContext context, String name, File profilePic,
      List<Contact> selectedContact) async {
    try {
      List<String> uids = [];
      for (var i = 0; i < selectedContact.length; i++) {
        var userCollection = await firestore
            .collection('status')
            .where('phoneNumber',
                isEqualTo:
                    selectedContact[i].phones[0].number.replaceAll(' ', ''))
            .get();

        if (userCollection.docs.isNotEmpty&&userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()['uid']);
        }
      }
      var groupId = const Uuid().v1();
      String profileUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase('group/$groupId', profilePic);
      model.Group group = model.Group(
          name: name,
          groupId: groupId,
          senderId: auth.currentUser!.uid,
          lastMessage: '',
          timeSent: DateTime.now(),
          groupPic: profileUrl,
          membersUid: [auth.currentUser!.uid, ...uids]);
      await firestore.collection('groups').doc(groupId).set(group.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
