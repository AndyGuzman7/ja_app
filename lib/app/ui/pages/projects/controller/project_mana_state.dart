import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'project_mana_state.freezed.dart';

@freezed
class ProjectManaState with _$ProjectManaState {
  factory ProjectManaState({
    @Default('') String idUser,
    @Default(false) bool isExistBrochureSubscripcion,
    @Default('') String idBrochure,
    @Default('') String canceledAmount,
    @Default([]) List<String> listCanceledAmountHistory,
  }) = _ProjectManaState;

  static ProjectManaState get initialState => ProjectManaState();
}
