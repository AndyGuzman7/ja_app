import 'dart:developer';

import 'package:ja_app/app/domain/models/church/church.dart';

class ChurchState {
  final String? photoURL;
  final String codeAccess;
  final bool isSuscribe;
  final Church? church;

  ChurchState(
      {required this.photoURL,
      required this.codeAccess,
      required this.church,
      required this.isSuscribe});

  static ChurchState get initialState => ChurchState(
      photoURL: null, codeAccess: '', isSuscribe: false, church: null);

  ChurchState copyWith({
    String? photoURL,
    String? codeAccess,
    bool? isSuscribe,
    Church? church,
  }) {
    log("asdadasd");
    return ChurchState(
      photoURL: photoURL ?? this.photoURL,
      church: church ?? this.church,
      codeAccess: codeAccess ?? this.codeAccess,
      isSuscribe: isSuscribe ?? this.isSuscribe,
    );
  }
}
