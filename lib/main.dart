import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/presentation/home/home.dart';
import 'package:untitled/presentation/login/login.dart';

void main() => runApp(
      ProviderScope(
        child: SwadApp(),
      ),
    );

class SwadApp extends ConsumerWidget {
  const SwadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginPage(),
        '/home' : (context) => HomePage()
      },
      darkTheme: ThemeData.dark(),
      title: 'Swad',
    );
  }
}
