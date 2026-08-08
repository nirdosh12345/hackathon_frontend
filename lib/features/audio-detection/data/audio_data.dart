import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class AudioData {
  // Android Emulator
  // static const String baseUrl = "http://10.0.2.2:8000";

  // Windows/Web
  static const String baseUrl = "http://127.0.0.1:8000";

  /// Android/Desktop
  static Future<Map<String, dynamic>> analyzeAudio(File audioFile) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/predict_audio"),
      );

      request.files.add(
        await http.MultipartFile.fromPath("file", audioFile.path),
      );

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception("Server Error ${response.statusCode}");
    } catch (e) {
      throw Exception("Audio Upload Failed\n$e");
    }
  }

  /// Flutter Web

  static Future<Map<String, dynamic>> analyzeAudioWeb({
    required Uint8List bytes,

    required String filename,
  }) async {
    try {
      var request = http.MultipartRequest(
        "POST",

        Uri.parse("$baseUrl/predict_audio"),
      );

      request.files.add(
        http.MultipartFile.fromBytes("file", bytes, filename: filename),
      );

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception("Server Error ${response.statusCode}");
    } catch (e) {
      throw Exception("Audio Upload Failed\n$e");
    }
  }
}
