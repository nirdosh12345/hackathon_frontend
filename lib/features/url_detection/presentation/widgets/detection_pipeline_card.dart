import 'package:flutter/material.dart';

class DetectionPipelineCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const DetectionPipelineCard({
    super.key,
    required this.result,
  });

  Widget buildStep({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 0,
      color: color.withOpacity(.08),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final analysis =
        result["analysis"] as Map<String, dynamic>? ?? {};

    final prediction =
        result["prediction"] ?? "Unknown";

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              children: const [

                Icon(
                  Icons.account_tree,
                  color: Colors.indigo,
                ),

                SizedBox(width: 10),

                Text(
                  "Detection Pipeline",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            buildStep(
              icon: Icons.link,
              color: Colors.blue,
              title: "URL Received",
              value: "✔",
            ),

            buildStep(
              icon: Icons.cleaning_services,
              color: Colors.green,
              title: "URL Normalization",
              value: "✔",
            ),

            buildStep(
              icon: Icons.verified_user,
              color: Colors.green,
              title: "Trusted Domain Check",
              value: analysis["trusted_domain"] == true
                  ? "Trusted"
                  : "Checked",
            ),

            buildStep(
              icon: Icons.rule,
              color: Colors.orange,
              title: "Rule Engine",
              value:
              "${analysis["rule_score"] ?? 0}/100",
            ),

            buildStep(
              icon: Icons.psychology,
              color: Colors.deepPurple,
              title: "Machine Learning",
              value:
              "${analysis["ml_probability"] ?? 0}",
            ),

            buildStep(
              icon: Icons.security,
              color: Colors.blue,
              title: "Google Safe Browsing",
              value:
              analysis["google_safe_browsing"]
                  .toString(),
            ),

            buildStep(
              icon: Icons.public,
              color: Colors.teal,
              title: "WHOIS Analysis",
              value:
              "${analysis["domain_age"] ?? "-"} Days",
            ),

            const Divider(height: 35),

            buildStep(
              icon: prediction == "Safe"
                  ? Icons.verified
                  : Icons.warning,
              color: prediction == "Safe"
                  ? Colors.green
                  : Colors.red,
              title: "Final Verdict",
              value: prediction,
            ),
          ],
        ),
      ),
    );
  }
}