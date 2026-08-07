import 'dart:io';

import 'package:flutter/material.dart';

import '../../../url_detection/presentation/widgets/risk_gauge.dart';
import '../../../url_detection/presentation/widgets/security_summary_card.dart';
import '../widgets/image_ai_analysis_card.dart';
import '../widgets/image_details_card.dart';
import '../widgets/image_logo_card.dart';
import '../widgets/image_metadata_card.dart';
import '../widgets/image_object_card.dart';
import '../widgets/image_phishing_card.dart';
import '../widgets/image_recommendation_card.dart';
import '../widgets/image_text_card.dart';

class ImageResultPage extends StatelessWidget {
  final File image;
  final Map<String, dynamic> result;

  const ImageResultPage({
    super.key,
    required this.image,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Analysis"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              /// Selected Image

              ClipRRect(
                borderRadius:
                BorderRadius.circular(20),

                child: Image.file(
                  image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              /// Prediction

              SecuritySummaryCard(
                result: result,
              ),

              const SizedBox(height: 20),

              /// Risk Meter

              RiskGauge(
                riskScore:
                result["risk_score"] ?? 0,
              ),

              const SizedBox(height: 20),

              ImageAIAnalysisCard(
                result: result,
              ),

              const SizedBox(height: 20),

              ImageLogoCard(
                result: result,
              ),

              const SizedBox(height: 20),

              ImageObjectCard(
                result: result,
              ),

              const SizedBox(height: 20),

              ImageTextCard(
                result: result,
              ),

              const SizedBox(height: 20),

              /// Metadata

              ImageMetadataCard(
                metadata:
                result["metadata"] ?? {},
              ),

              const SizedBox(height: 20),

              /// Remaining Cards

              ImageDetailsCards(
                result: result,
              ),

              const SizedBox(height: 20),

              ImagePhishingCard(
                result: result,
              ),


              const SizedBox(height: 20),

              ImageRecommendationCard(
                result: result,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}