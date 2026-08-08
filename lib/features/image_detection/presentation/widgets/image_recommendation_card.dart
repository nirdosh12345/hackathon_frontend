import 'package:flutter/material.dart';

class ImageRecommendationCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImageRecommendationCard({
    super.key,
    required this.result,
  });

  List<String> _recommendations(int riskScore) {
    if (riskScore <= 20) {
      return [
        "Image appears safe.",
        "Verify the sender if received from an unknown source.",
        "Open embedded links only if you trust the source."
      ];
    }

    if (riskScore <= 50) {
      return [
        "Be cautious before interacting with this image.",
        "Verify any website or QR code before opening.",
        "Avoid entering sensitive information."
      ];
    }

    if (riskScore <= 80) {
      return [
        "High probability of phishing content.",
        "Do not scan QR codes from this image.",
        "Do not click embedded links.",
        "Verify the organization independently."
      ];
    }

    return [
      "This image is highly suspicious.",
      "Do NOT scan any QR code.",
      "Do NOT click embedded URLs.",
      "Never share OTP, passwords or banking details.",
      "Report this image immediately if received through email or messaging apps."
    ];
  }

  Color _cardColor(int score) {
    if (score <= 20) return Colors.green;
    if (score <= 50) return Colors.orange;
    if (score <= 80) return Colors.deepOrange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final int riskScore = result["risk_score"] ?? 0;

    final recommendations = _recommendations(riskScore);

    return Card(
      color: const Color(0xff1E293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.security,
                  color: Colors.lightBlue,
                ),

                SizedBox(width: 10),

                Text(
                  "Security Recommendations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ...recommendations.map(

                  (e) => Card(

                color: Colors.black26,

                child: ListTile(

                  leading: Icon(
                    Icons.verified_user,
                    color: _cardColor(riskScore),
                  ),

                  title: Text(
                    e,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}