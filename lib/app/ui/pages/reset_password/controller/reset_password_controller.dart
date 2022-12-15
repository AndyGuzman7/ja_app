import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/domain/responses/reset_password_response.dart';
import 'package:ja_app/app/ui/pages/reset_password/reset_password_page.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = '';
  String get email => _email;
  final _auth = Get.find<AuthenticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse?> submit() {
    return _auth.sendResetPasswordLink(email);
  }
}
