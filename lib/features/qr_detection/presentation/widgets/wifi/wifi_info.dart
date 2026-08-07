import 'package:flutter/material.dart';

class WifiInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const WifiInfoCard({
    super.key,
    required this.analysis,
  });

  Widget buildTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: const [

                Icon(
                  Icons.wifi,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "WiFi Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.wifi,
              "SSID",
              analysis["ssid"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.security,
              "Encryption",
              analysis["encryption"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.visibility,
              "Hidden Network",
              (analysis["hidden"] ?? false)
                  ? "Yes"
                  : "No",
            ),

            buildTile(
              Icons.lock,
              "Password Length",
              "${analysis["password_length"] ?? 0}",
            ),

            buildTile(
              Icons.shield,
              "Security",
              (() {
                final enc = (analysis["encryption"] ?? "")
                    .toString()
                    .toUpperCase();

                if (enc == "WPA3") {
                  return "Excellent";
                }

                if (enc == "WPA2") {
                  return "Good";
                }

                if (enc == "WPA") {
                  return "Average";
                }

                if (enc == "WEP") {
                  return "Weak";
                }

                if (enc == "NOPASS") {
                  return "Open Network";
                }

                return "-";
              })(),
            ),

          ],
        ),
      ),
    );
  }
}