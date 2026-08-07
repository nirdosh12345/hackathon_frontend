import 'package:flutter/material.dart';

import '../../../../url_detection/presentation/widgets/ai_analysis_card.dart';
import '../../../../url_detection/presentation/widgets/domain_information_card.dart';
import '../../../../url_detection/presentation/widgets/reasons_card.dart';
import '../../../../url_detection/presentation/widgets/risk_gauge.dart';
import '../../../../url_detection/presentation/widgets/security_recommendation_card.dart';
import '../../../../url_detection/presentation/widgets/security_summary_card.dart';
import '../email/email_info.dart';
import '../phone/phone_info_card.dart';
import '../sms/sms_info_card.dart';
import '../text/text_info_card.dart';
import '../upi/upi_info.dart';
import '../vcard/vcard_info_card.dart';
import '../wifi/wifi_info.dart';

class QRResultPage extends StatelessWidget {
  final Map<String, dynamic> result;

  const QRResultPage({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final String type =
    (result["type"] ?? "").toString().toUpperCase();

    final Map<String, dynamic> analysis =
        result["analysis"] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Security Report"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            SecuritySummaryCard(
              result: result,
            ),

            const SizedBox(height: 20),

            RiskGauge(
              riskScore: result["risk_score"] ?? 0,
            ),

            const SizedBox(height: 20),

            if (type == "URL")
              AiAnalysisCard(
                result: result,
              ),

            if (type == "URL")
              const SizedBox(height: 20),

            if (type == "URL")
              DomainInfoCard(
                result: result,
              ),

            if (type == "UPI")
              UPIInfoCard(
                analysis: analysis,
              ),

            if (type == "WIFI")
              WifiInfoCard(
                analysis: analysis,
              ),

            if (type == "EMAIL")
              EmailInfoCard(
                analysis: analysis,
              ),

            if (type == "PHONE")
              PhoneInfoCard(
                analysis: analysis,
              ),

            if (type == "SMS")
              SMSInfoCard(
                analysis: analysis,
              ),

            if (type == "VCARD")
              VCardInfoCard(
                analysis: analysis,
              ),

            if (type == "PLAIN TEXT")
              TextInfoCard(
                analysis: analysis,
              ),

            const SizedBox(height: 20),

            ReasonsCard(
              reasons: result["reasons"] ?? [],
            ),

            const SizedBox(height: 20),

            SecurityRecommendationCard(
              result: result["risk_score"] ?? 0,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}