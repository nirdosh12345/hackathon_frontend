import 'package:flutter/material.dart';

class VCardInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const VCardInfoCard({
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
          color: Colors.indigo,
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
                  Icons.contact_page,
                  color: Colors.indigo,
                ),

                SizedBox(width: 10),

                Text(
                  "Contact Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.person,
              "Name",
              analysis["name"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.business,
              "Company",
              analysis["company"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.work,
              "Designation",
              analysis["designation"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.phone,
              "Phone",
              analysis["phone"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.email,
              "Email",
              analysis["email"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.language,
              "Website",
              analysis["website"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.location_on,
              "Address",
              analysis["address"]?.toString() ?? "-",
            ),

          ],
        ),
      ),
    );
  }
}