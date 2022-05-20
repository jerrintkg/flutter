import 'package:app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: 'Post',
              icon: Icon(Icons.post_add_outlined),
            ),
            BottomNavigationBarItem(
              label: 'For You',
              icon: Icon(Icons.recommend),
            ),
            BottomNavigationBarItem(
              label: 'Live',
              icon: Icon(Icons.live_tv),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(Icons.account_box),
            ),
          ],
        ),
        body: Builder(builder: (BuildContext newContext) {
          return Center(
            child: ElevatedButton(
                child: Obx(() => Text(homeController.data.toString())),
                onPressed: () => {
                      homeController.changeData('Raja')
                      // Get.toNamed('/profile'),
                      // Get.snackbar(
                      //   'Just a Demo',
                      //   'Demo message From Home Page',
                      //   snackPosition: SnackPosition.BOTTOM,
                      //   backgroundColor: Colors.redAccent,
                      // ),
                      // ScaffoldMessenger.of(newContext).showSnackBar(
                      //   const SnackBar(
                      //     backgroundColor: Colors.green,
                      //     content: Text('Awesome Snackbar!'),
                      //   ),
                      // )
                    }),
          );
        }),
      ),
    );
  }
}
