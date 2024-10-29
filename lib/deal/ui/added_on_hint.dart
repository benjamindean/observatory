import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:observatory/shared/ui/hint.dart';

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

    return Hint(
      icon: Icons.access_time_filled_sharp,
      child: Text.rich(
        TextSpan(
          style: context.themes.text.labelSmall?.copyWith(
            color: context.colors.hint,
          ),
          text: 'Added ',
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
      ),
    );
  }
}
