import 'package:flutter/material.dart';

class PhoneInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const PhoneInfoCard({
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
          color: Colors.green,
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

  String getCountry(String phone) {
    if (phone.startsWith("+91")) return "India";
    if (phone.startsWith("+1")) return "United States";
    if (phone.startsWith("+44")) return "United Kingdom";
    if (phone.startsWith("+81")) return "Japan";
    if (phone.startsWith("+61")) return "Australia";
    if (phone.startsWith("+971")) return "United Arab Emirates";

    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    final phone =
        analysis["phone_number"]?.toString() ?? "";

    final international =
        analysis["international"] == true;

    final length =
        analysis["length"]?.toString() ?? "0";

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
                  Icons.phone,
                  color: Colors.green,
                ),

                SizedBox(width: 10),

                Text(
                  "Phone Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            buildTile(
              Icons.phone_android,
              "Phone Number",
              phone,
            ),

            buildTile(
              Icons.flag,
              "Country",
              getCountry(phone),
            ),

            buildTile(
              Icons.public,
              "International",
              international ? "Yes" : "No",
            ),

            buildTile(
              Icons.numbers,
              "Digits",
              length,
            ),

            buildTile(
              Icons.info,
              "Number Type",
              international
                  ? "International"
                  : "Local",
            ),

          ],
        ),
      ),
    );
  }
}