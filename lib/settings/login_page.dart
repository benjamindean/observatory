// import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:observatory/settings/settings_provider.dart';
// import 'package:observatory/waitlist/waitlist_provider.dart';

// enum FormType { login, signup }

// class LogInPage extends ConsumerStatefulWidget {
//   const LogInPage({super.key});

//   @override
//   ConsumerState<LogInPage> createState() => _LogInPageState();
// }

// class _LogInPageState extends ConsumerState<LogInPage> {
//   bool isLoading = false;
//   FormType formType = FormType.login;

//   final formKey = GlobalKey<FormBuilderState>();

//   Future<void> signIn() async {
//     final FormBuilderState? formState = formKey.currentState;

//     if (formState == null || !formState.saveAndValidate()) {
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: formState.fields['email']!.value.toString(),
//         password: formState.fields['password']!.value.toString(),
//       );

//       await Future.wait(
//         [
//           ref.watch(asyncSettingsProvider.notifier).restoreFromFirebase(),
//           ref.watch(asyncWaitListProvider.notifier).restoreFromFirebase()
//         ],
//       ).then((_) => context.go('/settings'));
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         isLoading = false;
//       });

//       switch (e.code) {
//         case 'ERROR_EMAIL_ALREADY_IN_USE':
//         case 'account-exists-with-different-credential':
//         case 'email-already-in-use':
//           formState.fields['email']?.invalidate(
//             'Email already used. Go to login page.',
//           );
//           break;
//         case 'ERROR_WRONG_PASSWORD':
//         case 'wrong-password':
//         case 'INVALID_LOGIN_CREDENTIALS':
//           formState.fields['password']?.invalidate(
//             'Wrong email/password combination.',
//           );
//           break;
//         case 'ERROR_USER_NOT_FOUND':
//         case 'user-not-found':
//           formState.fields['email']?.invalidate(
//             'No user found with this email.',
//           );
//           break;
//         case 'ERROR_USER_DISABLED':
//         case 'user-disabled':
//           formState.fields['email']?.invalidate(
//             'User disabled.',
//           );
//           break;
//         case 'ERROR_TOO_MANY_REQUESTS':
//         case 'operation-not-allowed':
//           formState.fields['email']?.invalidate(
//             'Too many requests to log into this account.',
//           );
//           break;
//         case 'ERROR_OPERATION_NOT_ALLOWED':
//           formState.fields['email']?.invalidate(
//             'Server error, please try again later.',
//           );
//           break;
//         case 'ERROR_INVALID_EMAIL':
//         case 'invalid-email':
//           formState.fields['email']?.invalidate(
//             'Email address is invalid.',
//           );
//           break;
//         default:
//           formState.fields['email']?.invalidate(
//             'Login failed. Please try again.',
//           );
//           break;
//       }
//     }
//   }

//   Future<void> signUp() async {
//     final FormBuilderState? formState = formKey.currentState;

//     if (formState == null || !formState.saveAndValidate()) {
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: formState.fields['email']!.value.toString(),
//         password: formState.fields['password']!.value.toString(),
//       );

//       await Future.wait(
//         [
//           ref.watch(asyncSettingsProvider.notifier).restoreFromFirebase(),
//           ref.watch(asyncWaitListProvider.notifier).restoreFromFirebase()
//         ],
//       ).then((_) => context.go('/settings'));
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         isLoading = false;
//       });

//       if (e.code == 'weak-password') {
//         formState.fields['password']?.invalidate(
//           'The password provided is too weak.',
//         );
//       } else if (e.code == 'email-already-in-use') {
//         formState.fields['email']?.invalidate(
//           'The account already exists for that email.',
//         );
//       }
//     }
//   }

//   Future<void> handleSignIn() async {
//     if (formType == FormType.login) {
//       await signIn();
//     } else {
//       await signUp();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               FormBuilder(
//                 enabled: !isLoading,
//                 key: formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
//                       child: Row(
//                         children: [
//                           Text(
//                             formType == FormType.login ? 'Sign In' : 'Sign Up',
//                             style: context.themes.text.headlineMedium?.copyWith(
//                               color: context.colors.scheme.onSurface,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
//                       child: Builder(
//                         builder: (context) {
//                           if (formType == FormType.login) {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'No account?',
//                                   style:
//                                       context.themes.text.titleSmall?.copyWith(
//                                     color: context.colors.scheme.onSurface,
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () => setState(() {
//                                     formType = FormType.signup;
//                                   }),
//                                   child: const Text('Sign Up'),
//                                 ),
//                               ],
//                             );
//                           }

//                           return Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Already have an account?',
//                                 style: context.themes.text.titleSmall?.copyWith(
//                                   color: context.colors.scheme.onSurface,
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () => setState(() {
//                                   formType = FormType.login;
//                                 }),
//                                 child: const Text('Sign In'),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//                       child: FormBuilderTextField(
//                         name: 'email',
//                         decoration: const InputDecoration(labelText: 'Email'),
//                         validator: FormBuilderValidators.compose([
//                           FormBuilderValidators.required(),
//                           FormBuilderValidators.email(),
//                         ]),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
//                       child: FormBuilderTextField(
//                         name: 'password',
//                         decoration:
//                             const InputDecoration(labelText: 'Password'),
//                         obscureText: true,
//                         validator: FormBuilderValidators.compose([
//                           FormBuilderValidators.required(),
//                           FormBuilderValidators.minLength(6),
//                         ]),
//                       ),
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//                     //   child: Row(
//                     //     children: [
//                     //       TextButton(
//                     //         onPressed: () => context.go('/sign-up'),
//                     //         child: const Text('Forgot Password?'),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: FilledButton.icon(
//                         icon: isLoading
//                             ? Transform.scale(
//                                 scale: 0.4,
//                                 child: CircularProgressIndicator(
//                                   color: context.colors.scheme.onPrimary,
//                                 ),
//                               )
//                             : const Icon(Icons.login_outlined),
//                         onPressed: isLoading ? null : handleSignIn,
//                         label: formType == FormType.signup
//                             ? const Text('Sign Up')
//                             : const Text('Sign In'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     'Or sign in with',
//                     style: context.themes.text.titleSmall?.copyWith(
//                       color: context.colors.scheme.onSurface,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton.outlined(
//                           iconSize: 32.0,
//                           onPressed: () async {
//                             final GoogleSignInAccount? googleUser =
//                                 await GoogleSignIn().signIn();

//                             final GoogleSignInAuthentication? googleAuth =
//                                 await googleUser?.authentication;

//                             final credential = GoogleAuthProvider.credential(
//                               accessToken: googleAuth?.accessToken,
//                               idToken: googleAuth?.idToken,
//                             );

//                             await FirebaseAuth.instance
//                                 .signInWithCredential(credential);

//                             await Future.wait(
//                               [
//                                 ref
//                                     .watch(asyncSettingsProvider.notifier)
//                                     .restoreFromFirebase(),
//                                 ref
//                                     .watch(asyncWaitListProvider.notifier)
//                                     .restoreFromFirebase()
//                               ],
//                             ).then((value) => context.go('/settings'));
//                           },
//                           icon: Icon(
//                             FontAwesomeIcons.google,
//                             color: context.colors.scheme.onSurface,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
