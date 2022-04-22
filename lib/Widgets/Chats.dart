import 'package:chit_chat/Widgets/MessageBubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapShot) => futureSnapShot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(), 
              builder: (ctx, streamSnapShot) {
                if (streamSnapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final document = streamSnapShot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (ctx, i) => MessageBubble(
                    document[i]['text'],
                    futureSnapShot.data.uid == document[i]['userId'],
                    document[i]['userName'],
                    document[i]['imageUrl'],
                    document[i]['createdAt'],
                    key: ValueKey(document[i].documentID),
                  ),
                  itemCount: document.length,
                );
              },
            ),
    );
  }
}
