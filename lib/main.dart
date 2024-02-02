//main.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mini_project_firebase/data/provider/auth_provider.dart';
import 'package:mini_project_firebase/data/provider/chat_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/auth.dart';
import 'presentation/screens/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider<ChatProvider>(
              create: (context) => ChatProvider()
          ),
          ChangeNotifierProvider<AuthNotifier>(
              create: (context) => AuthNotifier()
          )
        ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: Consumer<AuthNotifier>(
          builder: (ctx, auth, _) {
            if (auth.currentUser != null) {
              return const ChatScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}