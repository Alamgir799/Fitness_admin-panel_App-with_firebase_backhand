import 'dart:ui';
import 'package:fitness_admin_project/ui/route/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final box = GetStorage();

  Future chooseScreen() async {
    var emailAddress = box.read('email');
    if (emailAddress == null) {
      Get.toNamed(adminLogin);
    } else {
      Get.toNamed(dashBord);
    }
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => chooseScreen(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Image.asset(
                  'assets/images/splash.gif',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Positioned(
              child: CircularProgressIndicator(color: Colors.amber),
            )
          ],
        ),
      ),
    );
  }
}
