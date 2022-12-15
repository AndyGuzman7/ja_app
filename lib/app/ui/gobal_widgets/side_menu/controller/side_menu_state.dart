import 'dart:io';

class SideMenuState {
  final String? imageUser;

  SideMenuState({required this.imageUser});

  static SideMenuState get initialState => SideMenuState(imageUser: null);

  SideMenuState copyWith({String? imageUser}) {
    return SideMenuState(
      imageUser: imageUser,
    );
  }
}
