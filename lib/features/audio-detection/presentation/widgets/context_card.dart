import 'package:flutter/material.dart';

class ContextCard extends StatelessWidget {
  final List<dynamic> contexts;

  const ContextCard({super.key, required this.contexts});

  Color _confidenceColor(double confidence) {
    if (confidence >= 0.85) {
      return Colors.red;
    }

    if (confidence >= 0.70) {
      return Colors.orange;
    }

    if (confidence >= 0.50) {
      return Colors.amber;
    }

    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Colors.deepPurple),

                SizedBox(width: 10),

                Text(
                  "Context Analysis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (contexts.isEmpty)
              const Center(child: Text("No suspicious context detected."))
            else
              ...contexts.map((contextItem) {
                final label = contextItem["label"] ?? "Unknown";

                final confidence = (contextItem["confidence"] ?? 0.0)
                    .toDouble();

                final percentage = (confidence * 100).toStringAsFixed(1);

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              label,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),

                          Text(
                            "$percentage %",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      LinearProgressIndicator(
                        value: confidence,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(20),
                        color: _confidenceColor(confidence),
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
