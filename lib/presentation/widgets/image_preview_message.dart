import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreviewMessage extends StatelessWidget {
  final File? pickedImageFile;

  const ImagePreviewMessage({Key? key, this.pickedImageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      pickedImageFile!,
      fit: BoxFit.cover,
    );
  }
}
