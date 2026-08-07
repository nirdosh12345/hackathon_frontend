import 'package:flutter/material.dart';

class GoogleSafeBrowsingCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const GoogleSafeBrowsingCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    final analysis = result["analysis"] ?? {};

    final status =
        analysis["google_safe_browsing"] ?? "Unknown";

    final safe =
        status.toString().toLowerCase() == "safe";

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
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
                  Icons.gpp_good,
                  color: Colors.green.shade700,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Google Safe Browsing",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                safe
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                child: Icon(
                  safe
                      ? Icons.verified
                      : Icons.warning,
                  color:
                  safe
                      ? Colors.green
                      : Colors.red,
                ),
              ),

              title: const Text(
                "Google Verdict",
              ),

              trailing: Text(
                status,
                style: TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  color:
                  safe
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}