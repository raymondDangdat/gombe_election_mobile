import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../resources/constants/string_constants.dart';
import '../widgets/loading_indicator.dart';

String formatDate(String str) {
  DateTime date = DateTime.parse(str);
  return DateFormat().add_yMMMd().add_jm().format(date);
}

String formatCurrency(double num, {String? symbol}) =>
    NumberFormat.currency(symbol: symbol ?? '₦').format(num);

double getFileSize(File file) {
  int sizeInBytes = file.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  return sizeInMb;
}

double returnPercentAchieved({required double amount, required double total}) {
  double percentAchieved = amount < 1 ? 0 : (amount * 100) / total;
  debugPrint("Percentage achieved:  $percentAchieved");

  return percentAchieved;
}

int returnPercentDiscount(
    {required double sellingPrice, required double discountedPrice}) {
  double discount = sellingPrice - discountedPrice;
  double discountPercent = (discount * 100) / sellingPrice;
  String approximateValue = discountPercent.toStringAsFixed(0);

  return double.parse(approximateValue).toInt();
}

double returnRealAmount({required String amount}) {
  String localAmount = "00";
  if (amount.endsWith("K")) {
    localAmount = amount.replaceAll("K", "000");
  } else if (amount.endsWith("M")) {
    localAmount = amount.replaceAll("M", "000000");
  } else {
    localAmount = amount;
  }
  debugPrint("The local amount is: $localAmount");
  return double.parse(localAmount);
}

Future<void> showLoader(BuildContext context,
    {bool barrierDismissible = false, String message = "Loading..."}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => DialogLoadingIndicator(
            message: message,
          ));
}

//This function pops out screen
void popLoader({required BuildContext context}) {
  Navigator.pop(context);
}

String replaceCharAt(String oldString, dynamic index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String returnFileName({required File file}) {
  String fileName = file.path.split('/').last;
  return fileName;
}

String removeAmountFilters(String amount) {
  String amnt = amount.replaceAll(nairaSign, "");
  amnt = amnt.replaceAll(",", "");
  amnt = amnt.replaceAll('.', "");
  return amnt;
}

String returnFormattedDate(String date) {
  return Jiffy.parse(date.toString()).format(
    // pattern: 'dd MMM, yyyy hh:mm a',
    pattern: 'dd MMM, yyyy',
  );
}

int calculateAge(DateTime birthDate) {
  DateTime today = DateTime.now();
  int age = today.year - birthDate.year;

  // Check if the birthday hasn't occurred yet this year
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

double returnLoyaltyPointProgress(int currentPoints) {
  double progress = (currentPoints * 100) / 500;

  return (progress / 100) > 1 ? 1.0 : progress / 100;
}

int returnKycTier({required dynamic kycTier}) {
  debugPrint(
      "KYC Level::: ${kycTier == null ? 0 : int.parse(kycTier.toString().replaceAll("t", ""))}");
  return kycTier == null
      ? 0
      : int.parse(kycTier.toString().replaceAll("t", ""));
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(this);
  }
}

bool isInsufficientBalance({required String balance, required String amount}) {
  debugPrint("Balance: $balance : Amount $amount");
  return double.parse(amount) > double.parse(balance);
}

Future<int> getBackgroundAndResumeTimeDifference(
    DateTime backgroundTime) async {
  final date2 = DateTime.now();
  debugPrint('Time Saved in background ${backgroundTime.toString()}');
  debugPrint(
      "Time difference in minute ${date2.difference(backgroundTime).inMinutes}");
  return date2.difference(backgroundTime).inMinutes;
}

String returnBillAmount(String amount) {
  return (double.parse(amount) / 100).toStringAsFixed(0);
}

String returnUnFormattedAmount(String amount) {
  String removedCurrencySign = amount.replaceAll(nairaSign, "");
  final removeCommas = removedCurrencySign.replaceAll(",", "");
  return removeCommas;
}

String returnPaymentMethod(String method) {
  debugPrint("Payment Method $method");
  return method.contains("BANK_TRANSFER_TRANSACTION")
      ? 'Bank'
      : method.contains("CARD_TRANSACTION")
          ? 'Card'
          : "NA";
}

String returnFilterValue(String value) {
  return value == today
      ? today.toLowerCase()
      : value == yesterday
          ? yesterday.toLowerCase()
          : value == thisWeek
              ? "thisWeek"
              : value == thisMonth
                  ? "thisMonth"
                  : value == thisYear
                      ? 'thisYear'
                      : '';
}


bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}
