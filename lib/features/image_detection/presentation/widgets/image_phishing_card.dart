import 'package:flutter/material.dart';

class ImagePhishingCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImagePhishingCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    final phishing =
        result["phishing"] ?? {};

    final List indicators =
        phishing["indicators"] ?? [];

    final score =
        phishing["score"] ?? 0;

    Color scoreColor;

    if (score >= 80) {
      scoreColor = Colors.red;
    } else if (score >= 50) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.green;
    }

    return Card(
      color: const Color(0xff1E293B),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.gpp_bad,
                  color: Colors.red,
                ),

                SizedBox(width: 10),

                Text(
                  "Phishing Indicators",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              title: const Text(
                "Phishing Score",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              trailing: Text(
                "$score %",
                style: TextStyle(
                  color: scoreColor,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const Divider(),

            if (indicators.isEmpty)

              const Padding(
                padding:
                EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "No phishing indicators detected.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              )

            else

              ...indicators.map(
                    (e) {

                  return ListTile(

                    leading: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),

                    title: Text(
                      e.toString(),
                      style:
                      const TextStyle(
                        color:
                        Colors.white,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}