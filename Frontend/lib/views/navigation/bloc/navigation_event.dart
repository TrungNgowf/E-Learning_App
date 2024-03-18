part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class NavigationPageChanged extends NavigationEvent {
  final int page;

  NavigationPageChanged({required this.page});
}
