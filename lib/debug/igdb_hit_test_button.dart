import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/api/igdb_api.dart';
import 'package:observatory/shared/models/deal.dart';

class IGDBHitTestButton extends StatelessWidget {
  final List<Deal> deals;

  const IGDBHitTestButton({
    super.key,
    required this.deals,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        List<String> success = [];
        List<String> failures = [];

        for (final deal in deals) {
          final result = await GetIt.I<IGDBAPI>().searchIGDB(
            title: deal.titleParsed,
          );

          if (result != null) {
            success.add(deal.titleParsed);
          } else {
            failures.add(deal.titleParsed);
          }

          await Future.delayed(const Duration(milliseconds: 330));
        }

        Logger().d({
          'success': success.length,
          'total': deals.length,
          'ratio': (success.length / deals.length) * 100,
          'failed': failures,
        });
      },
      child: const Text('Test'),
    );
  }
}
