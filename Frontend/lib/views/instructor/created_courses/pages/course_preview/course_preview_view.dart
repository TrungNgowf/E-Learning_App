import 'package:chips_choice/chips_choice.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/utils/helpers/app_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'course_preview_cubit.dart';

class CoursePreview extends StatefulWidget {
  const CoursePreview({super.key});

  @override
  State<CoursePreview> createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  final CoursePreviewCubit _coursePreviewCubit = CoursePreviewCubit();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Course Preview'),
      body: BlocBuilder<CoursePreviewCubit, CoursePreviewState>(
        bloc: _coursePreviewCubit,
        builder: (context, state) {
          if (state is CoursePreviewLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoursePreviewLoaded) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.swp),
                    height: 85.shp,
                    width: 100.swp,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(state.course.thumbnail,
                                  width: 90.swp,
                                  height: 50.swp,
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Gap(1.shp),
                          ReusableText(
                            state.course.title,
                            textAlign: TextAlign.left,
                            style: appStyle(size: 20, fw: FontWeight.w600),
                          ),
                          Gap(0.5.shp),
                          ReusableText(
                            state.course.description,
                            textAlign: TextAlign.left,
                            style: appStyle(size: 16, fw: FontWeight.w300),
                          ),
                          Gap(2.shp),
                          ReusableText(
                            state.course.coursePrice == 0
                                ? 'Free'
                                : '\$${state.course.coursePrice}',
                            style: appStyle(
                                size: 23,
                                color: AppColors.mainBlue,
                                fw: FontWeight.w500),
                          ),
                          Gap(2.shp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const FaIcon(FontAwesomeIcons.userPen,
                                  size: 15, color: AppColors.mainBlue),
                              Gap(2.swp),
                              ReusableText(state.course.author,
                                  textAlign: TextAlign.end,
                                  style:
                                      appStyle(size: 14, fw: FontWeight.w300)),
                            ],
                          ),
                          Gap(1.shp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const FaIcon(FontAwesomeIcons.solidClock,
                                  size: 15, color: AppColors.mainBlue),
                              Gap(2.swp),
                              ReusableText(
                                  "Created at ${formatter.format(state.course.creationTime)}",
                                  textAlign: TextAlign.end,
                                  style:
                                      appStyle(size: 14, fw: FontWeight.w300)),
                            ],
                          ),
                          Gap(2.shp),
                          SizedBox(
                            width: 90.swp,
                            child: ChipsChoice<String>.multiple(
                                value: const [],
                                wrapped: true,
                                padding: EdgeInsets.zero,
                                choiceCheckmark: true,
                                choiceStyle: C2ChipStyle.when(
                                  enabled: const C2ChipStyle(
                                      checkmarkColor: AppColors.mainBlue,
                                      borderColor: AppColors.mainBlue,
                                      borderStyle: BorderStyle.solid,
                                      foregroundColor: AppColors.mainBlue,
                                      backgroundColor: Colors.white),
                                ),
                                choiceItems: C2Choice.listFrom<String, String>(
                                  source: state.course.categories,
                                  value: (i, v) => v,
                                  label: (i, v) => v,
                                ),
                                onChanged: (val) {},
                                leading: ReusableText('Categories:',
                                    style: appStyle(
                                        size: 15, fw: FontWeight.w400))),
                          ),
                          Gap(2.shp),
                          ReusableText('What you will learn',
                              style: appStyle(size: 16, fw: FontWeight.w500)),
                          SizedBox(
                              width: 90.swp,
                              child: Html(
                                  data: state.course.whatYouWillLearn,
                                  style: {
                                    "body": Style(
                                        fontSize: FontSize(16),
                                        fontWeight: FontWeight.w400,
                                        padding: HtmlPaddings.zero,
                                        margin: Margins.zero)
                                  })),
                          Gap(1.shp),
                          ReusableText('Requirements',
                              style: appStyle(size: 16, fw: FontWeight.w500)),
                          SizedBox(
                              width: 90.swp,
                              child:
                                  Html(data: state.course.requirements, style: {
                                "body": Style(
                                    fontSize: FontSize(16),
                                    fontWeight: FontWeight.w400,
                                    padding: HtmlPaddings.zero,
                                    margin: Margins.zero)
                              })),
                          Gap(1.shp),
                          ReusableText('Includes',
                              style: appStyle(size: 16, fw: FontWeight.w500)),
                          SizedBox(
                              width: 90.swp,
                              child: Html(data: state.course.includes, style: {
                                "body": Style(
                                    fontSize: FontSize(16),
                                    fontWeight: FontWeight.w400,
                                    padding: HtmlPaddings.zero,
                                    margin: Margins.zero)
                              })),
                          Gap(1.shp),
                          ReusableText('Course content',
                              style: appStyle(size: 16, fw: FontWeight.w500)),
                          Row(
                            children: [
                              ReusableText(
                                  '${state.course.lessons.length} lessons',
                                  style:
                                      appStyle(size: 13, fw: FontWeight.w300)),
                              Gap(2.swp),
                              const Icon(Icons.circle,
                                  size: 5, color: AppColors.mainBlue),
                              Gap(2.swp),
                              ReusableText(
                                  'Total ${state.course.totalDuration} hours',
                                  style:
                                      appStyle(size: 13, fw: FontWeight.w300)),
                            ],
                          ),
                          Gap(1.shp),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                state.course.lessons.length,
                                (index) => ListTile(
                                      leading: ReusableText('${index + 1}',
                                          style: appStyle(
                                              size: 16, fw: FontWeight.w500)),
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: ReusableText(
                                                state.course.lessons[index]
                                                    .title,
                                                textAlign: TextAlign.left,
                                                style: appStyle(
                                                    size: 15,
                                                    fw: FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        children: [
                                          ReusableText(
                                              state.course.lessons[index]
                                                  .description,
                                              textAlign: TextAlign.left,
                                              style: appStyle(
                                                  size: 13,
                                                  fw: FontWeight.w300)),
                                          Row(
                                            children: [
                                              const Icon(Icons.circle,
                                                  size: 5,
                                                  color: AppColors.mainBlue),
                                              Gap(1.swp),
                                              ReusableText(
                                                  " ${secondsToTime(state.course.lessons[index].duration)} mins",
                                                  textAlign: TextAlign.left,
                                                  style: appStyle(
                                                      size: 13,
                                                      fw: FontWeight.w300)),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                          Gap(7.shp)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 7.shp,
                      width: 100.swp,
                      child: Row(
                        children: [
                          Expanded(child:
                              LayoutBuilder(builder: (context, constraints) {
                            return Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              color: AppColors.mainBlue,
                              child: Center(
                                child: ReusableText('Enroll now',
                                    style: appStyle(
                                        size: 16,
                                        fw: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                            );
                          })),
                          Expanded(child:
                              LayoutBuilder(builder: (context, constraints) {
                            return Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              color: Colors.white,
                              child: Center(
                                child: ReusableText('Add to cart',
                                    style: appStyle(
                                        size: 16,
                                        fw: FontWeight.w600,
                                        color: AppColors.mainBlue)),
                              ),
                            );
                          })),
                        ],
                      ),
                    ))
              ],
            );
          } else if (state is CoursePreviewError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
