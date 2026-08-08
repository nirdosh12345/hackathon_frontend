import 'package:flutter/material.dart';

class ImageMetadataCard extends StatelessWidget {
  final Map<String, dynamic> metadata;

  const ImageMetadataCard({
    super.key,
    required this.metadata,
  });

  Widget buildTile(String title, dynamic value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.cyan),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: Text(
        value?.toString() ?? "-",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.cyan),
                SizedBox(width: 10),
                Text(
                  "Image Metadata",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            buildTile(
              "File Name",
              metadata["file_name"],
              Icons.insert_drive_file,
            ),

            buildTile(
              "Format",
              metadata["format"],
              Icons.image,
            ),

            buildTile(
              "Width",
              metadata["width"],
              Icons.width_normal,
            ),

            buildTile(
              "Height",
              metadata["height"],
              Icons.height,
            ),

            buildTile(
              "File Size",
              metadata["size"],
              Icons.storage,
            ),

            buildTile(
              "Created",
              metadata["created"],
              Icons.calendar_today,
            ),

            buildTile(
              "Modified",
              metadata["modified"],
              Icons.update,
            ),
          ],
        ),
      ),
    );
  }
}