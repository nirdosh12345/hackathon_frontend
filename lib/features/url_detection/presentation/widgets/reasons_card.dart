import 'package:flutter/material.dart';

class ReasonsCard extends StatelessWidget {
  final List<dynamic>? reasons;

  const ReasonsCard({
    super.key,
    required this.reasons,
  });

  @override
  Widget build(BuildContext context) {
    if (reasons == null || reasons!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      color: const Color(0xFF1E293B),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.fact_check,
                  color: Colors.lightBlueAccent,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  "Detection Reasons",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ...reasons!.map(
                  (reason) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF334155),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.cyanAccent,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          reason.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
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