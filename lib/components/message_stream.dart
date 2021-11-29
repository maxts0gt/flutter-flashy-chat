import 'package:flutter/material.dart';
import './message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream(
      {Key? key, required this.stream, required this.currentUser})
      : super(key: key);
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = (message.data() as Map)['text'];
          final messageSender = (message.data() as Map)['sender'];
          final messageTimestamp = (message.data() as Map)['timestamp'];

          final messageBubble = MessageBubble(
            timestamp: messageTimestamp,
            sender: messageSender,
            text: messageText,
            isCurrentUser: messageSender == currentUser.email,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
