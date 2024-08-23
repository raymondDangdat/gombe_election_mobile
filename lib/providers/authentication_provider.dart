import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool loading = false;

  String resMessage = "";

  bool isError = true;
  bool isLoading = false;
  bool isAdmin = false;

  String adminAddress = "0x5CF1ac05B56502eed24fa3765030e3a7635d25C5";

  void updateIsAdmin({bool newValue = false}) {
    isAdmin = newValue;
  }

  Future<bool> sendEmail(
      {required String reason,
      required String body,
      required String subject,
      required String recipient}) async {
    debugPrint("In send email method");
    loading = true;
    bool emailSent = false;
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipient],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
    emailSent = true;
    loading = false;
    debugPrint("Email Sent========");
    notifyListeners();

    return emailSent;
  }

  void clear() {
    resMessage = "";
    notifyListeners();
  }
}
