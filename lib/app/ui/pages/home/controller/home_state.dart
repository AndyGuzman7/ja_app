import 'package:ja_app/app/domain/models/user_data.dart';

class HomeState {
  final UserData? user;
  final int currentTab;
  final String title;

  HomeState({
    required this.title,
    required this.currentTab,
    required this.user,
  });

  static HomeState get initialState => HomeState(
        title: 'Inicio',
        currentTab: 0,
        user: null,
      );

  HomeState copyWith({
    UserData? user,
    int? currentTab,
    String? title,
  }) {
    return HomeState(
        currentTab: currentTab ?? this.currentTab,
        user: user ?? this.user,
        title: title ?? this.title);
  }
}
