import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_level_pro/models/pages.dart';

import '../models/app_state_manager.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: Pages.splashScreen,
        key: ValueKey(Pages.splashScreen),
        child: const SplashScreen());
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  double _width = 50;
  double _height = 50;

  _SplashScreenState() {
    _timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _width = 200;
        _height = 200;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff07122a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: _height,
                width: _width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/A-level Pro.png'), fit: BoxFit.cover),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}