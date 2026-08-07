import 'package:flutter/material.dart';

class ImageTextCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImageTextCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final ocr = result["ocr"] ?? {};

    final String text =
        ocr["text"]?.toString() ?? "No text detected";

    final List keywords =
        ocr["keywords"] ?? [];

    final confidence =
        ocr["confidence"] ?? "-";

    final scamScore =
        ocr["scam_score"] ?? "-";

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
                  Icons.text_fields,
                  color: Colors.orange,
                ),

                SizedBox(width: 10),

                Text(
                  "OCR & Text Analysis",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Extracted Text",
              style: TextStyle(
                color: Colors.white70,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(
                Icons.analytics,
                color: Colors.cyan,
              ),
              title:
              const Text(
                "OCR Confidence",
                style: TextStyle(
                  color:
                  Colors.white70,
                ),
              ),
              trailing: Text(
                "$confidence %",
                style:
                const TextStyle(
                  color:
                  Colors.white,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              title:
              const Text(
                "Scam Score",
                style: TextStyle(
                  color:
                  Colors.white70,
                ),
              ),
              trailing: Text(
                scamScore.toString(),
                style:
                const TextStyle(
                  color:
                  Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Detected Keywords",
              style: TextStyle(
                color: Colors.white70,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
              keywords.isEmpty

                  ? [
                const Chip(
                  label: Text(
                      "None"),
                )
              ]

                  : keywords
                  .map(
                    (e) => Chip(
                  backgroundColor:
                  Colors
                      .red,
                  label: Text(
                    e.toString(),
                    style:
                    const TextStyle(
                      color: Colors
                          .white,
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}