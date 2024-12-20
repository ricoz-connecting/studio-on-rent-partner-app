import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatelessWidget {
  final String path;

  const PDFViewerScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Preview")),
      body: PDFView(
        filePath: path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onRender: (pages) {
          log("PDF Rendered with $pages pages.");
        },
        onError: (error) {
          log("Error rendering PDF: $error");
        },
        onPageError: (page, error) {
          log("Error on page $page: $error");
        },
      ),
    );
  }
}
