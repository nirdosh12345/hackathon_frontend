import 'package:flutter/material.dart';

class DomainInfoCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const DomainInfoCard({
    super.key,
    required this.result,
  });

  Widget buildTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      elevation: 0,
      color: Colors.blue.shade50,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent,),
        title: Text(title, style: TextStyle(color: Colors.black87),),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final analysis =
        result["analysis"] as Map<String, dynamic>? ?? {};

    final domain =
        analysis["domain"]?.toString() ?? "-";

    final registrar =
        analysis["registrar"]?.toString() ?? "-";

    final creationDate =
        analysis["creation_date"]?.toString() ?? "-";

    final age =
        analysis["domain_age"]?.toString() ?? "-";

    final https =
    analysis["https"] == true
        ? "Secure (HTTPS)"
        : "Not Secure";

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Icon(
                  Icons.language,
                  color: Colors.blue,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Domain Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.public,
              "Domain",
              domain,
            ),

            buildTile(
              Icons.business,
              "Registrar",
              registrar,
            ),

            buildTile(
              Icons.calendar_month,
              "Creation Date",
              creationDate,
            ),

            buildTile(
              Icons.timelapse,
              "Domain Age",
              age == "-"
                  ? "-"
                  : "$age Days",
            ),

            buildTile(
              Icons.lock,
              "HTTPS",
              https,
            ),
          ],
        ),
      ),
    );
  }
}