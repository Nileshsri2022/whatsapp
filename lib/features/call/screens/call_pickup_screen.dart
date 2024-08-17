import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/call/controller/call_controller.dart';
import 'package:whatsapp_ui/features/call/screens/call_screen.dart';
import 'package:whatsapp_ui/models/call_model.dart';

class CallPickupScreen extends ConsumerWidget {
  final Widget scaffold;
  const CallPickupScreen({required this.scaffold, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<DocumentSnapshot>(
        stream: ref.watch(callControllerProvider).callStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data()!=null) {
            Call call =
                Call.fromMap(snapshot.data!.data() as Map<String, dynamic>);
            if (!call.hasDialled) {
              return Scaffold(
                body: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Incoming Call',style: TextStyle(fontSize: 30,color: Colors.white),),
                      SizedBox(height: 50),
                      CircleAvatar(
                        backgroundImage: NetworkImage(call.callerPic),
                        radius: 60,
                      ),
                      SizedBox(height: 50),
                      Text(call.callerName,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w900),),
                      SizedBox(height: 75),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen(channelId: call.callId, call: call, isGroupChat: false)));
                          }, icon: Icon(Icons.call_end,color:Colors.redAccent)),
                          SizedBox(width: 25,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.call,color:Colors.green)),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return scaffold;
        });
  }
}
