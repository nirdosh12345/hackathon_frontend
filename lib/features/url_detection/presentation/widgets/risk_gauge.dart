import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RiskGauge extends StatelessWidget {
  final int riskScore;

  const RiskGauge({
    super.key,
    required this.riskScore,
  });

  Color get gaugeColor {
    if (riskScore <= 20) {
      return Colors.green;
    } else if (riskScore <= 50) {
      return Colors.yellow;
    } else if (riskScore <= 75) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLabel {
    if (riskScore <= 20) {
      return "SAFE";
    } else if (riskScore <= 50) {
      return "LOW RISK";
    } else if (riskScore <= 75) {
      return "SUSPICIOUS";
    }
    return "PHISHING";
  }

  IconData get icon {
    if (riskScore <= 20) {
      return Icons.verified;
    } else if (riskScore <= 50) {
      return Icons.info;
    } else if (riskScore <= 75) {
      return Icons.warning_amber;
    }
    return Icons.dangerous;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Risk Meter",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 340,
              child: SfRadialGauge(
                axes: [

                  RadialAxis(

                    minimum: 0,

                    maximum: 100,

                    showTicks: false,

                    showLabels: false,

                    axisLineStyle: const AxisLineStyle(
                      thickness: 18,
                      thicknessUnit: GaugeSizeUnit.logicalPixel,
                    ),

                    ranges: [

                      GaugeRange(
                        startValue: 0,
                        endValue: 20,
                        color: Colors.green,
                      ),

                      GaugeRange(
                        startValue: 20,
                        endValue: 50,
                        color: Colors.yellow,
                      ),

                      GaugeRange(
                        startValue: 50,
                        endValue: 75,
                        color: Colors.orange,
                      ),

                      GaugeRange(
                        startValue: 75,
                        endValue: 100,
                        color: Colors.red,
                      ),
                    ],

                    pointers: [

                      NeedlePointer(
                        value: riskScore.toDouble(),
                        needleLength: 0.75,
                        needleStartWidth: 3,
                        needleEndWidth: 6,
                        needleColor: gaugeColor,
                        knobStyle: KnobStyle(
                          color: gaugeColor,
                        ),
                      ),
                    ],

                    annotations: [

                      GaugeAnnotation(

                        angle: 90,

                        positionFactor: 0.35,

                        widget: Column(

                          mainAxisSize: MainAxisSize.min,

                          children: [
                            SizedBox(height: 70,),
                            Icon(
                              icon,
                              color: gaugeColor,
                              size: 35,
                            ),

                            Text(
                              "$riskScore",
                              style: TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.bold,
                                color: gaugeColor,
                              ),
                            ),
                            Text(
                              "%",
                              style: TextStyle(
                                fontSize: 22,
                                color: gaugeColor
                              ),
                            ),

                            Text(
                              riskLabel,
                              style: TextStyle(
                                color: gaugeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}