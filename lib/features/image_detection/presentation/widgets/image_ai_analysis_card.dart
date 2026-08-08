import 'package:flutter/material.dart';

class ImageAIAnalysisCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImageAIAnalysisCard({
    super.key,
    required this.result,
  });

  Widget buildTile(
      IconData icon,
      String title,
      dynamic value,
      ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.cyan,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final analysis =
        result["analysis"] ?? {};

    return Card(
      color: const Color(0xff1E293B),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.psychology,
                  color: Colors.cyan,
                ),

                SizedBox(width: 10),

                Text(
                  "AI Analysis",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            buildTile(
              Icons.analytics,
              "Confidence",
              "${((result["confidence"] ?? 0) * 100).toStringAsFixed(1)} %",
            ),

            buildTile(
              Icons.smart_toy,
              "Prediction",
              result["prediction"] ?? "-",
            ),

            buildTile(
              Icons.speed,
              "Risk Score",
              result["risk_score"] ?? "-",
            ),

            buildTile(
              Icons.verified_user,
              "Trust Score",
              result["trust_score"] ?? "-",
            ),

            buildTile(
              Icons.security,
              "Severity",
              result["severity"] ?? "-",
            ),

            buildTile(
              Icons.memory,
              "Detection Source",
              result["source"] ?? "-",
            ),

            buildTile(
              Icons.text_fields,
              "OCR Confidence",
              analysis["ocr_confidence"] ?? "-",
            ),

            buildTile(
              Icons.copyright,
              "Logo Match",
              analysis["logo_match"] ?? "-",
            ),

            buildTile(
              Icons.image_search,
              "Objects",
              analysis["object_count"] ?? "-",
            ),

            buildTile(
              Icons.fingerprint,
              "Image Hash",
              analysis["image_hash"] ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}