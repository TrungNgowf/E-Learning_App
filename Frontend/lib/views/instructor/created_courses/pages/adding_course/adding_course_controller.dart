import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:e_learning_app/utils/api_config/cloudinary_util.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/utils/storage_service.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'bloc/adding_course_bloc.dart';

class AddingCourseController {
  AddingCourseController();

  final ImagePicker picker = ImagePicker();
  CourseRepository repository = CourseRepository();
  var dollarFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  Future pickThumbnailImage() async {
    final returnedImage = await picker.pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      Get.context!
          .read<AddingCourseBloc>()
          .add(PickThumbnailImage(File(returnedImage.path)));
    }
  }

  Future pickVideoLesson(int index) async {
    final returnedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (returnedVideo != null) {
      Get.context!
          .read<AddingCourseBloc>()
          .add(PickLessonVideo(null, null, index));
      var finalFile = File(returnedVideo.path);
      var videoController = VideoPlayerController.file(finalFile);
      await videoController.initialize().then((value) {
        Get.context!.read<AddingCourseBloc>().add(PickLessonVideo(
            FlickManager(
              videoPlayerController: videoController,
            ),
            finalFile,
            index));
      });
    }
  }

  Future clearVideoLesson(int index) async {
    Get.context!
        .read<AddingCourseBloc>()
        .state
        .lessonVideos
        .elementAt(index)!
        .flickControlManager!
        .pause();
    Get.context!
        .read<AddingCourseBloc>()
        .state
        .lessonVideos
        .elementAt(index)!
        .flickVideoManager!
        .dispose();
    Get.context!
        .read<AddingCourseBloc>()
        .add(PickLessonVideo(null, null, index));
  }

  void disposeState() {
    Get.context!.read<AddingCourseBloc>().add(InitialSetup());
  }

  Future uploadCourse(
      Map formData,
      List<int> tags,
      String whatYouWillLearn,
      String requirements,
      String includes,
      List<TextEditingController> lessonTitles,
      List<TextEditingController> lessonDescriptions) async {
    ValueNotifier<double> progress = ValueNotifier(0);
    showDialog(
        context: Get.context!,
        builder: (context) => Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReusableText(
                      'Uploading course...',
                      style: appStyle(size: 18),
                    ),
                    Gap(1.shp),
                    ValueListenableBuilder(
                      valueListenable: progress,
                      builder: (context, value, child) {
                        return SimpleCircularProgressBar(
                          valueNotifier: progress,
                          mergeMode: true,
                          onGetText: (double value) {
                            return Text('${value.toInt()}%',
                                style: appStyle(size: 18));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ));
    var state = Get.context!.read<AddingCourseBloc>().state;
    String thumbnailUrl = '';
    List<Map> lessons = [];
    for (var (index, element) in state.lessonVideos.indexed) {
      if (element != null) {
        var duration = element.flickVideoManager!.videoPlayerValue!.duration;
        var response = await CloudinaryUtil.cloudinary.uploadFileInChunks(
          CloudinaryFile.fromFile(
            state.lessonFiles[index]!.path,
            publicId: "Lesson${index + 1}",
            folder:
                '${CloudinaryUtil.courseLessonsFolder}/UID_${Global.storageService.prefs.getInt(AppStorageService.USER_ID)}/${formData['title']}',
          ),
          chunkSize: 6000000,
          onProgress: (count, total) {
            progress.value = count / total / state.lessonVideos.length * 100 +
                100 / state.lessonVideos.length * index;
          },
        );
        if (response != null) {
          lessons.add({
            'title': lessonTitles[index].text,
            'description': lessonDescriptions[index].text,
            'videoUrl': response.secureUrl,
            'duration': duration.inSeconds,
          });
        }
      }
    }
    if (state.thumbnail == null) {
      thumbnailUrl = await getVideoThumbnail(
          state.lessonFiles.first!.path, formData['title']);
    } else {
      var result = await CloudinaryUtil.cloudinary.uploadFileInChunks(
        CloudinaryFile.fromFile(
          state.thumbnail!.path,
          publicId: 'thumbnail',
          folder:
              '${CloudinaryUtil.courseThumbnailsFolder}/${Global.storageService.prefs.getInt(AppStorageService.USER_ID)}/${formData['title']}',
        ),
      );
      thumbnailUrl = result!.secureUrl;
    }
    var course = {
      'title': formData['title'],
      'description': formData['description'],
      'price': dollarFormat.parse(formData['price']),
      'categoriesId': tags,
      'thumbnail': thumbnailUrl,
      'whatYouWillLearn': whatYouWillLearn,
      'requirements': requirements,
      'includes': includes,
      'lessons': lessons,
    };
    print(course);
    await repository.createCourse(course).then((value) {
      Get.back();
      if (value) {
        CustomToast.success('Success', 'Course uploaded successfully');
      }
    }).catchError((e) {
      Get.back();
      CustomToast.error('Error', e.toString());
    });
  }

  Future<String> getVideoThumbnail(String videoUrl, String title) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.PNG,
      maxWidth: 512,
      quality: 50,
    );
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/imageTemp.png').create();
    file.writeAsBytesSync(uint8list as List<int>);
    var result = await CloudinaryUtil.cloudinary.uploadFileInChunks(
      CloudinaryFile.fromFile(
        file.path,
        publicId: 'thumbnail',
        folder:
            '${CloudinaryUtil.courseThumbnailsFolder}/${Global.storageService.prefs.getInt(AppStorageService.USER_ID)}/$title',
      ),
    );
    return result!.secureUrl;
  }
}
