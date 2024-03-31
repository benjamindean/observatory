// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart';
// import 'package:observatory/settings/settings_state.dart';
// import 'package:observatory/shared/models/deal.dart';

// class FirebaseSync {
//   static void syncWaitlistToFirebase(List<Deal> newList) async {
//     final FirebaseFirestore db = GetIt.I<FirebaseFirestore>();

//     if (FirebaseAuth.instance.currentUser != null) {
//       await db
//           .collection(FirebaseAuth.instance.currentUser!.uid)
//           .doc('waitlist')
//           .set(
//         {
//           'deals': newList,
//           'update_time': DateTime.timestamp(),
//         },
//         SetOptions(merge: true),
//       );
//     }
//   }

//   static void syncSettingsToFirebase(SettingsState settings) async {
//     final FirebaseFirestore db = GetIt.I<FirebaseFirestore>();

//     if (FirebaseAuth.instance.currentUser != null) {
//       await db
//           .collection(FirebaseAuth.instance.currentUser!.uid)
//           .doc('settings')
//           .set(
//         {
//           'country': settings.selectedCountry,
//           'show_headers': settings.showHeaders,
//           'selected_stores': settings.selectedStores,
//           'deal_card_type': settings.dealCardType.name.toString(),
//           'update_time': DateTime.timestamp(),
//         },
//         SetOptions(merge: true),
//       );
//     }
//   }

//   static Future<Map<String, dynamic>?> getSettingsFromFirebase() async {
//     final FirebaseFirestore db = GetIt.I<FirebaseFirestore>();

//     if (FirebaseAuth.instance.currentUser != null) {
//       try {
//         final Map<String, dynamic>? settings = (await db
//                 .collection(FirebaseAuth.instance.currentUser!.uid)
//                 .doc('settings')
//                 .get())
//             .data();

//         return settings;
//       } catch (e) {
//         return null;
//       }
//     }

//     return null;
//   }

//   static Future<List<Deal>?> getWaitlistFromFirebase() async {
//     final FirebaseFirestore db = GetIt.I<FirebaseFirestore>();

//     if (FirebaseAuth.instance.currentUser != null) {
//       try {
//         final Map<String, dynamic>? waitlist = (await db
//                 .collection(FirebaseAuth.instance.currentUser!.uid)
//                 .doc('waitlist')
//                 .get())
//             .data();

//         if (waitlist == null) {
//           return [];
//         }

//         return waitlist['deals'].map<Deal>((e) => Deal.fromJson(e)).toList();
//       } catch (e) {
//         return null;
//       }
//     }

//     return null;
//   }
// }
