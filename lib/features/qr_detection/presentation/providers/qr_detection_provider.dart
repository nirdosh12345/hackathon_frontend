import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class QrDetectionProvider extends ChangeNotifier {
  bool isLoading = false;

  String? error;

  Map<String, dynamic>? result;

  final String apiUrl =
      "http://127.0.0.1:8000/predict_qr";

  Future<void> scanQr(XFile image) async {
    isLoading = true;
    error = null;
    result = null;
    notifyListeners();

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(apiUrl),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          await image.readAsBytes(),
          filename: image.name,
        ),
      );

      final streamedResponse = await request.send();

      final response =
      await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else {
        error =
        "Server Error (${response.statusCode})\n${response.body}";
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void clear() {
    error = null;
    result = null;
    notifyListeners();
  }
}