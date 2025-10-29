import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'supabase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Sample supbase_options.dart file:
//
// const Map<Symbol, dynamic> supabaseOptions = {
//   #url: 'https://qwerty.supabase.co',
//   #anonKey: '1234567890',
// };

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Function.apply(Supabase.initialize, [], supabaseOptions);

  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class AuthenticationWrapper extends ConsumerWidget {
//   const AuthenticationWrapper({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authStateAsync = ref.watch(authStateProvider);

//     return authStateAsync.when(
//       data: (user) {
//         return user == null ? const SignInPage() : const MainPage();
//       },
//       loading: () => const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       ),
//       error: (_, __) => const Scaffold(
//         body: Center(child: Text('Error')),
//       ),
//     );
//   }
// }

// class SignInPage extends ConsumerWidget {
//   const SignInPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign In'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => ref.read(authProvider.notifier).signInWithGoogle(),
//           child: const Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }
