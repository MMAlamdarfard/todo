import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/db/dbhelper.dart';
import 'package:todo/routes/route.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        routes: routes);
  }
}
