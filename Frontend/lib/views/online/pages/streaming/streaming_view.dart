import 'package:bordered_text/bordered_text.dart';
import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/constants/app_secrets.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/utils/helpers/app_helpers.dart';
import 'package:e_learning_app/utils/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({super.key});

  @override
  State<StreamingPage> createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Global.storageService.isInstructor
        ? Padding(
            padding: EdgeInsets.all(3.swp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(2.shp),
                  Image.asset(
                    Assets.imagesStreamingBg,
                    width: 80.swp,
                  ),
                  Gap(2.shp),
                  ReusableText(
                    "Start a online classroom",
                    style: appStyle(
                        size: 18, color: Colors.black, fw: FontWeight.w500),
                  ),
                  Gap(1.shp),
                  ReusableText(
                    "You can start streaming your classroom here",
                    style: appStyle(
                        size: 14, color: Colors.black, fw: FontWeight.w400),
                  ),
                  Gap(2.shp),
                  ElevatedButton(
                    onPressed: () {
                      if (ZegoUIKitPrebuiltLiveStreamingController()
                          .minimize
                          .isMinimizing) {
                        /// when the application is minimized (in a minimized state),
                        /// disable button clicks to prevent multiple PrebuiltLiveStreaming components from being created.
                        return;
                      }
                      Get.to(() => LivePage(
                            liveID: generateUniqueLiveId(),
                            isHost: true,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: ReusableText(
                      "Start Streaming",
                      style: appStyle(
                          size: 14, color: Colors.white, fw: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.all(3.swp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(2.shp),
                  Image.asset(
                    Assets.imagesStreamingBg,
                    width: 80.swp,
                  ),
                  Gap(2.shp),
                  ReusableText(
                    "Joining a online classroom",
                    style: appStyle(
                        size: 18, color: Colors.black, fw: FontWeight.w500),
                  ),
                  Gap(1.shp),
                  ReusableText(
                    "Enter code of your online classroom here",
                    style: appStyle(
                        size: 14, color: Colors.black, fw: FontWeight.w400),
                  ),
                  Gap(3.shp),
                  FormBuilder(
                    key: _formKey,
                    child: SizedBox(
                      width: 60.swp,
                      child: CustomTextField(
                        name: 'liveId',
                        label: 'Enter code',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                  ),
                  Gap(1.shp),
                  CustomButton(
                      backGroundColor: AppColors.mainBlue,
                      width: 35.swp,
                      height: 6.shp,
                      child: ReusableText(
                        "Join classroom",
                        style: appStyle(
                            size: 15, color: Colors.white, fw: FontWeight.w500),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          if (ZegoUIKitPrebuiltLiveStreamingController()
                              .minimize
                              .isMinimizing) {
                            /// when the application is minimized (in a minimized state),
                            /// disable button clicks to prevent multiple PrebuiltLiveStreaming components from being created.
                            return;
                          }
                          Get.to(() => LivePage(
                                liveID: _formKey.currentState!.value['liveId'],
                                isHost: false,
                              ));
                        }
                      }),
                ],
              ),
            ),
          );
  }
}

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
  });

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  int localUserID =
      Global.storageService.prefs.getInt(AppStorageService.USER_ID)!;
  final liveStateNotifier =
      ValueNotifier<ZegoLiveStreamingState>(ZegoLiveStreamingState.idle);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
          appID: AppSecrets.zegoAppID,
          appSign: AppSecrets.zegoAppSign,
          userID: localUserID.toString(),
          userName: Global.storageService.prefs
              .getString(AppStorageService.USERNAME)!,
          liveID: widget.liveID,
          events: ZegoUIKitPrebuiltLiveStreamingEvents(
            onStateUpdated: (ZegoLiveStreamingState state) {
              liveStateNotifier.value = state;
            },
          ),
          config: widget.isHost
              ? (ZegoUIKitPrebuiltLiveStreamingConfig.host()
                    ..layout = ZegoLayout.gallery(
                        showScreenSharingFullscreenModeToggleButtonRules:
                            ZegoShowFullscreenModeToggleButtonRules.alwaysShow,
                        showNewScreenSharingViewInFullscreenMode:
                            false) //  Set the layout to gallery mode. and configure the [showNewScreenSharingViewInFullscreenMode] and [showScreenSharingFullscreenModeToggleButtonRules].
                    ..bottomMenuBar =
                        ZegoLiveStreamingBottomMenuBarConfig(hostButtons: [
                      ZegoLiveStreamingMenuBarButtonName
                          .toggleScreenSharingButton,
                      ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton,
                      ZegoLiveStreamingMenuBarButtonName.toggleCameraButton
                    ]) // Add a screen sharing toggle button.
                  )
              : (ZegoUIKitPrebuiltLiveStreamingConfig.audience()
                ..layout = ZegoLayout.gallery(
                    showScreenSharingFullscreenModeToggleButtonRules:
                        ZegoShowFullscreenModeToggleButtonRules.alwaysShow,
                    showNewScreenSharingViewInFullscreenMode:
                        false) // Set the layout to gallery mode. and configure the [showNewScreenSharingViewInFullscreenMode] and [showScreenSharingFullscreenModeToggleButtonRules].
                ..bottomMenuBar =
                    ZegoLiveStreamingBottomMenuBarConfig(hostButtons: [
                  ZegoLiveStreamingMenuBarButtonName.toggleScreenSharingButton,
                  ZegoLiveStreamingMenuBarButtonName.coHostControlButton
                ]) // Add a screen sharing toggle button.
              )
            ..confirmDialogInfo = ZegoLiveStreamingDialogInfo(
              title: "Leave confirm",
              message: "Do you want to end?",
              cancelButtonName: "Cancel",
              confirmButtonName: "Confirm",
            )
            ..foreground = Stack(
              children: [
                ValueListenableBuilder<ZegoLiveStreamingState>(
                    valueListenable: liveStateNotifier,
                    builder: (context, state, child) {
                      return state == ZegoLiveStreamingState.idle
                          ? liveIdWidget(context)
                          : liveIdWidget(context, top: 25, left: 42.swp);
                    }),
              ],
            )),
    );
  }

  Positioned liveIdWidget(BuildContext context,
      {double? top, double? left, double? right, double? bottom}) {
    return Positioned(
        top: top,
        left: left,
        right: right,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BorderedText(
              strokeWidth: 1,
              strokeColor: Colors.black,
              child: Text(widget.liveID,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
            IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.liveID))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Your roomId has been copied to clipboard!")));
                  });
                },
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.copy, size: 15, color: Colors.white)),
          ],
        ));
  }
}
