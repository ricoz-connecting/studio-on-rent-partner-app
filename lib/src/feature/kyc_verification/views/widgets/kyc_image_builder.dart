import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KYCImageBuilder extends StatelessWidget {
  const KYCImageBuilder(
      {super.key,
      this.src,
      this.fit,
      this.width,
      this.height,
      this.file,
      this.icon});

  final String? src;
  final File? file;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      if (_isSvg(file!.path)) {
        return _buildContainer(
          child: SvgPicture.file(file!,
              width: width, height: height, fit: fit ?? BoxFit.cover),
        );
      }
      return _buildContainer(
        child: Image.file(
          file!,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => defaultImage(),
        ),
      );
    }

    if (src != null) {
      if (_isSvg(src!)) {
        return _buildContainer(
          child: SvgPicture.network(
            src!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        );
      }

      return _buildContainer(
        child: Image.network(
          src!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => defaultImage(),
        ),
      );
    }

    return defaultImage();
  }

  Widget defaultImage() {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 40,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  bool _isSvg(String imageUrl) {
    Uri uri = Uri.parse(imageUrl);
    List<String> pathSegments = uri.pathSegments;
    if (pathSegments.isEmpty) {
      // No path segments found
    }

    String lastPathSegment = pathSegments.last;
    int dotIndex = lastPathSegment.lastIndexOf('.');
    if (dotIndex != -1) {
      return lastPathSegment.substring(dotIndex + 1) == 'svg';
    }
    return false;
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: child,
      ),
    );
  }
}
