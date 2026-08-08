import 'dart:io';

import 'package:flutter/material.dart';

import '../../../url_detection/presentation/widgets/risk_gauge.dart';
import '../../../url_detection/presentation/widgets/security_summary_card.dart';

import '../widgets/audio_player_card.dart';
import '../widgets/transcript_card.dart';
import '../widgets/keyword_card.dart';
import '../widgets/context_card.dart';
import '../widgets/psychology_card.dart';
import '../widgets/timestamp_card.dart';
import '../widgets/recommendation_card.dart';

class AudioResultPage extends StatelessWidget {
  final File audio;

  final Map<String, dynamic> result;

  const AudioResultPage({super.key, required this.audio, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Analysis"), centerTitle: true),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// Audio Player
              AudioPlayerCard(audio: audio),

              const SizedBox(height: 20),

              /// Security Summary
              SecuritySummaryCard(result: result),

              const SizedBox(height: 20),

              /// Risk Gauge
              RiskGauge(riskScore: result["risk_score"] ?? 0),

              const SizedBox(height: 20),

              /// Transcript
              TranscriptCard(transcript: result["transcript"] ?? ""),

              const SizedBox(height: 20),

              /// Keywords
              KeywordCard(keywords: result["matched_keywords"] ?? []),

              const SizedBox(height: 20),

              /// Context Analysis
              ContextCard(contexts: result["contexts"] ?? []),

              const SizedBox(height: 20),

              /// Psychological Analysis
              PsychologyCard(psychology: result["psychology"] ?? {}),

              const SizedBox(height: 20),

              /// Timestamps
              TimestampCard(timestamps: result["timestamps"] ?? []),

              const SizedBox(height: 20),

              /// Recommendations
              RecommendationCard(reasons: result["reasons"] ?? []),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
