import 'package:flutter/material.dart';

class UPIInfoCard extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const UPIInfoCard({
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
          color: Colors.deepPurple,
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
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              children: const [

                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.deepPurple,
                ),

                SizedBox(width: 10),

                Text(
                  "UPI Information",
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
              "Merchant",
              analysis["merchant_name"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.account_balance,
              "UPI ID",
              analysis["upi_id"]?.toString() ?? "-",
            ),

            buildTile(
              Icons.currency_rupee,
              "Amount",
              analysis["amount"]?.toString() ?? "Not Specified",
            ),

            buildTile(
              Icons.payments,
              "Currency",
              analysis["currency"]?.toString() ?? "INR",
            ),

            buildTile(
              Icons.notes,
              "Transaction Note",
              analysis["transaction_note"]?.toString() ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}