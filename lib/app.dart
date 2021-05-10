import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/routes.dart';
import 'package:flutter_checkers/util/board.dart';
import 'package:flutter_checkers/util/screen.dart';
import 'package:flutter_checkers/view/page/game_page.dart';
import 'package:flutter_checkers/view/page/loading_page.dart';

final applicationKey = GlobalKey<NavigatorState>();

void runCheckers() {
  final root = Root();

  return runApp(root);
}

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      applicationKey.currentState.pushNamed(Routes.game_page);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: applicationKey,
      initialRoute: Routes.loading_page,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.game_page:
        return MaterialPageRoute(builder: (_) => GamePage());
      case Routes.loading_page:
        return MaterialPageRoute(builder: (_) => LoadingPage());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
