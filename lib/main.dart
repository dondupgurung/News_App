


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/main_screen.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ProviderScope(child: mainScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}

