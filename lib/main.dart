// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'ui/route/route.dart';
import 'ui/views/admin_login_penel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDKlPzLML6NuyYt9mdiJrUPvD1c4fxBLP0",
        appId: "1:987453190322:web:5497f4caef800740a1d9ab",
        authDomain: "fitness-mobile-app-de0be.firebaseapp.com",
        databaseURL:
            "https://fitness-mobile-app-de0be-default-rtdb.asia-southeast1.firebasedatabase.app",
        messagingSenderId: "987453190322",
        projectId: "fitness-mobile-app-de0be",
        storageBucket: "fitness-mobile-app-de0be.appspot.com",
        measurementId: "G-2C8HX0VCY1"),
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminLoginPage(),
      initialRoute: splash,
      getPages: getPages,
    );
  }
}
