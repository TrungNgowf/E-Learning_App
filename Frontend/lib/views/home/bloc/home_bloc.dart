import 'package:bloc/bloc.dart';
import 'package:e_learning_app/constants/enum.dart';
import 'package:e_learning_app/models/course/course_card_for_home_page.dart';
import 'package:e_learning_app/repositories/home/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository = HomeRepository();

  HomeBloc() : super(const HomeState()) {
    on<FetchHomeData>((event, emit) async {
      await fetchHomeData(event, emit);
    });
    on<ChangePreviewIndex>((event, emit) async {
      await changePreviewIndex(event, emit);
    });
  }

  Future fetchHomeData(FetchHomeData event, Emitter<HomeState> emit) async {
    await _homeRepository.getCoursesPreviewForHomePage(0).then((homeData) {
      emit(state.copyWith(
          indexPreview: 0,
          previewList: homeData,
          apiStatus: ApiStatus.success));
    }).catchError((e) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    });
  }

  Future changePreviewIndex(
      ChangePreviewIndex event, Emitter<HomeState> emit) async {
    // emit(state.copyWith(apiStatus: ApiStatus.loading));
    await _homeRepository
        .getCoursesPreviewForHomePage(event.index)
        .then((homeData) {
      emit(state.copyWith(
          indexPreview: event.index,
          previewList: homeData,
          apiStatus: ApiStatus.success));
    }).catchError((e) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    });
  }
}
