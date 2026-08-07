import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/feature_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xff0D1117),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // ================= HEADER =================

                  Row(
                    children: [

                      Container(
                        height: 65,
                        width: 65,

                        decoration: BoxDecoration(
                          color: const Color(0xff00E676).withOpacity(.12),
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.security,
                          color: Color(0xff00E676),
                          size: 35,
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Cyber Guardian AI",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "One App Against Every Digital Scam",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ================= STATUS CARD =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: const Color(0xff161B22),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "System Status",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [

                            Container(
                              width: 14,
                              height: 14,

                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              "Protected",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 15),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Text("AI Engine"),

                            Text(
                              "ONLINE",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 12),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Text("Last Scan"),

                            Text("Today")
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Protection Tools",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 1.5,

                    children: [

                      FeatureCard(
                        title: "Verify URL",
                        subtitle: "Analyze suspicious links",
                        icon: [Icons.link, Icons.arrow_forward_rounded],
                        color: Colors.green,
                        backgrondImage: 'assets/images/verify_url.png',
                        onTap: () {
                          context.push('/url-detection');
                        },
                      ),

                      FeatureCard(
                        title: "Scan QR",
                        subtitle: "Detect malicious QR",
                        icon: [Icons.qr_code_scanner, Icons.arrow_forward_rounded],
                        color: Colors.cyan,
                        backgrondImage: 'assets/images/scan_qr.png',
                        onTap: () {
                          context.push('/qr-detection');
                        },
                      ),

                      FeatureCard(
                        title: "Analyze Image",
                        subtitle: "Detect scam screenshots",
                        icon: [Icons.image_search, Icons.arrow_forward_rounded],
                        color: Colors.orange,
                        backgrondImage: 'assets/images/analyse_image.png',
                        onTap: () {
                          context.push('/image-detection');
                        },
                      ),

                      FeatureCard(
                        title: "History",
                        subtitle: "Previous scans",
                        icon: [Icons.history, Icons.arrow_forward_rounded],
                        color: Colors.purple,
                        backgrondImage: 'assets/images/history.png',
                        onTap: () {
                          context.push('/history');
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            fixedSize: MediaQuery.of(context).size * 0.08
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.report),
                          label: Text("Report Scam", style: TextStyle(fontSize: 6.sp),),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              fixedSize: MediaQuery.of(context).size * 0.08
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.school),
                          label: Text("Learn", style: TextStyle(fontSize: 6.sp),),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: Text("google.com"),
                      subtitle: Text("Safe"),
                    ),
                  ),

                  const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      title: Text("amazon-login-security.xyz"),
                      subtitle: Text("High Risk"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
