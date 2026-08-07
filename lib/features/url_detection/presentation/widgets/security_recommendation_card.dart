import 'package:flutter/material.dart';

class SecurityRecommendationCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const SecurityRecommendationCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    final prediction =
    (result["prediction"] ?? "Unknown").toString();

    final List<Map<String, dynamic>> recommendations = [];

    switch (prediction.toLowerCase()) {

      case "safe":

        recommendations.addAll([

          {
            "icon": Icons.verified,
            "color": Colors.green,
            "text": "This website appears to be safe."
          },

          {
            "icon": Icons.lock,
            "color": Colors.green,
            "text": "HTTPS connection detected."
          },

          {
            "icon": Icons.visibility,
            "color": Colors.blue,
            "text": "Always verify the URL before entering personal information."
          },

        ]);

        break;

      case "low risk":

        recommendations.addAll([

          {
            "icon": Icons.info,
            "color": Colors.orange,
            "text": "Proceed carefully."
          },

          {
            "icon": Icons.person_search,
            "color": Colors.orange,
            "text": "Verify the website owner before logging in."
          },

          {
            "icon": Icons.password,
            "color": Colors.red,
            "text": "Avoid entering passwords unless you trust the website."
          },

        ]);

        break;

      case "suspicious":

        recommendations.addAll([

          {
            "icon": Icons.warning,
            "color": Colors.deepOrange,
            "text": "The website shows suspicious characteristics."
          },

          {
            "icon": Icons.credit_card,
            "color": Colors.red,
            "text": "Do NOT enter banking or payment information."
          },

          {
            "icon": Icons.login,
            "color": Colors.red,
            "text": "Avoid logging into important accounts."
          },

          {
            "icon": Icons.search,
            "color": Colors.blue,
            "text": "Verify the website using official sources."
          },

        ]);

        break;

      default:

        recommendations.addAll([

          {
            "icon": Icons.dangerous,
            "color": Colors.red,
            "text": "High probability of phishing."
          },

          {
            "icon": Icons.block,
            "color": Colors.red,
            "text": "Do NOT open this website."
          },

          {
            "icon": Icons.password,
            "color": Colors.red,
            "text": "Never enter passwords or OTPs."
          },

          {
            "icon": Icons.account_balance,
            "color": Colors.red,
            "text": "Avoid banking or financial transactions."
          },

          {
            "icon": Icons.report,
            "color": Colors.orange,
            "text": "Report this website if you received it through email or SMS."
          },

        ]);
    }

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
                  Icons.health_and_safety,
                  color: Colors.green,
                ),

                SizedBox(width: 10),

                Text(
                  "Security Recommendations",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            ...recommendations.map(

                  (item) => Card(

                elevation: 0,

                color: (item["color"] as Color).withOpacity(.08),

                child: ListTile(

                  leading: Icon(
                    item["icon"],
                    color: item["color"],
                  ),

                  title: Text(
                    item["text"],
                  ),

                ),

              ),

            ),

          ],
        ),
      ),
    );
  }
}