import 'package:contacts/bindings/home_binding.dart';
import 'package:contacts/screens/home_screen.dart';
import 'package:contacts/screens/upsert_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: '/upsert',
            page: () => const UpsertScreen(),
            binding: HomeBinding())
      ],
      initialRoute: '/home',
    );
  }
}
