import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

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
        height: MediaQuery.of(context).size.width * 0.6,
        width: MediaQuery.of(context).size.width,
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
  final Function(int, bool)? onRemove;

  const MultipleImagesDisplay(
      {super.key, this.imageFiles, this.imageUrls, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        if (imageFiles != null)
          ...imageFiles!.asMap().entries.map((entry) {
            int index = entry.key;
            File file = entry.value;
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * 0.32,
                    width: MediaQuery.of(context).size.width * 0.29,
                  ),
                ),
                if (onRemove != null)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => onRemove!(index, true),
                      child: const Icon(Icons.cancel, color: Colors.red),
                    ),
                  ),
              ],
            );
          }).toList(),
        if (imageUrls != null)
          ...imageUrls!.asMap().entries.map((entry) {
            int index = entry.key;
            String url = entry.value;
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * 0.32,
                    width: MediaQuery.of(context).size.width * 0.29,
                  ),
                ),
                if (onRemove != null)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => onRemove!(index, true),
                      child: const Icon(Icons.cancel, color: Colors.red),
                    ),
                  ),
              ],
            );
          }).toList(),
      ],
    );
  }
}

class MultipleVideosDisplay extends StatelessWidget {
  final List<File>? videoFiles;
  final List<String>? videoUrls;
  final Function(int, bool)? onRemove;

  const MultipleVideosDisplay({
    Key? key,
    this.videoFiles,
    this.videoUrls,
    this.onRemove,
  }) : super(key: key);

  Future<Uint8List?> _generateFileThumbnail(File file) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      debugPrint("Thumbnail generation not supported on this platform.");
      return null;
    }
    try {
      return await VideoThumbnail.thumbnailData(
        video: file.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 50,
      );
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return null;
    }
  }

  Future<String?> _generateUrlThumbnail(String url) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      debugPrint("Thumbnail generation not supported on this platform.");
      return null;
    }
    try {
      final tempDir = await getTemporaryDirectory();
      final XFile? thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: url,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.WEBP,
        maxHeight: 100,
        quality: 75,
      );
      if (thumbnailPath != null && File(thumbnailPath.path).existsSync()) {
        return thumbnailPath.path;
      } else {
        debugPrint('Thumbnail generation failed');
        return null;
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (videoFiles == null || videoFiles!.isEmpty) &&
            (videoUrls == null || videoUrls!.isEmpty)
        ? const Center(child: Text('No videos to display'))
        : Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              if (videoFiles != null)
                ...videoFiles!.asMap().entries.map((entry) {
                  int index = entry.key;
                  File file = entry.value;
                  return FutureBuilder<Uint8List?>(
                    future: _generateFileThumbnail(file),
                    builder: (context, snapshot) {
                      Widget child;
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        child = Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width * 0.32,
                          width: MediaQuery.of(context).size.width * 0.29,
                        );
                      } else {
                        child = Container(
                          height: MediaQuery.of(context).size.width * 0.32,
                          width: MediaQuery.of(context).size.width * 0.29,
                          color: Colors.black12,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: child,
                          ),
                          if (onRemove != null)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () => onRemove!(index, true),
                                child:
                                    const Icon(Icons.cancel, color: Colors.red),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                }).toList(),
              if (videoUrls != null)
                ...videoUrls!.asMap().entries.map((entry) {
                  int index = entry.key;
                  String url = entry.value;
                  return FutureBuilder<String?>(
                    future: _generateUrlThumbnail(url),
                    builder: (context, snapshot) {
                      Widget child;
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data != null) {
                        child = kIsWeb
                            ? Image.network(
                                url,
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.width * 0.32,
                                width: MediaQuery.of(context).size.width * 0.29,
                              )
                            : Image.file(
                                File(snapshot.data!),
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.width * 0.32,
                                width: MediaQuery.of(context).size.width * 0.29,
                              );
                      } else {
                        child = Container(
                          height: MediaQuery.of(context).size.width * 0.32,
                          width: MediaQuery.of(context).size.width * 0.29,
                          color: Colors.black12,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: child,
                          ),
                          if (onRemove != null)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () => onRemove!(index, false),
                                child:
                                    const Icon(Icons.cancel, color: Colors.red),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                }).toList(),
            ],
          );
  }
}
