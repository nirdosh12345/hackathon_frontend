import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../widgets/analysis_dialog.dart';
import 'image_result_page.dart';

class ImageDetectionPage extends StatefulWidget {
  const ImageDetectionPage({super.key});

  @override
  State<ImageDetectionPage> createState() =>
      _ImageDetectionPageState();
}

class _ImageDetectionPageState
    extends State<ImageDetectionPage> {

  File? _image;

  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;

  Future<void> pickFromGallery() async {

    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (file == null) return;

    setState(() {
      _image = File(file.path);
    });
  }

  Future<void> pickFromCamera() async {

    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (file == null) return;

    setState(() {
      _image = File(file.path);
    });
  }

  Future<void> analyzeImage() async {

    if (_image == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an image first."),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const AnalysisDialog(),
      );
      var request = http.MultipartRequest(

        "POST",

        Uri.parse("http://127.0.0.1:8000/predict_image"),

      );

      request.files.add(

        await http.MultipartFile.fromPath(

          "file",

          _image!.path,

        ),

      );

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(
        streamedResponse,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {

        final Map<String, dynamic> result =
        jsonDecode(response.body);

        if (!mounted) return;
        Navigator.pop(context);

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) => ImageResultPage(

              image: _image!,

              result: result,

            ),

          ),

        );

      } else {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content: Text(
              "Server Error : ${response.statusCode}",
            ),

          ),

        );

      }

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(
            "Error : $e",
          ),

        ),

      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Image Detection"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              height: 280,

              width: double.infinity,

              decoration: BoxDecoration(

                color: Colors.grey.shade200,

                borderRadius:
                BorderRadius.circular(20),

              ),

              child: _image == null

                  ? const Column(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.image,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "No Image Selected",
                  ),
                ],
              )

                  : ClipRRect(

                borderRadius:
                BorderRadius.circular(20),

                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.photo),

                label: const Text(
                  "Select Image",
                ),

                onPressed: pickFromGallery,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.camera),

                label: const Text(
                  "Capture Image",
                ),

                onPressed: pickFromCamera,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: FilledButton.icon(

                icon: const Icon(Icons.security),

                label: const Text(
                  "Analyze Image",
                ),

                onPressed: analyzeImage,
              ),
            ),

            if (isLoading) ...[

              const SizedBox(height: 30),

              const CircularProgressIndicator(),

              const SizedBox(height: 15),

              const Text(
                "Analyzing image...",
              ),
            ],
          ],
        ),
      ),
    );
  }
}