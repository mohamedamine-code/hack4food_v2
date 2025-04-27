import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String title;       // <-- Added this
  final IconData? icon;      // <-- Optional: Add icon if needed
  final Color? color;        // <-- Optional: Customize color

  const HomeContainer({
    super.key,
    required this.title,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color ?? Colors.green,  // <-- Use given color or default green
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 60,
              color: Colors.white,
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img/file.png',
                width: 100,
              ),
            ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
