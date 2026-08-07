import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/qr_detection/presentation/providers/qr_detection_provider.dart';
import 'features/url_detection/presentation/providers/url_detection_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MultiProvider(
        providers: [

          ChangeNotifierProvider(
            create: (_) => UrlDetectionProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => QrDetectionProvider(),
          ),

        ],

        child: const CyberGuardianApp(),
      )
  );
}