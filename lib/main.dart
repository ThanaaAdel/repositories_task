import 'package:flutter/material.dart';
import 'package:repositories/repository_app.dart';

import 'core/dependacy_injection/injection.dart';
import 'core/routing/app_router.dart';

void main() {
  initGetIt();
  runApp( RepositoriesApp(appRouter: AppRouter(),));
}




