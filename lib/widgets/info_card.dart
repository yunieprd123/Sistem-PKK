import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color.fromARGB(255, 254, 168, 197),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 242, 159, 187),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
