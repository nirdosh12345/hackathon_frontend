import 'package:flutter/material.dart';

class ThreatDetailsCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ThreatDetailsCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    final reasons =
        (result["reasons"] as List?) ?? [];

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
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Threat Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (reasons.isEmpty)

              Container(
                padding:
                const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.green
                      .shade50,
                  borderRadius:
                  BorderRadius.circular(
                      12),
                ),

                child: const Row(
                  children: [

                    Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "No suspicious indicators were detected.",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )

            else

              ListView.separated(

                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount:
                reasons.length,

                separatorBuilder:
                    (_, _) =>
                const SizedBox(
                    height: 10),

                itemBuilder:
                    (context, index) {

                  return Container(

                    padding:
                    const EdgeInsets
                        .all(14),

                    decoration:
                    BoxDecoration(

                      color: Colors
                          .orange
                          .shade50,

                      borderRadius:
                      BorderRadius
                          .circular(
                          12),

                    ),

                    child: Row(

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        const Icon(
                          Icons.error_outline,
                          color:
                          Colors.orange,
                        ),

                        const SizedBox(
                            width: 12),

                        Expanded(

                          child: Text(

                            reasons[index]
                                .toString(),

                            style:
                            const TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrangeAccent
                            ),

                          ),

                        ),
                      ],
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