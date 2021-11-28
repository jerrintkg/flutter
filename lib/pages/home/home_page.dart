import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                child: const Text('Press Me'),
                onPressed: () => {
                      Get.toNamed('/profile'),
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
