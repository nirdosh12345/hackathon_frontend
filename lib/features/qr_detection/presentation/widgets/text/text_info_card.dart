import 'package:flutter/material.dart';

class TextInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const TextInfoCard({
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
          color: Colors.teal,
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

  @override
  Widget build(BuildContext context) {

    final keywords =
        (analysis["detected_keywords"] as List?) ?? [];

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

            const Row(
              children: [

                Icon(
                  Icons.description,
                  color: Colors.teal,
                ),

                SizedBox(width: 10),

                Text(
                  "Text Analysis",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.text_fields,
              "Characters",
              "${analysis["length"] ?? 0}",
            ),

            buildTile(
              Icons.format_list_numbered,
              "Words",
              "${analysis["word_count"] ?? 0}",
            ),

            buildTile(
              Icons.link,
              "Contains URL",
              (analysis["contains_url"] ?? false)
                  ? "Yes"
                  : "No",
            ),

            buildTile(
              Icons.email,
              "Contains Email",
              (analysis["contains_email"] ?? false)
                  ? "Yes"
                  : "No",
            ),

            buildTile(
              Icons.phone,
              "Contains Phone",
              (analysis["contains_phone"] ?? false)
                  ? "Yes"
                  : "No",
            ),

            const SizedBox(height: 15),

            const Text(
              "Detected Keywords",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            if (keywords.isEmpty)

              const Text(
                "No suspicious keywords detected.",
              )

            else

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: keywords.map<Widget>((e) {

                  return Chip(
                    backgroundColor: Colors.red,
                    avatar: const Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: 16,
                    ),
                    label: Text(
                      e.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );

                }).toList(),
              ),

          ],
        ),
      ),
    );
  }
}