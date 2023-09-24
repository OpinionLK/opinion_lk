import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String message;
  final IconData iconData;

  CustomToast({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.message,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: foregroundColor,
            ),
            const SizedBox(width: 12),
            Text( 
              message,
              style: TextStyle(
                color: foregroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
