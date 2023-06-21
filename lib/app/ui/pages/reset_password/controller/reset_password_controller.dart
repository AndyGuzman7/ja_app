import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/responses/reset_password_response.dart';

import '../../../../data/repositories/login_repository/login_repository.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = '';
  String get email => _email;
  final _auth = Get.find<LoginRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse?> submit() {
    return _auth.sendResetPasswordLink(email);
  }
}
