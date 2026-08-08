import 'package:flutter/material.dart';

class UrlFeaturesCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const UrlFeaturesCard({super.key, required this.result});

  Widget buildTile(IconData icon, String title, dynamic value) {
    return Card(
      elevation: 0,
      color: Colors.deepPurple.shade200.withOpacity(0.1),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(title, style: TextStyle(color: Colors.white70)),
        trailing: Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final analysis = result["analysis"] as Map<String, dynamic>? ?? {};

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: Colors.indigo),

                const SizedBox(width: 10),

                const Text(
                  "URL Features",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            buildTile(Icons.link, "Domain", analysis["domain"] ?? "-"),

            buildTile(
              Icons.straighten,
              "URL Length",
              analysis["url_length"] ?? "-",
            ),

            buildTile(
              Icons.domain,
              "Domain Length",
              analysis["domain_length"] ?? "-",
            ),

            buildTile(
              Icons.account_tree,
              "Subdomains",
              analysis["subdomain_count"] ?? "-",
            ),

            buildTile(
              Icons.lock,
              "HTTPS",
              (analysis["https"] ?? false) ? "Enabled" : "Disabled",
            ),

            buildTile(
              Icons.public,
              "Contains IP",
              (analysis["contains_ip"] ?? false) ? "Yes" : "No",
            ),

            buildTile(
              Icons.shortcut,
              "URL Shortener",
              (analysis["shortener"] ?? false) ? "Yes" : "No",
            ),

            buildTile(Icons.tag, "Hyphens", analysis["hyphen_count"] ?? "-"),

            buildTile(Icons.pin, "Digits", analysis["digit_count"] ?? "-"),

            buildTile(
              Icons.warning_amber,
              "Suspicious Keywords",
              analysis["keyword_count"] ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}
