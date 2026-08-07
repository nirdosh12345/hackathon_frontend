import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UrlDetectionProvider extends ChangeNotifier {
  // -------------------------------
  // Backend URL
  // -------------------------------

  static const String _baseUrl =
      "http://127.0.0.1:8000/predict";

  // -------------------------------
  // States
  // -------------------------------

  bool _isLoading = false;

  String? _error;

  Map<String, dynamic>? _result;

  // -------------------------------
  // Getters
  // -------------------------------

  bool get isLoading => _isLoading;

  String? get error => _error;

  Map<String, dynamic>? get result => _result;

  // -------------------------------
  // Scan URL
  // -------------------------------

  Future<void> scanUrl(String url) async {
    _isLoading = true;

    _error = null;

    _result = null;

    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "url": url,
        }),
      );

      if (response.statusCode == 200) {
        _result = jsonDecode(response.body);
      } else {
        _error =
        "Server Error (${response.statusCode})";
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  // -------------------------------
  // Clear Result
  // -------------------------------

  void clear() {
    _result = null;

    _error = null;

    notifyListeners();
  }
}