//chat.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_firebase/data/provider/auth_provider.dart';

import '../widgets/chat_messages.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: Column(
          children: const [
            Expanded(
                child: ChatMessages()
            ),
            NewMessage(),
          ],
        ),
      );
  }
}