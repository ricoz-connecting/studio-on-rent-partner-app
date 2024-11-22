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

class MultipleImagesDisplay extends StatelessWidget {
  final List<dynamic> imageFiles;

  const MultipleImagesDisplay({super.key, required this.imageFiles});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: imageFiles is List<File>
          ? imageFiles.map((file) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                  height: 100, // Adjust height as needed
                  width: 100, // Adjust width as needed
                ),
              );
            }).toList()
          : imageFiles.map((url) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  height: 100, // Adjust height as needed
                  width: 100, // Adjust width as needed
                ),
              );
            }).toList(),
    );
  }
}
