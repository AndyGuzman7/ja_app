import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton%20copy.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_functions.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/register_page.dart';
import '../../../../domain/models/tabBarUi.dart';
import '../../../global_controllers/session_controller.dart';
import '../register_page_avatar.dart';
import '../register_page_personal.dart';
import '../register_page_user.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  List<TabBarUi> listTabBar = [];
  late final RegisterFunctions registerFunctions;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState) {
    registerFunctions = RegisterFunctions(state, _sessionController);
    init();
  }
  final GlobalKey<FormState> formKeyOne = GlobalKey();

  final GlobalKey<FormState> formKeyTwo = GlobalKey();

  late TabController tabController; // =  TabController(length: 3, vsync: this);

  void init() async {
    final one = RegisterPageAvatar(
      providerListener: registerProvider,
    );

    final two = RegisterPagePersonal(
      providerListener: registerProvider,
    );

    final three = RegisterPageUser(
      providerListener: registerProvider,
    );
    listTabBar = [
      TabBarUi(
        "Mi Avatar",
        null,
        one,
        null,
      ),
      TabBarUi(
        "Mi Información",
        null,
        two,
        null,
      ),
      TabBarUi(
        "Mi Usuario",
        null,
        three,
        null,
      ),
    ];
  }

  loadUserAvatar() async {
    var listAvatars = await registerFunctions.getAvatars();
    listAvatars.first.isSelect = true;
    onListAvatarChanged(listAvatars);
    onUserAvatarChanged(listAvatars.firstWhere((element) => element.isSelect));
    log(listAvatars.firstWhere((element) => element.isSelect).url);
  }

  void onNameUserChanged(String text) {
    state = state.copyWith(userName: text);
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onNameSecondChanged(String text) {
    state = state.copyWith(nameSecond: text == "" ? null : text);
  }

  void onLastNameChanged(String text) {
    state = state.copyWith(lastName: text);
  }

  void onLastNameSecondChanged(String text) {
    state = state.copyWith(lastNameSecond: text == "" ? null : text);
  }

  void onGenderChanged(SingingCharacter text) {
    state = state.copyWith(singingCharacter: text);
  }

  void onCountryChanged(Country country) {
    state = state.copyWith(country: country);
  }

  void onPhoneChanged(String phone) {
    state = state.copyWith(phone: phone);
  }

  void onBautizatedChanged(BautizatedCharacter phone) {
    state = state.copyWith(bautizatedCharacter: phone);
  }

  void onPhotoChanged(File file) {
    state = state.copyWith(photo: file);
  }

  void onBirthDateChanged(DateTime text) {
    state = state.copyWith(birthDate: text);
  }

  void onImageURLChanged(String text) {
    state = state.copyWith(photoURL: text);
  }

  void onlastNameChanged(String text) {
    state = state.copyWith(lastName: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }

  void onTermsOkChanged(bool text) {
    state = state.copyWith(termsOk: text);
  }

  void onListAvatarChanged(List<UserAvatar> list) {
    state = state.copyWith(listAvatar: list);
  }

  void onUserAvatarChanged(UserAvatar userAvatar) {
    log("se sekecc");
    state = state.copyWith(userAvatar: userAvatar);
  }

  void onSingingCharacterChanged(SingingCharacter singingCharacter) {
    state = state.copyWith(singingCharacter: singingCharacter);
  }

  void onCodeRegisterChanged(String codeRegister) {
    state =
        state.copyWith(codeRegister: codeRegister == "" ? null : codeRegister);
  }

  onPressedBtnNextPageAvatar(BuildContext context) async {
    DefaultTabController.of(context)?.animateTo(1);
  }

  onPressedBtnCancelPageAvatar(BuildContext context) async {
    registerFunctions.closePage(context);
  }

  onPressedBtnNextPagePersonal(BuildContext context) async {
    final isValidForm = formKeyOne.currentState!.validate();
    if (isValidForm) {
      DefaultTabController.of(context)?.animateTo(2);
    }
  }

  onPressedBtnLastPagePersonal(BuildContext context) async {
    DefaultTabController.of(context)?.animateTo(0);
  }

  onPressedBtnRegisterPageUser(BuildContext context) async {
    final isValidForm = formKeyTwo.currentState!.validate();

    if (isValidForm) {
      await registerFunctions.sendRegisterForm(context, state);
    } else {
      Dialogs.alert(context, title: "ERROR", content: "Invalid fields");
    }
  }

  onPressedBtnLastPageUser(BuildContext context) async {
    DefaultTabController.of(context)?.animateTo(1);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
