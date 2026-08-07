import 'package:flutter/material.dart';

class EmailInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const EmailInfoCard({
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
          color: Colors.red,
        ),
        title: Text(title),
        trailing: SizedBox(
          width: 180,
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String getProvider(String email) {
    if (!email.contains("@")) return "-";

    final domain = email.split("@")[1].toLowerCase();

    switch (domain) {
      case "gmail.com":
        return "Google Gmail";

      case "outlook.com":
      case "hotmail.com":
      case "live.com":
        return "Microsoft Outlook";

      case "yahoo.com":
        return "Yahoo Mail";

      case "icloud.com":
        return "Apple iCloud";

      case "proton.me":
      case "protonmail.com":
        return "Proton Mail";

      default:
        return "Custom Domain";
    }
  }

  @override
  Widget build(BuildContext context) {
    final email =
        analysis["email"]?.toString() ?? "";

    final domain =
        analysis["domain"]?.toString() ?? "";

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
                  Icons.email,
                  color: Colors.red,
                ),

                SizedBox(width: 10),

                Text(
                  "Email Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.alternate_email,
              "Email",
              email,
            ),

            buildTile(
              Icons.language,
              "Domain",
              domain,
            ),

            buildTile(
              Icons.business,
              "Provider",
              getProvider(email),
            ),

            buildTile(
              Icons.subject,
              "Subject",
              analysis["subject"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.message,
              "Body",
              analysis["body"]?.toString() ?? "-",
            ),

          ],
        ),
      ),
    );
  }
}