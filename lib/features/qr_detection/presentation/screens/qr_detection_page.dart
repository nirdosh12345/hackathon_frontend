
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../url_detection/presentation/widgets/ai_analysis_card.dart';
import '../../../url_detection/presentation/widgets/detection_pipeline_card.dart';
import '../../../url_detection/presentation/widgets/domain_information_card.dart';
import '../../../url_detection/presentation/widgets/risk_gauge.dart';
import '../../../url_detection/presentation/widgets/security_recommendation_card.dart';
import '../../../url_detection/presentation/widgets/security_summary_card.dart';
import '../../../url_detection/presentation/widgets/threat_details_card.dart';
import '../providers/qr_detection_provider.dart';
import '../widgets/google_safe_browsing_card.dart';
import '../widgets/url_features_card.dart';

class QrDetectionPage extends StatefulWidget {
  const QrDetectionPage({super.key});

  @override
  State<QrDetectionPage> createState() => _QrDetectionPageState();
}

class _QrDetectionPageState extends State<QrDetectionPage> {
  XFile? selectedImage;

  Uint8List? imageBytes;

  final ImagePicker picker = ImagePicker();

  Future<void> pickFromGallery() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    selectedImage = image;

    if (kIsWeb) {
      imageBytes = await image.readAsBytes();
    }

    setState(() {});
  }

  Future<void> pickFromCamera() async {
    final image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) return;

    selectedImage = image;

    if (kIsWeb) {
      imageBytes = await image.readAsBytes();
    }

    setState(() {});
  }

  Future<void> analyzeQR() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select an image first",
          ),
        ),
      );

      return;
    }

    await context.read<QrDetectionProvider>().scanQr(
      selectedImage!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QrDetectionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Detection"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Image Preview
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: selectedImage == null
                  ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.qr_code,
                      size: 80,
                    ),
                    SizedBox(height: 10),
                    Text("No Image Selected"),
                  ],
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: kIsWeb
                    ? Image.memory(
                  imageBytes!,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  selectedImage!.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text("Choose From Gallery"),
                onPressed: pickFromGallery,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture Image"),
                onPressed: pickFromCamera,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.security),
                label: const Text("Analyze QR"),
                onPressed: provider.isLoading
                    ? null
                    : analyzeQR,
              ),
            ),

            const SizedBox(height: 30),

            if (provider.isLoading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text("Analyzing QR..."),
                ],
              ),

            if (provider.error != null)
              Card(
                color: Colors.red.shade50,
                child: ListTile(
                  leading: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  title: Text(provider.error!, style: TextStyle(color: Colors.blue),),
                ),
              ),

            if (provider.result != null) ...[

              const SizedBox(height: 20),

              SecuritySummaryCard(
                result: provider.result!,
              ),

              const SizedBox(height: 20),

              RiskGauge(
                riskScore: provider.result!["risk_score"] ?? 0,
              ),

              const SizedBox(height: 20),

              AiAnalysisCard(
                result: provider.result!,
              ),

              const SizedBox(height: 20),

              DomainInfoCard(
                result: provider.result!,
              ),


              const SizedBox(height: 20),

              GoogleSafeBrowsingCard(
                result: provider.result!,
              ),

              const SizedBox(height: 20),

              UrlFeaturesCard(
                result: provider.result!,
              ),

              const SizedBox(height: 20),

              ThreatDetailsCard(
                result: provider.result!,
              ),

              const SizedBox(height: 20),

              SecurityRecommendationCard(
                result: provider.result!,
              ),

              const SizedBox(height: 20),

              DetectionPipelineCard(
                result: provider.result!,
              ),

              const SizedBox(height: 30),

            ]
          ],
        ),
      ),
    );
  }
}