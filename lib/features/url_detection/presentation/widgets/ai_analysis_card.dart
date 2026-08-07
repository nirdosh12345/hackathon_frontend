import 'package:flutter/material.dart';

class AiAnalysisCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const AiAnalysisCard({
    super.key,
    required this.result,
  });

  Widget buildTile(
      IconData icon,
      String title,
      String value,
      {required MaterialColor iconColor}
      ) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      child: ListTile(
        leading: Icon(icon, color: iconColor,),
        title: Text(title, style: TextStyle(color: Colors.black87),),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
              color: Colors.black54
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final analysis =
        result["analysis"] as Map<String, dynamic>? ?? {};

    final ml =
        analysis["ml_probability"] ?? 0;

    final rule =
        analysis["rule_score"] ?? 0;

    final safeBrowsing =
        analysis["google_safe_browsing"] ?? "-";

    final domainAge =
        analysis["domain_age"]?.toString() ?? "-";

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
              children: [
                Icon(
                  Icons.psychology,
                  color: Colors.deepPurple,
                ),

                const SizedBox(width: 10),

                const Text(
                  "AI Analysis",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.memory,
              "ML Probability",
              "$ml %",
              iconColor: Colors.green,
            ),

            buildTile(
              Icons.rule,
              "Rule Score",
              "$rule / 100",
              iconColor: Colors.blue
            ),

            buildTile(
              Icons.security,
              "Google Safe Browsing",
              safeBrowsing.toString(),
                iconColor: Colors.blue
            ),

            buildTile(
              Icons.calendar_today,
              "Domain Age",
              domainAge,
                iconColor: Colors.blue
            ),
          ],
        ),
      ),
    );
  }
}