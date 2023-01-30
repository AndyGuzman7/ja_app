import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  String emailService = "tu.espacio.joven.hdfe@gmail.com";
  String passwordService = "msbqlczfotagkdpz";
  String emailClient;
  String subJect;
  String text;

  EmailService(this.emailClient, this.subJect, this.text);

  Future<bool> sendEmail() async {
    final smtpServer = gmail(emailService, passwordService);

    final message = Message()
      ..from = Address(emailService, 'JA Movil')
      ..recipients.add(emailClient)
      //..ccRecipients.addAll(['andyguzman117@example.com'])
      //..bccRecipients.add(Address('andyguzman117@example.com'))
      ..subject = subJect
      ..text = text;
    //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      await send(message, smtpServer).then((value) {
        return true;
      });
    } on MailerException catch (e) {
      return false;
    }
    return false;
  }
}
