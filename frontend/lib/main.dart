import 'package:flutter/material.dart';

import 'views/auth/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Online Banking System",
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
