import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/call/screens/call_screen.dart';
import 'package:whatsapp_ui/models/call_model.dart';
import 'package:whatsapp_ui/models/group.dart' as model;
import 'package:whatsapp_ui/models/group.dart';

final callRepositoryProvider = Provider(
  (ref) => CallRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class CallRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CallRepository({required this.firestore, required this.auth});
  void makeCall(
      BuildContext context, Call senderCallData, Call recieverCallData) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      await firestore
          .collection('call')
          .doc(senderCallData.receiverId)
          .set(recieverCallData.toMap());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CallScreen(
                  channelId: senderCallData.callId,
                  call: senderCallData,
                  isGroupChat: false)));
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void makeGroupCall(
      BuildContext context, Call senderCallData, Call recieverCallData) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      var groupSnapshot = await firestore
          .collection('groups')
          .doc(senderCallData.receiverId)
          .get();
      Group group = model.Group.fromMap(groupSnapshot.data()!);
      for(var id in group.membersUid){
await firestore
          .collection('call')
          .doc(id)
          .set(recieverCallData.toMap());
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CallScreen(
                  channelId: senderCallData.callId,
                  call: senderCallData,
                  isGroupChat: true)));
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

   void endCall(
    String callerId,
    String receiverId,
    BuildContext context,

  ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      await firestore.collection('call').doc(receiverId).delete();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
  void endGroupCall(BuildContext context, String callerId, String recieverId) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      await firestore.collection('call').doc(recieverId).delete();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<DocumentSnapshot> get callStream =>
      firestore.collection('call').doc(auth.currentUser!.uid).snapshots();
}
