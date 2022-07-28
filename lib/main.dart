import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';

import 'core/cubit/bloc_observer.dart';
import 'core/router/app_router.dart';
import 'core/router/app_router_names.dart';
import 'features/home/pages/home_screen.dart';

void main() async {
  BlocOverrides.runZoned(
        () async {
      runApp(MyApp(appRouter: AppRouter()));
      },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final AppRouter appRouter;

  const MyApp({Key? key,required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeLayoutCubit()..createDatabase()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360,640),
        builder: (BuildContext context, Widget? child) { return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0
              ),
              scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Medium',

          ),
          onGenerateRoute: appRouter.onGenerateRoute,
          initialRoute: AppRouterNames.rHomeRoute,
        );},
      ),
    );
  }
}
