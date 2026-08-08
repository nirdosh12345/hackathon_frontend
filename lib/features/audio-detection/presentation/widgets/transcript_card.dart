import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TranscriptCard extends StatelessWidget {
  final String transcript;

  const TranscriptCard({super.key, required this.transcript});

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
            Row(
              children: [
                const Icon(Icons.article_outlined, color: Colors.blue),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "Transcript",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  tooltip: "Copy",
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: transcript));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Transcript copied")),
                    );
                  },
                ),
              ],
            ),

            const Divider(),

            const SizedBox(height: 10),

            SelectableText(
              transcript.isEmpty ? "No transcript available." : transcript,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
