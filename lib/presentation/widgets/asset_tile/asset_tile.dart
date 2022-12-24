import 'package:flutter/material.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({
    this.subtitle,
    required this.title,
    this.leading,
    this.trailing,
    Key? key,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
            onPressed: () {},
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: trailing,
            ),
          ),
        ],
      ),
    );
  }
}
