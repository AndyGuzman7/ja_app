import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/models/resources.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/data/repositories/resources_impl/resources_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/register_impl/sign_up_repository.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton%20copy.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/utils/permisson_list.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../../data/repositories/church_impl/church_repository.dart';
import '../../../../data/repositories_impl/church/church_repository_impl.dart';
import '../register_page_avatar.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formKeyOne = GlobalKey();

  final GlobalKey<FormState> formKeyTwo = GlobalKey();

  late TabController tabController; // =  TabController(length: 3, vsync: this);

  final _signUpRepository = Get.find<SignUpRepository>();

  final _resourcesRepository = Get.find<ResourcesRepository>();
  final _church = Get.find<ChurchRepository>();

  List<UserAvatar> listAvatar = [];

  getAvatar() {
    List<UserAvatar> listAvatar = [];
    String url =
        "https://firebasestorage.googleapis.com/v0/b/ja-app-6430b.appspot.com/o/uploads%2Fdata%2Fuser%2F0%2Fcom.example.ja_app%2Fcache%2Fphoto_user%2F";
    String newUrl;

    for (var i = 0; i <= 18; i++) {
      String name = "user_" + i.toString();
      newUrl = url +
          name +
          ".png?alt=media&token=08b2edd7-f904-4d61-b59f-97520e4000b3";
      var user = UserAvatar(name, newUrl, i == 0 ? true : false);

      //if (user.isSelect == true) onUserAvatarChanged(user);
      listAvatar.add(user);
    }

    onListAvatarChanged(listAvatar);
  }

  Future<SignUpResponse> submit() async {
    final userData = UserData(
      name: state.name,
      lastName: state.lastName,
      lastNameSecond: state.lastNameSecond,
      nameSecond: state.nameSecond,
      phone: state.phone,
      userName: state.userName,
      email: state.email,
      password: state.password,
      photoURL: state.userAvatar!.url,
      birthDate: state.birthDate!,
      listPermisson: [PermissonList.C],
      bautizated: state.bautizatedCharacter.toString(),
      country: state.country!,
      gender: state.singingCharacter!.index.toString(),
    );
    final response =
        await _signUpRepository.register(userData, state.codeRegister!);

    if (response.error == null) {
      _sessionController.setUser(response.user!, userData);
      log("00");
      log(response.user!.uid);
    }
    return response;
  }

  Future<void> sendRegisterForm(BuildContext context) async {
    final isValidForm = formKeyTwo.currentState!.validate();

    if (isValidForm) {
      ProgressDialog.show(context);
      final response = await submit();
      router.pop();
      if (response.error != null) {
        late String content;

        switch (response.error) {
          case SignUpError.tooManyRequests:
            content = "Too many Requests";
            break;
          case SignUpError.emailAlreadyInUse:
            content = "Email already in use";
            break;
          case SignUpError.weakPassword:
            content = "weak password";
            break;
          case SignUpError.unknown:
            content = "error unknown";
            break;
          case SignUpError.networkRequestFailed:
            content = "network Request Failed";
            break;
          default:
            break;
        }
        Dialogs.alert(context, title: "ERROR", content: content);
      } else {
        router.pushNamedAndRemoveUntil(Routes.HOME);
      }
    } else {
      Dialogs.alert(context, title: "ERROR", content: "Invalid fields");
    }
  }

  Future<void> uploadPfp(File file) async {
    File uploadFile = file;
    String path;

    await FirebaseStorage.instance
        .ref('uploads/${uploadFile.path}')
        .putFile(uploadFile)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        onImageURLChanged(value);
      });
    });
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
    state = state.copyWith(userAvatar: userAvatar);
  }

  void onSingingCharacterChanged(SingingCharacter singingCharacter) {
    state = state.copyWith(singingCharacter: singingCharacter);
  }

  void onCodeRegisterChanged(String codeRegister) {
    state = state.copyWith(codeRegister: codeRegister);
  }

  void nextPage(BuildContext context) {
    /*onUserAvatarChanged(
        state.listAvatar!.firstWhere((element) => element.isSelect == true));
    DefaultTabController.of(context)?.animateTo(1);*/

    _church.registerMemberChurch(
        "wJM5lbqzjmOvsXFe3fap", "wJM5lbqzjmOvsXFe3fap");
  }

  void nextPageSend(BuildContext context) {
    final isValidForm = formKeyOne.currentState!.validate();
    if (isValidForm) {
      DefaultTabController.of(context)?.animateTo(2);
    }
  }

  void lastPage(BuildContext context) {
    DefaultTabController.of(context)?.animateTo(0);
  }

  void lastPagePersonal(BuildContext context) {
    DefaultTabController.of(context)?.animateTo(1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
