import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class ListHeading extends StatelessWidget {
  final String title;
  final Widget? subtitle;

  const ListHeading({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.textStyles.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colors.primary,
        ),
      ),
      style: ListTileStyle.drawer,
      subtitle: subtitle,
    );
  }
}
