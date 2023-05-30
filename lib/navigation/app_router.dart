import 'package:a_level_pro/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:a_level_pro/models/app_state_manager.dart';
import '../screens/onBoarding.dart';
import '../screens/splashScreeen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;

  AppRouter({required this.appStateManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          OnboardingScreen.page(),
        if (appStateManager.isInitialized && appStateManager.isLoggedIn)
          Home.page(),
        ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    // if (route.settings.name == EpsilonPages.registerPage){
    //   appStateManager.goBackRegister();
    // }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}