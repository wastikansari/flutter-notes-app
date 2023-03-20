import 'package:flutter/material.dart';

class ListTileSetting extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final IconData? iconData;
  final Widget? subtitle;
    final Widget? trailing;

  const ListTileSetting({this.title, this.iconData, this.onTap, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          onTap:(){onTap!();} ,
          leading: Icon(
            iconData,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(title!),
          trailing: trailing,
          subtitle: subtitle,
        ),
        Divider(
          indent: 60,
          thickness: 2,
        ),
      ],
    );
  }
}
