import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String tittle;
  double amount;
  DateTime date;

  Transaction(
      {@required this.id,
      @required this.tittle,
      @required this.amount,
      @required this.date});
}
