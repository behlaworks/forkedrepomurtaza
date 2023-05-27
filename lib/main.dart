import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/app_state_manager.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(const Alevel());
}

class Alevel extends StatefulWidget {
  const Alevel({Key? key}) : super(key: key);

  @override
  State<Alevel> createState() => _AlevelState();
}

class _AlevelState extends State<Alevel> {
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;

  @override
  void initState(){
    super.initState();
    _appRouter = AppRouter(
        appStateManager: _appStateManager
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateManager)
      ],
      child: Consumer<AppStateManager>(
        builder: (context, appStateManager, child){
          return MaterialApp(
            title: "AlevelApp",
            theme: ThemeData(
              fontFamily: 'Poppins'
            ),
            debugShowCheckedModeBanner: false,
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
