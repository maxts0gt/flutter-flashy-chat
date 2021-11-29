import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.sender,
      required this.text,
      required this.timestamp,
      required this.isCurrentUser})
      : super(key: key);
  final String sender;
  final Timestamp timestamp;
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    var myDate = timestamp.toDate();
    String myTimeString = DateFormat('hh:mm a').format(myDate).toString();
    String myDateString = DateFormat('MM:dd').format(myDate).toString();
    String dateTime = myDateString + "/" + myTimeString;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            dateTime,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
              elevation: 4.0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isCurrentUser ? 30.0 : 0.0),
                topRight: Radius.circular(isCurrentUser ? 0.0 : 30.0),
                bottomLeft: const Radius.circular(30.0),
                bottomRight: const Radius.circular(30.0),
              ),
              color: isCurrentUser ? Colors.lightBlueAccent : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
