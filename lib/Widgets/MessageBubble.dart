import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      this.message, this.isMe, this.name, this.imageUrl, this.createdAt,
      {this.key});

  final String message;
  final bool isMe;
  final String imageUrl;
  final Key key;
  final String name;
  final Timestamp createdAt;
  @override
  Widget build(BuildContext context) {
    DateTime time = createdAt.toDate();
    return Container(
      child: Row(
        children: [
          if (isMe) Spacer(),
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    isMe ? 'You' : name,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: !isMe ? Colors.black : Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  )),
              Container(
                width: isMe
                    ? message.length > 45
                        ? 280
                        : null
                    : message.length > 35
                        ? 250
                        : null,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: isMe ? Radius.circular(15) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : Radius.circular(15),
                    ),
                    color: !isMe
                        ? Colors.grey[300]
                        : Theme.of(context).primaryColor),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                              color: !isMe ? Colors.black : Colors.white),
                          // textAlign: isMe ? TextAlign.end : TextAlign.start,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          if (time.hour > 12 && time.hour <= 21)
                            Text(
                              time.minute > 9
                                  ? '0' +
                                      (time.hour - 12).toString() +
                                      ':' +
                                      time.minute.toString() +
                                      ' PM'
                                  : '0' +
                                      (time.hour - 12).toString() +
                                      ':0' +
                                      time.minute.toString() +
                                      ' PM',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: !isMe ? Colors.black : Colors.white),
                              textAlign: isMe ? TextAlign.start : TextAlign.end,
                            ),
                          if (time.hour > 21)
                            Text(
                              time.minute > 9
                                  ? (time.hour - 12).toString() +
                                      ':' +
                                      time.minute.toString() +
                                      ' PM'
                                  : (time.hour - 12).toString() +
                                      ':0' +
                                      time.minute.toString() +
                                      ' PM',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: !isMe ? Colors.black : Colors.white),
                              textAlign: isMe ? TextAlign.start : TextAlign.end,
                            ),
                          if (time.hour == 12)
                            Text(
                              time.minute > 9
                                  ? time.hour.toString() +
                                      ':' +
                                      time.minute.toString() +
                                      ' PM'
                                  : time.hour.toString() +
                                      ':0' +
                                      time.minute.toString() +
                                      ' PM',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: !isMe ? Colors.black : Colors.white),
                              textAlign: isMe ? TextAlign.start : TextAlign.end,
                            ),
                          if (time.hour < 12 && time.hour > 9)
                            Text(
                              time.minute > 9
                                  ? time.hour.toString() +
                                      ':' +
                                      time.minute.toString() +
                                      ' AM'
                                  : time.hour.toString() +
                                      ':0' +
                                      time.minute.toString() +
                                      ' AM',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: !isMe ? Colors.black : Colors.white),
                              textAlign: isMe ? TextAlign.start : TextAlign.end,
                            ),
                          if (time.hour < 10)
                            Text(
                              time.minute > 9
                                  ? '0' +
                                      time.hour.toString() +
                                      ':' +
                                      time.minute.toString() +
                                      ' AM'
                                  : '0' +
                                      time.hour.toString() +
                                      ':0' +
                                      time.minute.toString() +
                                      ' AM',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: !isMe ? Colors.black : Colors.white),
                              textAlign: isMe ? TextAlign.start : TextAlign.end,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin:
                    EdgeInsets.only(left: 8, bottom: 8, right: isMe ? 8 : 0),
              ),
            ],
          ),
          if (!isMe) Spacer()
        ],
      ),
    );
  }
}
