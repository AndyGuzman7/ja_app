import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';

part 'project_mana_state.freezed.dart';

@freezed
class ProjectManaState with _$ProjectManaState {
  factory ProjectManaState({
    @Default('') String idUser,
    @Default(false) bool isExistBrochureSubscripcion,
    @Default('') String idBrochure,
    @Default('0') String canceledAmount,
    @Default(null) Brochure? brochure,
    @Default(null) BrochureSubscription? brochureSubscription,
    @Default([]) List<String> listCanceledAmountHistory,
  }) = _ProjectManaState;

  static ProjectManaState get initialState => ProjectManaState();
}
