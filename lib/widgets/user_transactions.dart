import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../pages/add_item.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Daily Groceries', amount: 16.53, date: DateTime.now())
  ];

  int idCounter = 3;

  void addItem() {
    print(titleController.text);
    setState(() {
      _transactions.add(
        Transaction(
          id: 't$idCounter',
          amount: double.parse(amountController.text),
          title: titleController.text,
          date: DateTime.now(),
        ),
      );
    });
    idCounter += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddItem(
          titleController: titleController,
          amountController: amountController,
          onAddItem: addItem,
        ),
        Expanded(child: TransactionList(_transactions)),
      ],
    );
  }
}
