// import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:observatory/settings/settings_provider.dart';

// class CountrySelect extends ConsumerWidget {

//   const CountrySelect({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final String selectedCountry = ref.watch(
//       asyncSettingsProvider.select(
//         (value) => value.requireValue.selectedCountry,
//       ),
//     );

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const CountrySelectBanner(),
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: countries.length,
//             itemBuilder: (context, index) {
//               final Country? country = Country.tryParse(
//                 countries[index].toUpperCase(),
//               );

//               return ListTile(
//                 leading: Text(
//                   country?.flagEmoji ?? '',
//                   style: context.themes.text.labelLarge,
//                 ),
//                 selectedTileColor: context.colors.scheme.primaryContainer,
//                 selectedColor: context.colors.scheme.onPrimaryContainer,
//                 selected: countries[index] == selectedCountry,
//                 title: Text(
//                   country?.name ?? countries[index].toUpperCase(),
//                 ),
//                 onTap: () async {
//                   ref.read(asyncSettingsProvider.notifier).setCountry(
//                         countries[index],
//                       );

//                   context.pop();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CountrySelectBanner extends StatelessWidget {
//   const CountrySelectBanner({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialBanner(
//       leading: Icon(
//         Icons.info,
//         color: context.colors.scheme.onSurface,
//       ),
//       content: Padding(
//         padding: const EdgeInsets.only(bottom: 16.0, top: 12.0),
//         child: Text(
//           'Country doesn\'t affect prices and available stores as much as region does. If your contry is not in the list - just pick the closest one.',
//           style: context.themes.text.labelMedium?.copyWith(
//             color: context.colors.scheme.onSurface,
//           ),
//         ),
//       ),
//       actions: const [SizedBox.shrink()],
//     );
//   }
// }
