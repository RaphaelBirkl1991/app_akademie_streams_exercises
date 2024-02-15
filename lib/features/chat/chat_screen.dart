import 'package:flutter/material.dart';
import 'package:streams_exercises/features/chat/chat_message.dart';
import 'package:streams_exercises/features/chat/chat_repository.dart';

class ChatScreen extends StatefulWidget {
  final ChatRepository chatRepository;

  const ChatScreen({
    super.key,
    required this.chatRepository,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    widget.chatRepository.startSendingMessages();
  }

  @override
  void dispose() {
    widget.chatRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () {
                  widget.chatRepository.startSendingMessages();
                },
                child: const Text("start the chat")),
            StreamBuilder<ChatMessage>(
                stream: widget.chatRepository.messages,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final message = snapshot.data;
                    return Text('${message?.user}: ${message?.message}');
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
