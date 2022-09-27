import 'package:contacts/bindings/home_binding.dart';
import 'package:contacts/translate/translate.dart';
import 'package:contacts/views/home_screen.dart';
import 'package:contacts/views/upsert_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Translate(),
      locale: Locale('en'),
      getPages: [
        GetPage(
            name: '/home', page: () => HomeScreen(), binding: HomeBinding()),
        GetPage(
            name: '/upsert', page: () => UpsertScreen(), binding: HomeBinding())
      ],
      initialRoute: '/home',
    );
  }
}
