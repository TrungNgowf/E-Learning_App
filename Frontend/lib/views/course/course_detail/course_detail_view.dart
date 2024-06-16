import 'package:chips_choice/chips_choice.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/utils/helpers/app_helpers.dart';
import 'package:e_learning_app/views/course/course_detail/course_detail_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:quickalert/quickalert.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'course_detail_cubit.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  final CourseDetailCubit _courseDetailCubit = CourseDetailCubit();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  var courseId = Get.arguments;

  @override
  void initState() {
    _courseDetailCubit.getCourseDetail(courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CourseDetailProvider());
    return Scaffold(
      appBar: CustomAppbar(title: 'Course Detail'),
      body: BlocBuilder<CourseDetailCubit, CourseDetailState>(
        bloc: _courseDetailCubit,
        builder: (context, state) {
          if (state is CourseDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseDetailLoaded) {
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
                              ReusableText(state.course.author.name,
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
                          Gap(2.shp),
                          ReusableText('Instructor',
                              style: appStyle(size: 16, fw: FontWeight.w500)),
                          Gap(2.shp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    state.course.author.profilePicture,
                                    width: 30.swp,
                                    height: 30.swp,
                                    fit: BoxFit.fill),
                              ),
                              Gap(8.swp),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(state.course.author.name,
                                      style: appStyle(
                                          size: 18, fw: FontWeight.w500)),
                                  Gap(0.5.shp),
                                  ReusableText(state.course.author.contactInfo,
                                      style: appStyle(
                                          size: 15, fw: FontWeight.w300)),
                                  Gap(0.5.shp),
                                  ReusableText(
                                      '${state.course.author.totalCourses} courses available',
                                      style: appStyle(
                                          size: 15, fw: FontWeight.w300)),
                                  Gap(0.5.shp),
                                  OutlinedButton.icon(
                                    onPressed: () async {
                                      await ZIMKit()
                                          .connectUser(
                                            id: Global.storageService
                                                .currentUser!.userId
                                                .toString(),
                                            name: Global.storageService
                                                .currentUser!.username,
                                            avatarUrl:
                                                'https://res.cloudinary.com/sofiathefck/image/upload/v1711822395/e_learning/common/male_default_avatar.jpg',
                                          )
                                          .then((zim) => {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return ZIMKitMessageListPage(
                                                    conversationID: state
                                                        .course.author.id
                                                        .toString(),
                                                    conversationType:
                                                        ZIMConversationType
                                                            .peer,
                                                    messageItemBuilder:
                                                        (context, message,
                                                            defaultWidget) {
                                                      return Theme(
                                                        data: ThemeData(
                                                            primaryColor:
                                                                AppColors
                                                                    .mainBlue),
                                                        child: defaultWidget,
                                                      );
                                                    },
                                                    inputDecoration:
                                                        const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Type a message'),
                                                  );
                                                }))
                                              });
                                    },
                                    label: ReusableText('Chat now',
                                        style: appStyle(
                                            color: AppColors.iosBlue,
                                            size: 15,
                                            fw: FontWeight.w500)),
                                    icon: const Icon(
                                        FontAwesomeIcons.solidMessage,
                                        size: 15,
                                        color: AppColors.iosBlue),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.iosBlue),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  )
                                ],
                              ),
                            ],
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
                          Expanded(
                              flex: 3,
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!state.course.isPurchased) {
                                      _courseDetailCubit
                                          .getAccountBalance()
                                          .then((value) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.confirm,
                                          title: 'Confirm enrollment',
                                          text:
                                              'Your account balance is \$${value.toString()}\nDo you want to enroll this course?',
                                          confirmBtnText: 'Confirm',
                                          cancelBtnText: 'Cancel',
                                          confirmBtnColor: Colors.green,
                                          showCancelBtn: true,
                                          onCancelBtnTap: () {
                                            Get.back();
                                          },
                                          onConfirmBtnTap: () async {
                                            if (value >=
                                                state.course.coursePrice) {
                                              await _courseDetailCubit
                                                  .enrollCourse(state.course.id)
                                                  .then((val) {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.success,
                                                  title:
                                                      'Enrolled successfully',
                                                  text:
                                                      'You have successfully enrolled this course',
                                                  confirmBtnText: 'OK',
                                                  confirmBtnColor: Colors.green,
                                                  showCancelBtn: false,
                                                  onConfirmBtnTap: () {
                                                    Get
                                                      ..back()
                                                      ..back();
                                                  },
                                                );
                                              });
                                            } else {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: 'Insufficient balance',
                                                text:
                                                    'Your account balance is not enough to enroll this course',
                                                confirmBtnText: 'OK',
                                                confirmBtnColor: Colors.red,
                                                showCancelBtn: false,
                                                onConfirmBtnTap: () {
                                                  Get
                                                    ..back()
                                                    ..back();
                                                },
                                              );
                                            }
                                          },
                                        );
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth,
                                    color: state.course.isPurchased
                                        ? AppColors.mainGreen
                                        : AppColors.mainBlue,
                                    child: Center(
                                      child: state.course.isPurchased
                                          ? ReusableText('Enrolled',
                                              style: appStyle(
                                                  size: 16,
                                                  fw: FontWeight.w600,
                                                  color: Colors.white))
                                          : ReusableText('Enroll now',
                                              style: appStyle(
                                                  size: 16,
                                                  fw: FontWeight.w600,
                                                  color: Colors.white)),
                                    ),
                                  ),
                                );
                              })),
                          Expanded(
                              flex: 1,
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Container(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                  color: Colors.white,
                                  child: Center(
                                    // child: GestureDetector(
                                    //   onTap: () {
                                    //     state.course.isLiked
                                    //         ? _courseDetailCubit
                                    //             .unlikeCourse(state.course.id)
                                    //         : _courseDetailCubit
                                    //             .likeCourse(state.course.id);
                                    //   },
                                    //   child: state.course.isLiked
                                    //       ? const Icon(
                                    //           Icons.favorite,
                                    //           color: AppColors.mainBlue,
                                    //           size: 30,
                                    //         )
                                    //       : const Icon(
                                    //           Icons.favorite_border,
                                    //           color: AppColors.mainBlue,
                                    //           size: 30,
                                    //         ),
                                    // ),
                                    child: LikeButton(
                                      isLiked: state.course.isLiked,
                                      onTap: (value) {
                                        state.course.isLiked
                                            ? _courseDetailCubit
                                                .unlikeCourse(state.course.id)
                                            : _courseDetailCubit
                                                .likeCourse(state.course.id);
                                        return Future.value(!value);
                                      },
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ))
              ],
            );
          } else if (state is CourseDetailError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
