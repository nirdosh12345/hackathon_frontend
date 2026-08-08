import 'package:flutter/material.dart';

class AnalysisPipeline extends StatefulWidget {
  const AnalysisPipeline({super.key});

  @override
  State<AnalysisPipeline> createState() =>
      _AnalysisPipelineState();
}

class _AnalysisPipelineState
    extends State<AnalysisPipeline> {

  int currentStep = 0;

  final List<String> steps = [

    "Uploading Image",

    "Extracting Metadata",

    "Detecting Logos",

    "OCR Text Detection",

    "Object Detection",

    "Checking Image Phishing",

    "AI Risk Analysis",

    "Generating Security Report",

  ];

  @override
  void initState() {

    super.initState();

    Future.doWhile(() async {

      if (currentStep >= steps.length) {
        return false;
      }

      await Future.delayed(
        const Duration(milliseconds: 600),
      );

      if (mounted) {

        setState(() {
          currentStep++;
        });

      }

      return currentStep < steps.length;

    });

  }

  @override
  Widget build(BuildContext context) {

    return Column(

      children: List.generate(

        steps.length,

            (index) {

          bool completed = index < currentStep;

          bool active = index == currentStep;

          return ListTile(

            leading: completed

                ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )

                : active

                ? const SizedBox(
              width: 24,
              height: 24,
              child:
              CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )

                : const Icon(
              Icons.radio_button_unchecked,
              color: Colors.grey,
            ),

            title: Text(
              steps[index],
            ),
          );
        },
      ),
    );
  }
}