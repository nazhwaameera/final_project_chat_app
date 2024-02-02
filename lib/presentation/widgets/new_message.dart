//new_message
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'image_preview_message.dart';


class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  File? _selectedImage;
  String? imageUrl;
  bool sendImage = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
      print('Picked Image File $_selectedImage');
    });

     AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedImage != null)
            ImagePreviewMessage(pickedImageFile: _selectedImage),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.send),
            onPressed: () {
              _submitMessage;
              Navigator.pop(context); // Close the dialog after submitting
            },
          ),
        ],
      ),
    );
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty && _selectedImage == null) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if(_selectedImage != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('user.uid.jpg');

      await storageRef.putFile(_selectedImage!);
      final Url = await storageRef.getDownloadURL();

      setState(() {
        imageUrl = Url;
      });
    }


    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage ?? '',
      'imageMessage': imageUrl ?? '',
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });

    print('Kekirim');

    setState(() {
      imageUrl = '';
      _selectedImage = null;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(
                Icons.image,
              ),
              onPressed: _pickImage,
            ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.send,
            ),
            onPressed: _submitMessage,
          ),
        ],
      ),
    );
  }
}