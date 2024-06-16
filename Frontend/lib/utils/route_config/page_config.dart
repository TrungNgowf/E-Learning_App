import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/course/course_detail/course_detail_view.dart';
import 'package:e_learning_app/views/course/course_library/course_library.dart';
import 'package:e_learning_app/views/course/course_library/enrolled_courses/enrolled_courses_view.dart';
import 'package:e_learning_app/views/course/course_library/enrolled_courses/pages/course_lesson/bloc/course_lesson_bloc.dart';
import 'package:e_learning_app/views/course/course_library/enrolled_courses/pages/course_lesson/course_lesson_view.dart';
import 'package:e_learning_app/views/course/course_library/favorite_courses/favorite_courses_view.dart';
import 'package:e_learning_app/views/home/bloc/home_bloc.dart';
import 'package:e_learning_app/views/home/home_view.dart';
import 'package:e_learning_app/views/instructor/created_courses/pages/adding_course/adding_course_view.dart';
import 'package:e_learning_app/views/instructor/created_courses/pages/adding_course/bloc/adding_course_bloc.dart';
import 'package:e_learning_app/views/instructor/created_courses/pages/course_preview/course_preview_view.dart';
import 'package:e_learning_app/views/log_in/bloc/log_in_bloc.dart';
import 'package:e_learning_app/views/log_in/log_in_view.dart';
import 'package:e_learning_app/views/navigation/bloc/navigation_bloc.dart';
import 'package:e_learning_app/views/navigation/navigation_page_view.dart';
import 'package:e_learning_app/views/online/online_view.dart';
import 'package:e_learning_app/views/online/pages/chatting/chatting_view.dart';
import 'package:e_learning_app/views/online/pages/streaming/bloc/streaming_bloc.dart';
import 'package:e_learning_app/views/online/pages/streaming/streaming_view.dart';
import 'package:e_learning_app/views/profile/bloc/profile_bloc.dart';
import 'package:e_learning_app/views/profile/pages/instructor_registration/bloc/instructor_registration_bloc.dart';
import 'package:e_learning_app/views/profile/pages/instructor_registration/instructor_registration_view.dart';
import 'package:e_learning_app/views/profile/pages/setting/setting_view.dart';
import 'package:e_learning_app/views/profile/profile_view.dart';
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
      PageEntity(
        route: Routes.HOME,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (_) => HomeBloc(),
        ),
      ),
      PageEntity(
        route: Routes.PROFILE,
        page: const ProfilePage(),
        bloc: BlocProvider(
          create: (_) => ProfileBloc(),
        ),
      ),
      PageEntity(
        route: Routes.SETTINGS,
        page: const SettingPage(),
      ),
      PageEntity(
          route: Routes.INSTRUCTOR_REGISTRATION,
          page: const InstructorRegistration(),
          bloc: BlocProvider(create: (_) => InstructorRegistrationBloc())),
      PageEntity(
        route: Routes.ADDING_COURSE,
        page: const AddingNewCourse(),
        bloc: BlocProvider(
          create: (_) => AddingCourseBloc(),
        ),
      ),
      PageEntity(
        route: Routes.COURSE_PREVIEW,
        page: const CoursePreview(),
      ),
      PageEntity(route: Routes.ONLINE, page: const OnlinePage()),
      PageEntity(
        route: Routes.CHATTING,
        page: const ChattingPage(),
      ),
      PageEntity(
          route: Routes.STREAMING,
          page: const StreamingPage(),
          bloc: BlocProvider(create: (_) => StreamingBloc())),
      PageEntity(
        route: Routes.COURSE_DETAIL,
        page: const CourseDetail(),
      ),
      PageEntity(
        route: Routes.COURSES_LIBRARY,
        page: const CourseLibrary(),
      ),
      PageEntity(
        route: Routes.FAVORITE_COURSES,
        page: const FavoriteCoursesView(),
      ),
      PageEntity(
        route: Routes.ENROLLED_COURSES,
        page: const EnrolledCoursesView(),
      ),
      PageEntity(
        route: Routes.COURSE_LESSON,
        page: const CourseLessonView(),
        bloc: BlocProvider(
          create: (_) => CourseLessonBloc(),
        ),
      )
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
