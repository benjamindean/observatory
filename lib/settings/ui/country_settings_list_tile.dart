import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';

class CountrySettingsListTile extends ConsumerWidget {
  const CountrySettingsListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String selectedCountry = ref.watch(
      itadConfigProvider.select(
        (config) => config.valueOrNull?.selectedCountry ?? 'US',
      ),
    );

    return Column(
      children: [
        const ListTile(
          title: Text('Country'),
          subtitle: Text(
            'Availability of certain stores may vary based on your country.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.arrow_drop_down_circle_sharp,
                  ),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      useRootNavigator: true,
                      useSafeArea: true,
                      countryListTheme: CountryListThemeData(
                        bottomSheetHeight:
                            MediaQuery.of(context).size.height * 0.8,
                        borderRadius: BorderRadius.zero,
                      ),
                      onSelect: (Country country) {
                        ref
                            .watch(itadConfigProvider.notifier)
                            .setCountry(country.countryCode);
                      },
                    );
                  },
                  label: Text(
                    Country.tryParse(selectedCountry)?.name ??
                        selectedCountry.toString().toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
