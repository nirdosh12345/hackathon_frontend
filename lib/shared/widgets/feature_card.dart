
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final List<IconData> icon;
  final Color color;
  final String backgrondImage;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.backgrondImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(20),

      onTap: onTap,

      child: Ink(

        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(backgrondImage), fit: BoxFit.contain),
          color: const Color(0xff161B22),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.03,
                backgroundColor: color.withOpacity(.18),

                child: Icon(
                  icon[0],
                  color: color,
                  size: MediaQuery.of(context).size.width * 0.03,
                ),
              ),

              Spacer(),

              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.02,
                backgroundColor: color.withOpacity(0.75),
                child: Icon(icon[1], size: MediaQuery.of(context).size.width * 0.02),
                foregroundColor: Colors.black87,
              )
            ],
          ),
        ),
      ),
    );
  }
}