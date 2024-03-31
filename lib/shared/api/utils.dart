import 'package:observatory/shared/api/constans.dart';

List<List<String>> splitIDs(List<String> ids) {
  final List<List<String>> listsOfIDs = [];

  for (int i = 0; i < ids.length; i += API_LIMIT) {
    listsOfIDs.add(
      ids.sublist(
        i,
        i + API_LIMIT > ids.length ? ids.length : i + API_LIMIT,
      ),
    );
  }

  return listsOfIDs;
}
