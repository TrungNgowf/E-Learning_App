part of 'home_bloc.dart';

@immutable
class HomeState {
  final ApiStatus apiStatus;
  final int indexPreview;
  final List<CourseCardForHomePage> previewList;

  const HomeState(
      {this.apiStatus = ApiStatus.loading,
      this.indexPreview = 0,
      this.previewList = const []});

  HomeState copyWith({
    ApiStatus? apiStatus,
    int? indexPreview,
    List<CourseCardForHomePage>? previewList,
  }) {
    return HomeState(
      apiStatus: apiStatus ?? this.apiStatus,
      indexPreview: indexPreview ?? this.indexPreview,
      previewList: previewList ?? this.previewList,
    );
  }
}
