import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../image_detection/presentation/widgets/analysis_dialog.dart';
import '../../data/audio_data.dart';
import 'audio_result_page.dart';

class AudioDetectionPage extends StatefulWidget {
  const AudioDetectionPage({super.key});

  @override
  State<AudioDetectionPage> createState() => _AudioDetectionPageState();
}

class _AudioDetectionPageState extends State<AudioDetectionPage> {
  File? _audioFile;

  Uint8List? _audioBytes;

  String? _audioName;

  final AudioRecorder _recorder = AudioRecorder();

  bool isRecording = false;

  bool isLoading = false;

  String? recordedPath;

  /// Pick Audio

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,

      allowedExtensions: ["wav", "mp3", "aac", "m4a"],

      withData: kIsWeb,
    );

    if (result == null) return;

    if (kIsWeb) {
      setState(() {
        _audioBytes = result.files.single.bytes;

        _audioName = result.files.single.name;
      });
    } else {
      final path = result.files.single.path;

      if (path == null) return;

      setState(() {
        _audioFile = File(path);

        _audioName = result.files.single.name;
      });
    }
  }

  /// Start Recording
  Future<void> startRecording() async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Recording on Web is not supported in this version. Please upload an audio file.",
          ),
        ),
      );

      return;
    }

    if (!await _recorder.hasPermission()) {
      return;
    }

    final path = "${Directory.systemTemp.path}/recorded_audio.m4a";

    await _recorder.start(const RecordConfig(), path: path);

    setState(() {
      isRecording = true;
    });
  }

  /// Stop Recording
  Future<void> stopRecording() async {
    if (kIsWeb) return;

    recordedPath = await _recorder.stop();

    if (recordedPath == null) return;

    setState(() {
      isRecording = false;

      _audioFile = File(recordedPath!);

      _audioName = recordedPath!.split(Platform.pathSeparator).last;
    });
  }

  /// Analyze Audio

  Future<void> analyzeAudio() async {
    if (kIsWeb) {
      if (_audioBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload an audio file first.")),
        );

        return;
      }
    } else {
      if (_audioFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select or record an audio first."),
          ),
        );

        return;
      }
    }

    setState(() {
      isLoading = true;
    });

    try {
      showDialog(
        context: context,

        barrierDismissible: false,

        builder: (_) => const AnalysisDialog(),
      );

      Map<String, dynamic> result;

      if (kIsWeb) {
        result = await AudioData.analyzeAudioWeb(
          bytes: _audioBytes!,

          filename: _audioName ?? "audio.wav",
        );
      } else {
        result = await AudioData.analyzeAudio(_audioFile!);
      }

      if (!mounted) return;

      Navigator.pop(context);

      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (_) => AudioResultPage(
            audio: _audioFile,

            audioBytes: _audioBytes,

            audioName: _audioName,

            result: result,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasAudio = kIsWeb ? _audioBytes != null : _audioFile != null;

    return Scaffold(
      appBar: AppBar(title: const Text("Audio Analyzer"), centerTitle: true),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              /// Audio Preview
              Container(
                height: 220,

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: !hasAudio
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.audio_file, size: 80, color: Colors.grey),

                          SizedBox(height: 20),

                          Text(
                            "No Audio Selected",

                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const Icon(
                            Icons.library_music,

                            size: 80,

                            color: Colors.deepPurple,
                          ),

                          const SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),

                            child: Text(
                              _audioName ?? "Selected Audio",

                              textAlign: TextAlign.center,

                              style: const TextStyle(
                                fontSize: 16,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            kIsWeb ? "Ready for upload" : "Stored Successfully",

                            style: const TextStyle(
                              color: Colors.green,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),

              const SizedBox(height: 30),

              /// Upload Button
              SizedBox(
                height: 55,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload),

                  label: const Text("Upload Audio"),

                  onPressed: pickAudio,
                ),
              ),

              const SizedBox(height: 15),

              /// Record Button
              if (!kIsWeb)
                SizedBox(
                  height: 55,

                  child: ElevatedButton.icon(
                    icon: Icon(isRecording ? Icons.stop : Icons.mic),

                    label: Text(
                      isRecording ? "Stop Recording" : "Record Audio",
                    ),

                    onPressed: () {
                      if (isRecording) {
                        stopRecording();
                      } else {
                        startRecording();
                      }
                    },
                  ),
                ),

              if (!kIsWeb) const SizedBox(height: 30),

              /// Analyze Button
              SizedBox(
                height: 55,

                child: FilledButton.icon(
                  icon: const Icon(Icons.security),

                  label: const Text("Analyze Audio"),

                  onPressed: analyzeAudio,
                ),
              ),

              if (isLoading) ...[
                const SizedBox(height: 30),

                const Center(child: CircularProgressIndicator()),

                const SizedBox(height: 15),

                const Center(child: Text("Analyzing Audio...")),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
