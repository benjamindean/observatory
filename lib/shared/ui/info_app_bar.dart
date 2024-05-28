import 'package:flutter/material.dart';

class InfoAppBar extends StatelessWidget {
  final Widget child;

  const InfoAppBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
