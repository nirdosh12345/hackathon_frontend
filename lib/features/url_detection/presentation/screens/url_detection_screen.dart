import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../qr_detection/presentation/widgets/google_safe_browsing_card.dart';
import '../../../qr_detection/presentation/widgets/url_features_card.dart';
import '../providers/url_detection_provider.dart';
import '../widgets/ai_analysis_card.dart';
import '../widgets/detection_pipeline_card.dart';
import '../widgets/domain_information_card.dart';
import '../widgets/reasons_card.dart';
import '../widgets/risk_gauge.dart';
import '../widgets/security_recommendation_card.dart';
import '../widgets/security_summary_card.dart';
import '../widgets/threat_details_card.dart';

class UrlDetectionPage extends StatefulWidget {
  const UrlDetectionPage({super.key});

  @override
  State<UrlDetectionPage> createState() => _UrlDetectionPageState();
}

class _UrlDetectionPageState extends State<UrlDetectionPage> {
  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _scanUrl() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await context.read<UrlDetectionProvider>().scanUrl(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UrlDetectionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("URL Security Scanner"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Scan Website",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  "Analyze URLs using Hybrid AI Detection Engine",
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Enter URL",
                    hintText: "https://example.com",

                    prefixIcon: const Icon(Icons.link),

                    suffixIcon: IconButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter URL";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading ? null : _scanUrl,

                    icon: const Icon(Icons.security),

                    label: const Text(
                      "Analyze URL",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                if (provider.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),

                          SizedBox(height: 20),

                          Text(
                            "Analyzing URL...",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (provider.error != null)
                  Card(
                    color: Colors.red.shade50,
                    child: ListTile(
                      leading: const Icon(Icons.error, color: Colors.red),
                      title: Text(
                        provider.error!,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),

                if (provider.result != null) ...[
                  const SizedBox(height: 20),

                  SecuritySummaryCard(result: provider.result!),

                  const SizedBox(height: 20),

                  RiskGauge(riskScore: provider.result!["risk_score"] ?? 0),

                  const SizedBox(height: 20),

                  AiAnalysisCard(result: provider.result!),

                  const SizedBox(height: 20),

                  DomainInfoCard(result: provider.result!),

                  const SizedBox(height: 20),

                  ReasonsCard(reasons: provider.result!["reasons"] ?? []),

                  // const SizedBox(height: 20),
                  //
                  // GoogleSafeBrowsingCard(
                  //   result: provider.result!,
                  // ),
                  const SizedBox(height: 20),

                  UrlFeaturesCard(result: provider.result!),

                  const SizedBox(height: 20),

                  ThreatDetailsCard(result: provider.result!),

                  const SizedBox(height: 20),

                  SecurityRecommendationCard(result: provider.result!),

                  const SizedBox(height: 20),

                  DetectionPipelineCard(result: provider.result!),

                  const SizedBox(height: 30),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
