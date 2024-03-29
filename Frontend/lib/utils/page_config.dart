import 'package:e_learning_app/main.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/log_in/bloc/log_in_bloc.dart';
import 'package:e_learning_app/views/log_in/log_in_view.dart';
import 'package:e_learning_app/views/navigation/bloc/navigation_bloc.dart';
import 'package:e_learning_app/views/navigation/navigation_page_view.dart';
import 'package:e_learning_app/views/sign_up/bloc/sign_up_bloc.dart';
import 'package:e_learning_app/views/sign_up/sign_up_view.dart';
import 'package:e_learning_app/views/welcome/welcome.view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPages {
  static List<PageEntity> pageRoutes() {
    return [
      PageEntity(
        route: Routes.INITIAL,
        page: const WelcomeScreen(),
      ),
      PageEntity(
        route: Routes.LOGIN,
        page: const LogInPage(),
        bloc: BlocProvider(
          create: (_) => LogInBloc(),
        ),
      ),
      PageEntity(
          route: Routes.SIGNUP,
          page: const SignUpPage(),
          bloc: BlocProvider(create: (_) => SignUpBloc())),
      PageEntity(
        route: Routes.NAVPAGE,
        page: const NavigationPage(),
        bloc: BlocProvider(
          create: (_) => NavigationBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in pageRoutes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    final String routeName = settings.name!;
    PageEntity page = pageRoutes().firstWhere(
      (page) => page.route == routeName,
      orElse: () =>
          pageRoutes().firstWhere((page) => page.route == Routes.LOGIN),
    );
    if (page.route == Routes.INITIAL &&
        Global.storageService.haveOpenedBefore) {
      if (Global.storageService.isLoggedIn) {
        return MaterialPageRoute(
          builder: (_) => const NavigationPage(),
          settings: settings,
        );
      }
      return MaterialPageRoute(
        builder: (_) => const LogInPage(),
        settings: settings,
      );
    }
    return MaterialPageRoute(
      builder: (_) => page.page,
      settings: settings,
    );
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
