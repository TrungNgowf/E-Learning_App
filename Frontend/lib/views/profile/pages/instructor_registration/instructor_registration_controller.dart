import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/repositories/profile/profile_repository.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/navigation/bloc/navigation_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InstructorRegistrationController {
  InstructorRegistrationController();

  final ProfileRepository _profileRepository = ProfileRepository();

  Future submitForm(Map<String, dynamic> map, String about,
      String qualifications, String experience) async {
    showDialog(
        context: Get.context!,
        builder: (context) => LoadingAnimationWidget.inkDrop(
            color: AppColors.mainBlue, size: 10.swp));
    try {
      final credential = FirebaseAuth.instance.currentUser!;
      await credential.updateDisplayName(map['fullName']);
      var input = {
        'fullName': map['fullName'],
        'contactInfo': map['contact-info'],
        'about': about,
        'qualifications': qualifications,
        'experience': experience,
      };
      final response = await _profileRepository.updateToInstructor(input);
      if (response) {
        CustomToast.success('Success',
            'Instructor registration successful!\nPlease login again to continue.',
            duration: 5);
        logout();
      }
    } catch (e) {
      Navigator.of(Get.context!, rootNavigator: true).pop();
      CustomToast.error('Error', e.toString());
    }
  }

  void logout() {
    Global.storageService.logout();
    Get.context!.read<NavigationBloc>().add(NavigationPageChanged(page: 0));
    Get.offNamedUntil(Routes.LOGIN, (route) => false);
  }
}
