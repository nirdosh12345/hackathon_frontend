import 'package:flutter/material.dart';

class ImageLogoCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImageLogoCard({
    super.key,
    required this.result,
  });

  Widget buildTile(
      IconData icon,
      String title,
      dynamic value,
      ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.amber,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final logo = result["logo"] ?? {};

    return Card(
      color: const Color(0xff1E293B),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Row(
              children: [

                Icon(
                  Icons.copyright,
                  color: Colors.amber,
                ),

                SizedBox(width: 10),

                Text(
                  "Logo Detection",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            buildTile(
              Icons.business,
              "Brand",
              logo["brand"] ?? "Unknown",
            ),

            buildTile(
              Icons.percent,
              "Confidence",
              logo["confidence"] ?? "-",
            ),

            buildTile(
              Icons.verified,
              "Trusted Brand",
              logo["trusted"] == true
                  ? "Yes"
                  : "No",
            ),

            buildTile(
              Icons.warning,
              "Counterfeit Risk",
              logo["counterfeit"] ?? "Low",
            ),

            buildTile(
              Icons.compare,
              "Similar Brand",
              logo["similar"] ?? "None",
            ),

            buildTile(
              Icons.public,
              "Official Website",
              logo["official"] ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}