import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/foundation.dart'; // Import 'kDebugMode'

class PdfScreen extends StatefulWidget {
  final File file;

  const PdfScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  void initState() {
    super.initState();

    // Lock the orientation to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Revert back to the original preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: [
                PDFView(
                  pageSnap: false,
                  pageFling: false,
                  enableSwipe: true,
                  autoSpacing: false,
                  fitPolicy: FitPolicy.BOTH,
                  filePath: widget.file.path,
                ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/nextrev.png',
                            height: 30,
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}