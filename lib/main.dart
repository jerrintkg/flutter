import 'package:app/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/pages/home/home_page.dart';

void main() => runApp(const RootWidget());

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const HomePage(),
            transition: Transition.zoom,
          ),
          GetPage(
            name: '/profile',
            page: () => const ProfilePage(),
            transition: Transition.zoom,
          ),
          // GetPage(name: '/', page: () => HomePage()),
          // GetPage(name: '/', page: () => HomePage()),
        ],
        theme: ThemeData(
          primarySwatch: Colors.green,
        ));
  }
}
