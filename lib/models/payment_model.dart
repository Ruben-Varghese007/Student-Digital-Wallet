import 'package:flutter/material.dart';

class PaymentModel extends ChangeNotifier {
  bool paymentConfirmed = false;

  void confirmPayment() {
    paymentConfirmed = true;
    notifyListeners();
  }
}
