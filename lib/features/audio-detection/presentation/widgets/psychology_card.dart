import 'package:flutter/material.dart';

class PsychologyCard extends StatelessWidget {
  final Map<String, dynamic> psychology;

  const PsychologyCard({super.key, required this.psychology});

  Color _scoreColor(int score) {
    if (score >= 80) {
      return Colors.red;
    } else if (score >= 60) {
      return Colors.orange;
    } else if (score >= 40) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  Widget _buildSection(String title, Map<String, dynamic>? data) {
    if (data == null) return const SizedBox();

    final int score = data["score"] ?? 0;
    final List matched = data["matched"] ?? [];

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
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              Chip(
                backgroundColor: _scoreColor(score),
                label: Text(
                  "$score",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          LinearProgressIndicator(
            value: score / 100,
            minHeight: 8,
            borderRadius: BorderRadius.circular(20),
            color: _scoreColor(score),
            backgroundColor: Colors.grey.shade300,
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: matched.map((e) {
              return Chip(
                avatar: const Icon(
                  Icons.warning,
                  size: 18,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red.shade400,
                label: Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int psychologyScore = psychology["psychology_score"] ?? 0;

    final List reasons = psychology["reasons"] ?? [];

    final Map<String, dynamic> analysis = psychology["analysis"] ?? {};

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
                Icon(Icons.psychology, color: Colors.purple),

                SizedBox(width: 10),

                Text(
                  "Psychological Analysis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Psychology Score : $psychologyScore / 100",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: psychologyScore / 100,
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
              color: _scoreColor(psychologyScore),
              backgroundColor: Colors.grey.shade300,
            ),

            const SizedBox(height: 25),

            _buildSection("Urgency", analysis["urgency"]),

            _buildSection("Threat", analysis["threat"]),

            _buildSection("Authority", analysis["authority"]),

            _buildSection("Credential Request", analysis["credential_request"]),

            _buildSection("Financial Request", analysis["financial_request"]),

            _buildSection("Reward / Lottery", analysis["reward"]),

            if (reasons.isNotEmpty) ...[
              const SizedBox(height: 15),

              const Divider(),

              const SizedBox(height: 10),

              const Text(
                "Reasons",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...reasons.map(
                (reason) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.check_circle, color: Colors.red),
                  title: Text(reason.toString()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
