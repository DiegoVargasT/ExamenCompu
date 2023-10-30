import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String text;
  final String route;

  const CardWidget({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.route,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Card(
          color: backgroundColor,
          elevation: 5.0,
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
                const SizedBox(height: 25),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
          ),
        ),
      )
    );
  }
}