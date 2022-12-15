import 'package:flutter/material.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/home/home_page.dart';
import 'package:ja_app/app/ui/pages/login/login_page.dart';
import 'package:ja_app/app/ui/pages/login/prueba.dart';
import 'package:ja_app/app/ui/pages/navigator_botton/navigator_buttonv2.dart';
import 'package:ja_app/app/ui/pages/projects/project_mana_page.dart';
import 'package:ja_app/app/ui/pages/register/register_page.dart';
import 'package:ja_app/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:ja_app/app/ui/pages/studentes_list/students_list_page.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../pages/splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => LoginPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.REGISTER: (_) => RegisterPage(),
      Routes.RESET_PASSWORD: (_) => ResetPasswordPage(),
      Routes.LIST_ESTUDENTS: (_) => StudentsListPage(),
      Routes.PROJECTS: (_) => ProjectManaPage(),
      Routes.EESS: (_) => EeSsPage()
    };
