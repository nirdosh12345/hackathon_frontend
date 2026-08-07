import 'package:flutter/material.dart';

class ImageObjectCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ImageObjectCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final List objects =
        result["objects"] ?? [];

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
                  Icons.image_search,
                  color: Colors.green,
                ),

                SizedBox(width: 10),

                Text(
                  "Object Detection",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (objects.isEmpty)

              const Center(
                child: Padding(
                  padding:
                  EdgeInsets.all(20),
                  child: Text(
                    "No Objects Detected",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              )

            else

              ...objects.map(
                    (obj) {

                  return Card(
                    color: Colors.black26,
                    child: ListTile(

                      leading: const Icon(
                        Icons.category,
                        color: Colors.green,
                      ),

                      title: Text(
                        obj["name"] ??
                            "Unknown",
                        style:
                        const TextStyle(
                          color:
                          Colors.white,
                        ),
                      ),

                      subtitle: Text(
                        "Confidence : ${obj["confidence"] ?? "-"}%",
                        style:
                        const TextStyle(
                          color: Colors
                              .white70,
                        ),
                      ),

                      trailing: const Icon(
                        Icons.check_circle,
                        color:
                        Colors.green,
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