import 'dart:io';

import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  final void Function()? onTap;
  final File? image;
  const AddImage({
    this.image,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: image != null
              ? DecorationImage(
                  image: FileImage(image!),
                  fit: BoxFit.cover,
                )
              : null,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: image == null
            ? const Icon(
                Icons.camera_alt_outlined,
                size: 50,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }
}
