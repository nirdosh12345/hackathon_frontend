import 'package:flutter/material.dart';

class TimestampCard extends StatelessWidget {
  final List<dynamic> timestamps;

  const TimestampCard({super.key, required this.timestamps});

  String formatTime(double seconds) {
    final duration = Duration(milliseconds: (seconds * 1000).toInt());

    final minutes = duration.inMinutes.remainder(60);

    final secs = duration.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2, '0')}:"
        "${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.schedule, color: Colors.blue),

                SizedBox(width: 10),

                Text(
                  "Speech Timeline",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (timestamps.isEmpty)
              const Center(child: Text("No timestamps available."))
            else
              ...timestamps.asMap().entries.map((entry) {
                final index = entry.key;

                final item = entry.value;

                final start = (item["start"] ?? 0).toDouble();

                final end = (item["end"] ?? 0).toDouble();

                final text = item["text"] ?? "";

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 16,

                            backgroundColor: Colors.blue,

                            child: Text(
                              "${index + 1}",

                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          if (index != timestamps.length - 1)
                            Container(width: 2, height: 60, color: Colors.blue),
                        ],
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),

                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,

                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    size: 18,
                                    color: Colors.blue,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    "${formatTime(start)}  →  ${formatTime(end)}",

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              Text(
                                text,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
