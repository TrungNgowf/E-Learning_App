import 'package:bloc/bloc.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

part 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  ChattingCubit() : super(ChattingInitial()) {
    connectZIMKit();
  }

  Future connectZIMKit() async {
    emit(ChattingConnecting());
    var result = await ZIMKit().connectUser(
      id: Global.storageService.currentUser!.userId.toString(),
      name: Global.storageService.currentUser!.username,
      avatarUrl:
          'https://res.cloudinary.com/sofiathefck/image/upload/v1711822395/e_learning/common/male_default_avatar.jpg',
    );
    emit(ChattingConnected());
  }
}
