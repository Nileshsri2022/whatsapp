// TODO: Re-enable when agora_uikit is compatible with Flutter 3.38
// import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:whatsapp_ui/common/widgets/loader.dart';
// import 'package:whatsapp_ui/config/agora_config.dart';
import 'package:whatsapp_ui/features/call/controller/call_controller.dart';
import 'package:whatsapp_ui/models/call_model.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String channelId;
  final Call call;
  final bool isGroupChat;
  const CallScreen(
      {required this.channelId,
      required this.call,
      required this.isGroupChat,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: Agora video calling temporarily disabled - upgrade agora_uikit for Flutter 3.38
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref
                .read(callControllerProvider)
                .endCall(widget.call.callerId, widget.call.receiverId, context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('Video calling temporarily unavailable',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Agora SDK needs upgrade for Flutter 3.38',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(callControllerProvider).endCall(
                    widget.call.callerId, widget.call.receiverId, context);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.call_end, color: Colors.white),
              label: const Text('End Call'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
