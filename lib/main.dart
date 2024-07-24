import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gif/core/services/local_storage.dart';
import 'package:gif/features/auth/view/pages/sign_up.dart';
import 'package:gif/features/gif/view/pages/gif_list.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Future.wait([
     
     Firebase.initializeApp(),
     Hive.openBox("user"),
     Hive.openBox("favourites")
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gif',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LocalStorage.getUserInfo() == null ? SignUp() : GifList(),
    );
  }
}
