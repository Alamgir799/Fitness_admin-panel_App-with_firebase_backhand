// ignore_for_file: prefer_const_constructors

import 'package:fitness_admin_project/ui/views/admin_login_penel.dart';
import 'package:fitness_admin_project/ui/views/category.dart';
import 'package:fitness_admin_project/ui/views/deshbord_screen.dart';
import 'package:fitness_admin_project/ui/views/home_screen.dart';
import 'package:fitness_admin_project/ui/views/quiz_data.dart';
import 'package:fitness_admin_project/ui/views/splash_screen.dart';
import 'package:get/get.dart';

const String adminLogin = '/adminLogin-screen';
const String splash = '/splash-screen';
const String home = '/home-screen';
const String dashBord = '/dashBord-screen';
const String quiz = '/quiz-screen';
const String categoryScreen = '/category-screen';


List<GetPage> getPages = [
  GetPage(
    name: splash,
    page: () => Splash(),
  ),
  GetPage(
    name: adminLogin,
    page: () => AdminLoginPage(),
  ),
  GetPage(
    name: home,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: dashBord,
    page: () => DashboardScreen(),
  ),
  GetPage(
    name: quiz,
    page: () {
      Quizdata _quizdata=Get.arguments;
      return _quizdata;
    }
  ),
  GetPage(
    name: categoryScreen,
    page: () {
      CategoryItemScreen _categoryItemScreen = Get.arguments;
      return _categoryItemScreen;
    },
  ),
];
