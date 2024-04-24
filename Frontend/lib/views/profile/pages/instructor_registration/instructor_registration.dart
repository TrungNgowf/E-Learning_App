import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/profile/pages/instructor_registration/bloc/instructor_registration_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'instructor_registration_controller.dart';

class InstructorRegistration extends StatefulWidget {
  const InstructorRegistration({super.key});

  @override
  State<InstructorRegistration> createState() => _InstructorRegistrationState();
}

class _InstructorRegistrationState extends State<InstructorRegistration> {
  final InstructorRegistrationController _controller =
      const InstructorRegistrationController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<TextEditingController> aboutControllers = [TextEditingController()];
  List<TextEditingController> qualificationControllers = [
    TextEditingController()
  ];
  List<TextEditingController> experimentControllers = [TextEditingController()];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.swp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(3.shp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: ReusableText(
                      "Fill in\nthe form below\nto become an instructor",
                      style: appStyle(size: 20, color: Colors.grey.shade600),
                      textAlign: TextAlign.start,
                      maxLines: 3,
                    ),
                  ),
                  Gap(2.shp),
                  Expanded(
                      flex: 1,
                      child: Image.asset(Assets.imagesInstructorRegister)),
                ],
              ),
              Gap(2.shp),
              registerBlock(),
              Gap(2.shp),
              CustomButton(
                text: "Submit",
                width: 100.swp,
                height: 6.shp,
                backGroundColor: AppColors.mainBlue,
                textColor: Colors.white,
                onTap: () {
                  if (formKey.currentState!.saveAndValidate()) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Success"),
                            content: textMethod(),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("OK"),
                              )
                            ],
                          );
                        });
                  }
                },
              ),
              Gap(1.shp),
              CustomButton(
                text: "Cancel",
                width: 100.swp,
                height: 6.shp,
                backGroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                onTap: () {
                  Get.back();
                },
              ),
              Gap(2.shp),
            ],
          ),
        ),
      ),
    );
  }

  Widget textMethod() {
    return Html(
      data: _controller.generateHtml(aboutControllers),
    );
  }

  Widget registerBlock() {
    return BlocBuilder<InstructorRegistrationBloc, InstructorRegistrationState>(
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(1.shp),
                  CustomTextField(
                    name: 'fullname',
                    label: 'Full Name',
                    initialValue: Global.storageService.currentUser!.username,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Gap(2.shp),
                  CustomTextField(
                    name: 'email',
                    label: 'Email',
                    enabled: false,
                    initialValue: Global.storageService.currentUser!.email,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Gap(2.shp),
                  const CustomTextField(
                    name: 'contact-link',
                    label: 'Contact Link',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Gap(2.shp),
                  ReusableText("About",
                      style: appStyle(size: 17, fw: FontWeight.w500)),
                  Column(
                    children: List.generate(
                      state.aboutQuantity,
                      (index) {
                        return infoItem(
                          'about${index + 1}',
                          'About ${index + 1}',
                          index,
                          aboutControllers[index],
                          onDelete: () {
                            context.read<InstructorRegistrationBloc>().add(
                                AboutQuantityEvent(context
                                        .read<InstructorRegistrationBloc>()
                                        .state
                                        .aboutQuantity -
                                    1));
                            aboutControllers.removeAt(index);
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
                          context.read<InstructorRegistrationBloc>().add(
                              AboutQuantityEvent(context
                                      .read<InstructorRegistrationBloc>()
                                      .state
                                      .aboutQuantity +
                                  1));
                          aboutControllers.add(TextEditingController());
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
                  Gap(2.shp),
                  ReusableText("Qualification",
                      style: appStyle(size: 17, fw: FontWeight.w500)),
                  Column(
                    children: List.generate(
                      state.qualificationQuantity,
                      (index) {
                        return infoItem(
                            'qualification${index + 1}',
                            'Qualification ${index + 1}',
                            index,
                            qualificationControllers[index], onDelete: () {
                          context.read<InstructorRegistrationBloc>().add(
                              QualificationQuantityEvent(context
                                      .read<InstructorRegistrationBloc>()
                                      .state
                                      .qualificationQuantity -
                                  1));
                          qualificationControllers.removeAt(index);
                        });
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
                          context.read<InstructorRegistrationBloc>().add(
                              QualificationQuantityEvent(context
                                      .read<InstructorRegistrationBloc>()
                                      .state
                                      .qualificationQuantity +
                                  1));
                          qualificationControllers.add(TextEditingController());
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
                  Gap(2.shp),
                  ReusableText("Teaching experience",
                      style: appStyle(size: 17, fw: FontWeight.w500)),
                  Column(
                    children: List.generate(
                      state.experienceQuantity,
                      (index) {
                        return infoItem(
                            'experience${index + 1}',
                            'Experience ${index + 1}',
                            index,
                            experimentControllers[index], onDelete: () {
                          context.read<InstructorRegistrationBloc>().add(
                              ExperienceQuantityEvent(context
                                      .read<InstructorRegistrationBloc>()
                                      .state
                                      .experienceQuantity -
                                  1));
                          experimentControllers.removeAt(index);
                        });
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
                          context.read<InstructorRegistrationBloc>().add(
                              ExperienceQuantityEvent(context
                                      .read<InstructorRegistrationBloc>()
                                      .state
                                      .experienceQuantity +
                                  1));
                          experimentControllers.add(TextEditingController());
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row addingRow({Function? onPressed}) {
    return Row(
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
          onPressed: () => onPressed,
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
}
