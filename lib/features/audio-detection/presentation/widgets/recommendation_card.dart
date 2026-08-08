import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final List<dynamic> reasons;

  const RecommendationCard({super.key, required this.reasons});

  List<String> _recommendations() {
    return [
      "Do not share OTP, PIN, passwords or bank details with anyone.",
      "Verify any request through the official website or mobile application.",
      "Avoid clicking links received through unknown calls, SMS or emails.",
      "Never install unknown applications suggested during phone calls.",
      "If someone pressures you to act immediately, stop and verify first.",
      "Contact your bank directly if the conversation involves your account.",
      "Report suspicious calls or messages to the National Cyber Crime Portal.",
      "Block the sender if the communication is confirmed to be fraudulent.",
    ];
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
                Icon(Icons.shield, color: Colors.green),

                SizedBox(width: 10),

                Text(
                  "Security Recommendations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (reasons.isNotEmpty) ...[
              const Text(
                "Why was this flagged?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              ...reasons.map(
                (reason) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.warning, color: Colors.red, size: 20),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          reason.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(height: 35),
            ],

            const Text(
              "Recommended Actions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ..._recommendations().map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        tip,
                        style: const TextStyle(fontSize: 15, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
