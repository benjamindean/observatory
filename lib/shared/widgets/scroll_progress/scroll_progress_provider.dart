import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<double> scrollProgressProvider = StateProvider(
  (ref) => 0.0,
);
