import 'package:flutter/material.dart';


class NavTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const NavTile({super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawerDestination(
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
