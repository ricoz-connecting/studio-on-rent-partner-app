import 'dart:io';
import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  final void Function()? onTap;
  final String? imageUrl;
  final File? image;
  const AddImage({
    this.imageUrl,
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
          image: imageUrl != null && image == null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                )
              : image != null
                  ? DecorationImage(
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                    )
                  : null,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: image == null && imageUrl == null
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
  final List<File>? imageFiles;
  final List<String>? imageUrls;
  const MultipleImagesDisplay({super.key, this.imageFiles, this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: imageUrls != null && imageFiles != null
          ? [
              ...imageFiles!.map((file) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                    height: 100, // Adjust height as needed
                    width: 100, // Adjust width as needed
                  ),
                );
              }),
              ...imageUrls!.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: 100, // Adjust height as needed
                    width: 100, // Adjust width as needed
                  ),
                );
              }),
            ]
          : imageUrls == null
              ? imageFiles!.map((file) {
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
              : imageUrls!.map((url) {
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
