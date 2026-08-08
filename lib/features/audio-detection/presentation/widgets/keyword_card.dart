import 'package:flutter/material.dart';

class KeywordCard extends StatelessWidget {
  final List<dynamic> keywords;

  const KeywordCard({super.key, required this.keywords});

  Color _severityColor(String severity, String type) {
    switch (severity.toLowerCase()) {
      case "critical":
        return (type == 'chip') ? Colors.red : Colors.red.shade100;

      case "high":
        return (type == 'chip') ? Colors.orange : Colors.orange.shade100;

      case "medium":
        return (type == 'chip') ? Colors.amber : Colors.amber.shade100;

      case "low":
        return (type == 'chip') ? Colors.green : Colors.green.shade100;

      default:
        return Colors.grey;
    }
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
                Icon(Icons.key, color: Colors.orange),

                SizedBox(width: 10),

                Text(
                  "Detected Keywords",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (keywords.isEmpty)
              const Center(child: Text("No suspicious keywords detected."))
            else
              ...keywords.map((item) {
                final keyword = item["keyword"] ?? "";

                final category = item["category"] ?? "";

                final severity = item["severity"] ?? "Low";

                final score = item["score"] ?? 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),

                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),

                    color: _severityColor(severity, 'box'),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              keyword,

                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Chip(
                            backgroundColor: _severityColor(severity, 'chip'),

                            label: Text(
                              severity,

                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.category, size: 18),

                          const SizedBox(width: 6),

                          Text(category),

                          const Spacer(),

                          Text(
                            "Score : $score",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
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
