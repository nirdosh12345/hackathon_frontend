import 'package:flutter/material.dart';

class ImageDetailsCards extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImageDetailsCards({
    super.key,
    required this.result,
  });

  Widget buildCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.cyan),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget tile(String title, dynamic value) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.arrow_right, color: Colors.greenAccent),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70),
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
    final metadata = result["metadata"] ?? {};
    final logos = result["logos"] ?? [];
    final objects = result["objects"] ?? [];
    final ocr = result["ocr"] ?? {};
    final recommendations = result["recommendations"] ?? [];
    final pipeline = result["pipeline"] ?? [];

    return Column(
      children: [

        /// Metadata
        buildCard(
          icon: Icons.info_outline,
          title: "Metadata",
          children: [
            tile("Width", metadata["width"] ?? "-"),
            tile("Height", metadata["height"] ?? "-"),
            tile("Format", metadata["format"] ?? "-"),
            tile("File Size", metadata["size"] ?? "-"),
          ],
        ),

        /// Logo Detection
        buildCard(
          icon: Icons.business,
          title: "Logo Detection",
          children: logos.isEmpty
              ? [tile("Detected Logos", "None")]
              : logos.map<Widget>((e) => tile("Logo", e)).toList(),
        ),

        /// Object Detection
        buildCard(
          icon: Icons.image_search,
          title: "Object Detection",
          children: objects.isEmpty
              ? [tile("Objects", "None")]
              : objects.map<Widget>((e) => tile("Object", e)).toList(),
        ),

        /// OCR
        buildCard(
          icon: Icons.text_fields,
          title: "OCR Analysis",
          children: [
            tile("Detected Text", ocr["text"] ?? "No Text"),
            tile("Confidence", ocr["confidence"] ?? "-"),
          ],
        ),

        /// Recommendations
        buildCard(
          icon: Icons.security,
          title: "Security Recommendations",
          children: recommendations.isEmpty
              ? [tile("Recommendation", "No recommendation")]
              : recommendations
              .map<Widget>((e) => tile("Recommendation", e))
              .toList(),
        ),

        /// Pipeline
        buildCard(
          icon: Icons.account_tree,
          title: "Detection Pipeline",
          children: pipeline.isEmpty
              ? [tile("Status", "Completed")]
              : pipeline.map<Widget>((e) => tile("Step", e)).toList(),
        ),
      ],
    );
  }
}