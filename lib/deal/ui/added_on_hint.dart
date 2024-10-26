import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddedOnHint extends StatelessWidget {
  const AddedOnHint({
    super.key,
    required this.added,
  });

  final int added;

  @override
  Widget build(BuildContext context) {
    if (added == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.access_time_filled_sharp,
            color: context.colors.scheme.secondary,
            size: context.textStyles.labelLarge.fontSize,
          ),
          const SizedBox(width: 4.0),
          Text.rich(
            TextSpan(
              style: context.themes.text.labelSmall?.copyWith(
                color: context.colors.hint,
              ),
              text: 'Added on ',
              children: [
                TextSpan(
                  text: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                    DateTime.fromMillisecondsSinceEpoch(
                      added.toInt(),
                    ),
                  ),
                  style: context.themes.text.labelSmall?.copyWith(
                    color: context.colors.hint,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
