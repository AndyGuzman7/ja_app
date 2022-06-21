import 'package:flutter/material.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../pages/splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes =>
    {Routes.SPLASH: (_) => SplashPage()};
