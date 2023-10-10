import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search(
      {super.key, required this.searchController, required this.onChanged});

  final TextEditingController searchController;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: 'Search partners',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }
}
