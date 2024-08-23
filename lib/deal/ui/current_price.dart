import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/models/price.dart';

class CurrentPrice extends StatelessWidget {
  const CurrentPrice({
    super.key,
    required this.price,
  });

  final Price? price;

  @override
  Widget build(BuildContext context) {
    return Text(
      price?.price.formattedPrice ?? '0',
      style: context.themes.text.titleLarge?.copyWith(
        fontSize: 20.0,
        color: context.colors.scheme.onSurface,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
