import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class SteamImportForm extends ConsumerWidget {
  const SteamImportForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    final SteamImportState steamImportState = ref.watch(steamImportProvider);

    return FormBuilder(
      enabled: !steamImportState.isLoading,
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Import Wishlist from Steam',
                        textAlign: TextAlign.center,
                        style: context.textStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                    subtitle: const Text(
                      'Enter your Steam username exactly as it appears in your profile URL. Make sure your profile is public. We will only read your wishlist.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: FormBuilderTextField(
              name: 'username',
              controller: steamImportState.usernameInputController,
              decoration: const InputDecoration(
                labelText: 'Steam Username',
              ),
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: FilledButton.icon(
              icon: steamImportState.isLoading
                  ? const ObservatoryIconProgressIndicator()
                  : const Icon(Icons.arrow_downward_rounded),
              onPressed: steamImportState.isLoading
                  ? null
                  : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final String value =
                            formKey.currentState?.fields['username']?.value;

                        if (value.trim().isNotEmpty) {
                          ref.read(steamImportProvider.notifier).fetch().then(
                            (result) {
                              if (result == null) {
                                return;
                              }

                              if (context.mounted) {
                                return ObservatorySnackBar.show(
                                  context,
                                  content: RichText(
                                    text: TextSpan(
                                      style: context
                                          .themes.snackBar.contentTextStyle
                                          ?.copyWith(
                                        color: context
                                            .colors.scheme.onInverseSurface,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Found '),
                                        TextSpan(
                                          text: result.length.toString(),
                                          style: context
                                              .themes.snackBar.contentTextStyle
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: context
                                                .colors.scheme.onInverseSurface,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' games in your wishlist. ',
                                          style: context
                                              .themes.snackBar.contentTextStyle
                                              ?.copyWith(
                                            color: context
                                                .colors.scheme.onInverseSurface,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'Please verify that everything is correct and then press ',
                                          style: context
                                              .themes.snackBar.contentTextStyle
                                              ?.copyWith(
                                            color: context
                                                .colors.scheme.onInverseSurface,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Import.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: context
                                                .colors.scheme.onInverseSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      }
                    },
              label: const Text('Load Wishlist'),
            ),
          ),
        ],
      ),
    );
  }
}
