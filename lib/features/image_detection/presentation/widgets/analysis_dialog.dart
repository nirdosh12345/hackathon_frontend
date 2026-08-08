import 'package:flutter/material.dart';

import 'analysis_pipeline.dart';

class AnalysisDialog extends StatelessWidget {
  const AnalysisDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [

              const AnalysisPipeline(),

              SizedBox(height: 25),

              Text(
                "Analyzing Image",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              Text(
                "Please wait while Cyber Guardian AI performs security analysis.",
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}