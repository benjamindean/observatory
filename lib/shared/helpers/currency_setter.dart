import 'package:get_it/get_it.dart';

class Currency {
  final String name;

  const Currency(this.name);
}

String setCurrency(String? currency) {
  if (currency == 'Unknown') {
    return 'USD';
  }

  if (currency == null) {
    GetIt.I.registerSingleton(const Currency('USD'));

    return 'USD';
  }

  final isRegistered = GetIt.I.isRegistered<Currency>();

  if (isRegistered && GetIt.I<Currency>().name != currency) {
    GetIt.I.unregister<Currency>();
    GetIt.I.registerSingleton(Currency(currency));

    return currency;
  }

  if (!isRegistered) {
    GetIt.I.registerSingleton(Currency(currency));
  }

  return currency;
}
