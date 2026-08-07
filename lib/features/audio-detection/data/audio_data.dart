import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AudioData {
  // Replace with your backend URL
  static const String baseUrl = " http://127.0.0.1:8000";
  // Android Emulator -> 10.0.2.2
  // Windows -> http://127.0.0.1:8000
  // Physical Device -> http://YOUR_PC_IP:8000

  static Future<Map<String, dynamic>> analyzeAudio(
      File audioFile,
      ) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/predict_audio"),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          audioFile.path,
        ),
      );

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(
        streamedResponse,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception(
        "Server Error (${response.statusCode})\n${response.body}",
      );
    } catch (e) {
      throw Exception(
        "Audio Analysis Failed\n$e",
      );
    }
  }
}