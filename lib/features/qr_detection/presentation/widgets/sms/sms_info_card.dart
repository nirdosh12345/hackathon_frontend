import 'package:flutter/material.dart';

class SMSInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const SMSInfoCard({
    super.key,
    required this.analysis,
  });

  Widget buildTile(
      IconData icon,
      String title,
      Widget child,
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
          color: Colors.orange,
        ),
        title: Text(title),
        subtitle: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone =
        analysis["phone_number"]?.toString() ?? "-";

    final message =
        analysis["message"]?.toString() ?? "-";

    final containsUrl =
        analysis["contains_url"] ?? false;

    final keywords =
        (analysis["detected_keywords"] as List?) ?? [];

    final messageLength =
        analysis["message_length"] ?? 0;

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
                  Icons.sms,
                  color: Colors.orange,
                ),

                SizedBox(width: 10),

                Text(
                  "SMS Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.phone,
              "Receiver Number",
              Text(phone),
            ),

            buildTile(
              Icons.message,
              "Message",
              Text(message),
            ),

            buildTile(
              Icons.link,
              "Contains URL",
              Text(
                containsUrl ? "Yes" : "No",
                style: TextStyle(
                  color: containsUrl
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            buildTile(
              Icons.straighten,
              "Message Length",
              Text("$messageLength Characters"),
            ),

            Card(
              elevation: 0,
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Detected Keywords",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                      ],
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
                            avatar: const Icon(
                              Icons.warning,
                              size: 16,
                              color: Colors.white,
                            ),
                            backgroundColor:
                            Colors.red,
                            label: Text(
                              e.toString(),
                              style: const TextStyle(
                                color:
                                Colors.white,
                              ),
                            ),
                          );

                        }).toList(),
                      ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}