import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add this import
import 'package:repositories/core/routing/routers.dart';
import 'package:repositories/features/home_screen/presentaion/screens/home_screen.dart';

import '../../features/home_screen/presentaion/cubit/repository_cubit.dart';
import '../dependacy_injection/injection.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CubitRepository>(),
            child: const HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("No route defined ${settings.name}")),
          ),
        );
    }
  }
}
