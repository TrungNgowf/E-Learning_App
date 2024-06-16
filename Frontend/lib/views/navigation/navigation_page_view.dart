import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/course/course_library/course_library.dart';
import 'package:e_learning_app/views/home/home_view.dart';
import 'package:e_learning_app/views/instructor/created_courses/created_courses_view.dart';
import 'package:e_learning_app/views/online/online_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation_bloc.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.mainBlue,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: _buildPage(context.read<NavigationBloc>().state.currentPage),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: AppColors.mainBlue,
              buttonBackgroundColor: AppColors.mainBlue,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              height: 70,
              items: <Widget>[
                const Icon(Icons.home, size: 30, color: Colors.white),
                const Icon(Icons.search, size: 30, color: Colors.white),
                if (Global.storageService.isInstructor)
                  const Icon(Icons.add, size: 30, color: Colors.white),
                const Icon(Icons.voice_chat_rounded,
                    size: 30, color: Colors.white),
                const ImageIcon(
                  AssetImage(Assets.iconsOnlineCourse),
                  size: 30,
                  color: Colors.white,
                ),
              ],
              onTap: (index) async {
                context
                    .read<NavigationBloc>()
                    .add(NavigationPageChanged(page: index));
              },
            ),
          ),
        );
      },
    );
  }
}

Widget _buildPage(int index) {
  List<Widget> pages = <Widget>[
    const HomePage(),
    Center(
      child: ReusableText(
        "Search",
        style: appStyle(color: AppColors.mainBlue),
      ),
    ),
    if (Global.storageService.isInstructor) const CreatedCourses(),
    const OnlinePage(),
    const CourseLibrary(),
  ];
  return pages[index];
}
