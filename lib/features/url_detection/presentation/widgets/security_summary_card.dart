import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecuritySummaryCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const SecuritySummaryCard({
    super.key,
    required this.result,
  });

  Color _predictionColor(String prediction) {
    switch (prediction.toLowerCase()) {
      case "safe":
        return Colors.green;

      case "low risk":
        return Colors.orange;

      case "suspicious":
        return Colors.deepOrange;

      case "phishing":
        return Colors.red;

      default:
        return Colors.blueGrey;
    }
  }

  IconData _predictionIcon(String prediction) {
    switch (prediction.toLowerCase()) {
      case "safe":
        return Icons.verified;

      case "low risk":
        return Icons.info;

      case "suspicious":
        return Icons.warning_amber_rounded;

      case "phishing":
        return Icons.dangerous;

      default:
        return Icons.help;
    }
  }

  Widget buildTile(
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      elevation: 0,
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey,),
        title: Text(title, style: TextStyle(color: Colors.blueGrey),),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prediction = result["prediction"] ?? "Unknown";
    final severity = result["severity"] ?? "-";
    final riskScore = result["risk_score"].toString();
    final trustScore = result["trust_score"].toString();
    final confidence =
    ((result["confidence"] ?? 0) * 100)
        .toStringAsFixed(1);

    final source = result["source"] ?? "-";

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
                  Icons.security,
                  color: Colors.blue.shade700,
                  size: 30,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Security Report",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            const SizedBox(height: 25),

            Container(
              padding:
              const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: _predictionColor(
                    prediction)
                    .withOpacity(.12),

                borderRadius:
                BorderRadius.circular(15),
              ),

              child: Row(
                children: [

                  Icon(
                    _predictionIcon(
                        prediction),
                    color: _predictionColor(
                        prediction),
                    size: 45,
                  ),

                  const SizedBox(width: 20),

                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [

                      const Text(
                        "Prediction",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        prediction,
                        style: TextStyle(
                          color:
                          _predictionColor(
                              prediction),
                          fontSize: 24,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            buildTile(
              "Risk Score",
              "$riskScore / 100",
              Icons.speed,
            ),

            buildTile(
              "Trust Score",
              "$trustScore / 100",
              Icons.verified_user,
            ),

            buildTile(
              "Severity",
              severity,
              Icons.priority_high,
            ),

            buildTile(
              "Confidence",
              "$confidence %",
              Icons.analytics,
            ),

            buildTile(
              "Detection Source",
              source,
              Icons.memory,
            ),
          ],
        ),
      ),
    );
  }
}