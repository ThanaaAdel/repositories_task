
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repositories/core/routing/app_router.dart';
import 'package:repositories/core/routing/routers.dart';
import 'core/theming/theme_manager.dart';

class RepositoriesApp extends StatelessWidget {
  final AppRouter appRouter;
  const RepositoriesApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doc App',
        theme: ThemeManager.getAppTheme(),
        initialRoute: Routes.homeScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
