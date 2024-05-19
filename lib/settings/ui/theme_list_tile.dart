import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:observatory/settings/ui/scheme_preview.dart';

final List<FlexScheme> flexSchemes = [
  FlexScheme.mandyRed,
  FlexScheme.amber,
  FlexScheme.sakura,
  FlexScheme.blueM3,
  FlexScheme.greenM3,
  FlexScheme.blumineBlue,
  FlexScheme.espresso,
  FlexScheme.yellowM3,
  FlexScheme.barossa,
];

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const ListTile(
          title: Text('Color Scheme'),
          subtitle: Text('Select color scheme.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: 70,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: flexSchemes.length,
              itemBuilder: (context, index) {
                return SchemePreview(
                  scheme: flexSchemes[index],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
