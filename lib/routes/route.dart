import 'package:flutter/material.dart';
import '../screens/homepage.dart';
import 'name.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Screens.root: (context) => const HomePage()
};
