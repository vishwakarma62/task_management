
import 'package:flutter/material.dart';
import 'package:task_management/screen/recycle_bin.dart';
import 'package:task_management/screen/tabscreen.dart';

import '../screen/pendingtaskscreen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (context) {
          return RecycleBin();
        });

      case TabScreen.id:
        return MaterialPageRoute(builder: (context) {
          return TabScreen();
        });
    }
    return null;
  }
}
