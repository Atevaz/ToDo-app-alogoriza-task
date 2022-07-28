import 'package:flutter/material.dart';
import 'package:todo_app_algoriza_task/features/add_task/pages/add_task_screen.dart';
import 'package:todo_app_algoriza_task/features/home/pages/home_screen.dart';
import '../../features/schedule/pages/schedule_screen.dart';
import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rHomeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case AppRouterNames.rAddTaskRoute:
        return MaterialPageRoute(
          builder: (_) => AddTaskScreen(),
        );
        case AppRouterNames.rScheduleRoute:
        return MaterialPageRoute(
          builder: (_) => ScheduleScreen(),
        );
      default:
        return null;
    }
  }
}
