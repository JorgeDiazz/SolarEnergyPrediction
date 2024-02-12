import 'package:flutter/material.dart';

/// Represents the button displayed on the map to navigate to user's current location
class CurrentLocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CurrentLocationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 25,
      child: IconButton(
        icon: const Icon(
          Icons.my_location_outlined,
          color: Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
