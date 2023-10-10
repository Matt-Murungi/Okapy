import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/constants.dart';

class CardListTile extends StatelessWidget {
  final String title, subtitle, image;
  const CardListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      this.image = ""});
  const CardListTile.image(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return image.isEmpty
        ? ListTile(
            leading: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            title: Text(subtitle),
          )
        : ListTile(
            leading: Image.network("${NetworkConstant.serverAssets}$image"),
            title: Text(title),
            subtitle: Text(subtitle),
          );
  }
}

class PaddedListTile extends StatelessWidget {
  final String title, trailing;
  const PaddedListTile(
      {super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 3,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        trailing: Text(trailing),
      ),
    );
  }
}
