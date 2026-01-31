import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/features/call/repository/call_repository.dart';

import 'package:whatsapp_ui/models/call_model.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
      callRepository: callRepository, auth: FirebaseAuth.instance, ref: ref);
});

class CallController {
  final CallRepository callRepository;
  final Ref ref;
  final FirebaseAuth auth;

  CallController(
      {required this.callRepository, required this.auth, required this.ref});
  void makeCall(BuildContext context, String recieverName, String reciverUid,
      String recieverProfilePic, bool isGroupChat) {
    ref.read(userDataAuthProvider).whenData((value) {
      String callId = const Uuid().v1();
      Call senderCallData = Call(
          callerId: auth.currentUser!.uid,
          callerName: value!.name,
          callerPic: value.profilePic,
          receiverId: reciverUid,
          receiverName: recieverName,
          receiverPic: recieverProfilePic,
          callId: callId,
          hasDialled: true);
      Call recieverCallData = Call(
          callerId: auth.currentUser!.uid,
          callerName: value.name,
          callerPic: value.profilePic,
          receiverId: reciverUid,
          receiverName: recieverName,
          receiverPic: recieverProfilePic,
          callId: callId,
          hasDialled: false);
      if (isGroupChat) {
      callRepository.makeGroupCall(context, senderCallData, recieverCallData);
    }
    else{
      callRepository.makeCall(context, senderCallData, recieverCallData);
    }
    });

  }

  Stream<DocumentSnapshot> get callStream => callRepository.callStream;
  void endCall(
    String callerId,
    String recieverId,
    BuildContext context,
  ) {
    callRepository.endCall( callerId, recieverId,context);
  }
}
