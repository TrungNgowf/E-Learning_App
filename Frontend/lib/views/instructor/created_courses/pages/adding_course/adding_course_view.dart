import 'package:chips_choice/chips_choice.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/common/error_block.dart';
import 'package:e_learning_app/constants/enum.dart';
import 'package:e_learning_app/models/course/course_category.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/instructor/created_courses/pages/adding_course/adding_course_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'bloc/adding_course_bloc.dart';

class AddingNewCourse extends StatefulWidget {
  const AddingNewCourse({super.key});

  @override
  State<AddingNewCourse> createState() => _AddingNewCourseState();
}

class _AddingNewCourseState extends State<AddingNewCourse> {
  AddingCourseController controller = AddingCourseController();
  List<int> tags = [];
  List<TextEditingController> whatYouWillLearnControllers = [
    TextEditingController()
  ];
  List<TextEditingController> requirementControllers = [
    TextEditingController()
  ];
  List<TextEditingController> includeControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    context.read<AddingCourseBloc>().add(FetchMasterData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Add New Course",
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              FontAwesomeIcons.xmark,
              color: Colors.black,
            )),
        trailing: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: BlocBuilder<AddingCourseBloc, AddingCourseState>(
        builder: (context, state) {
          switch (state.apiStatus) {
            case ApiStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ApiStatus.success:
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(2.swp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(2.shp),
                      const CustomTextField(
                        name: "title",
                        label: "Course Title",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Gap(2.shp),
                      const CustomTextField(
                        name: "description",
                        label: "Course Description",
                        maxLines: 3,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      Gap(2.shp),
                      FormBuilderTextField(
                        name: "price",
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Course Price",
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: appStyle(
                              size: 14,
                              color: Colors.black,
                              fw: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.mainBlue),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyTextInputFormatter.simpleCurrency()
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ]),
                      ),
                      Gap(2.shp),
                      chipsCategories(state),
                      Gap(2.shp),
                      thumbnailBlock(state),
                      Gap(2.shp),
                      infoBlock(state, context),
                      Gap(2.shp),
                      addingLessonBlock(state, context),
                    ],
                  ),
                ),
              );

            case ApiStatus.error:
              return ErrorBlock();
          }
        },
      ),
    );
  }

  Widget infoBlock(AddingCourseState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // What you will learn
        ReusableText("What you will learn",
            style: appStyle(size: 17, fw: FontWeight.w500)),
        Column(
          children: List.generate(
            state.whatYouWillLearnCount,
            (index) {
              return infoItem(
                'whatYouWillLearn${index + 1}',
                'What You Will Learn ${index + 1}',
                index,
                whatYouWillLearnControllers[index],
                onDelete: () {
                  context.read<AddingCourseBloc>().add(WhatYouWillLearnQuantity(
                      context
                              .read<AddingCourseBloc>()
                              .state
                              .whatYouWillLearnCount -
                          1));
                  whatYouWillLearnControllers.removeAt(index);
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(7.swp),
            Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<AddingCourseBloc>().add(WhatYouWillLearnQuantity(
                    context
                            .read<AddingCourseBloc>()
                            .state
                            .whatYouWillLearnCount +
                        1));
                whatYouWillLearnControllers.add(TextEditingController());
              },
              icon: const Icon(Icons.add, color: Colors.blue),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            ),
            Gap(7.swp),
          ],
        ),
        // Requirements
        ReusableText("Requirements",
            style: appStyle(size: 17, fw: FontWeight.w500)),
        Column(
          children: List.generate(
            state.requirementCount,
            (index) {
              return infoItem(
                'requirement${index + 1}',
                'Requirement ${index + 1}',
                index,
                requirementControllers[index],
                onDelete: () {
                  context.read<AddingCourseBloc>().add(RequirementQuantity(
                      context.read<AddingCourseBloc>().state.requirementCount -
                          1));
                  requirementControllers.removeAt(index);
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(7.swp),
            Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<AddingCourseBloc>().add(RequirementQuantity(
                    context.read<AddingCourseBloc>().state.requirementCount +
                        1));
                requirementControllers.add(TextEditingController());
              },
              icon: const Icon(Icons.add, color: Colors.blue),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            ),
            Gap(7.swp),
          ],
        ),

        // Included
        ReusableText("Include", style: appStyle(size: 17, fw: FontWeight.w500)),
        Column(
          children: List.generate(
            state.includeCount,
            (index) {
              return infoItem(
                'include${index + 1}',
                'Include ${index + 1}',
                index,
                includeControllers[index],
                onDelete: () {
                  context.read<AddingCourseBloc>().add(IncludeQuantity(
                      context.read<AddingCourseBloc>().state.includeCount - 1));
                  includeControllers.removeAt(index);
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(7.swp),
            Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<AddingCourseBloc>().add(IncludeQuantity(
                    context.read<AddingCourseBloc>().state.includeCount + 1));
                includeControllers.add(TextEditingController());
              },
              icon: const Icon(Icons.add, color: Colors.blue),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            ),
            Gap(7.swp),
          ],
        ),
        Gap(1.shp),
      ],
    );
  }

  Widget chipsCategories(AddingCourseState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child: ReusableText(
                "Select Course Categories",
                style: appStyle(
                    size: 15, color: Colors.black, fw: FontWeight.w300),
              ),
            ),
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            initiallyExpanded: true,
            expansionAnimationStyle: AnimationStyle(
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
              reverseDuration: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
            ),
            children: [
              ChipsChoice<int>.multiple(
                value: tags,
                wrapped: true,
                choiceCheckmark: true,
                choiceStyle: C2ChipStyle.when(
                  selected: const C2ChipStyle(
                      checkmarkColor: AppColors.mainBlue,
                      borderColor: AppColors.mainBlue,
                      borderStyle: BorderStyle.solid,
                      foregroundColor: AppColors.mainBlue,
                      backgroundColor: Colors.white),
                ),
                onChanged: (val) => setState(() => tags = val),
                choiceItems: C2Choice.listFrom<int, CourseCategory>(
                  source: state.courseCategories,
                  value: (i, v) => v.id,
                  label: (i, v) => v.title,
                ),
              ),
            ]),
      ),
    );
  }

  Widget thumbnailBlock(AddingCourseState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child: ReusableText(
                "Select Thumbnail Image",
                style: appStyle(
                    size: 15, color: Colors.black, fw: FontWeight.w300),
              ),
            ),
            expandedAlignment: Alignment.center,
            initiallyExpanded: true,
            expansionAnimationStyle: AnimationStyle(
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
              reverseDuration: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
            ),
            children: [
              Container(
                width: 70.swp,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: state.thumbnail != null
                      ? Image.file(
                          state.thumbnail!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                ),
              ),
              Gap(2.shp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade200,
                    ),
                    onPressed: () {
                      controller.pickThumbnailImage();
                    },
                    child: const ReusableText("Select Image",
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      context
                          .read<AddingCourseBloc>()
                          .add(PickThumbnailImage(null));
                    },
                    child: ReusableText(
                      "Remove Image",
                      style: appStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Gap(1.shp),
            ]),
      ),
    );
  }

  Widget infoItem(
      String name, String label, int index, TextEditingController controller,
      {Function()? onDelete}) {
    return Container(
      margin: EdgeInsets.only(top: 1.shp),
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: CustomTextField(
                name: name,
                label: label,
                controller: controller,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              )),
          Gap(2.swp),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.red.shade300))),
        ],
      ),
    );
  }

  Widget addingLessonBlock(AddingCourseState state, BuildContext context) {
    return Container();
  }
}
