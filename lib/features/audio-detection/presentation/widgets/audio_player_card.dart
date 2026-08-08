import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AudioPlayerCard extends StatefulWidget {
  final File? audio;
  final Uint8List? audioBytes;

  const AudioPlayerCard({super.key, this.audio, this.audioBytes});

  @override
  State<AudioPlayerCard> createState() => _AudioPlayerCardState();
}

class _AudioPlayerCardState extends State<AudioPlayerCard> {
  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    _player.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });

    _player.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });

    _player.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  Future<void> playPause() async {
    if (isPlaying) {
      await _player.pause();

      setState(() {
        isPlaying = false;
      });
    } else {
      if (kIsWeb && widget.audioBytes != null) {
        await _player.play(BytesSource(widget.audioBytes!));
      } else if (widget.audio != null) {
        await _player.play(DeviceFileSource(widget.audio!.path));
      }

      setState(() {
        isPlaying = true;
      });
    }
  }

  String format(Duration d) {
    final minutes = d.inMinutes.remainder(60);

    final seconds = d.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Row(
              children: [
                Icon(Icons.graphic_eq, color: Colors.blue),

                SizedBox(width: 10),

                Text(
                  "Audio Player",

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Slider(
              value: position.inSeconds.toDouble(),

              min: 0,

              max: duration.inSeconds == 0 ? 1 : duration.inSeconds.toDouble(),

              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());

                await _player.seek(newPosition);
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [Text(format(position)), Text(format(duration))],
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),

                label: Text(isPlaying ? "Pause" : "Play"),

                onPressed: playPause,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();

    super.dispose();
  }
}
