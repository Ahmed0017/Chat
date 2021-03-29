import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data.docs;
          final user = FirebaseAuth.instance.currentUser;

          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, i) => MessageBubble(
              docs[i]['text'],
              docs[i]['userId'] == user.uid,
              docs[i]['userName'],
              docs[i]['userImage'],
              key: ValueKey(docs[i].id),
            ),
          );
        });
  }
}
