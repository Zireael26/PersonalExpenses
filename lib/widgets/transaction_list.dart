import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({
    this.transactions,
    this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text("No Transactions Yet"),
              Container(height: 32.0),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return TransactionItem(
                key: UniqueKey(),
                tx: transactions[index],
                deleteTransaction: () {
                  deleteTransaction(transactions[index].id);
                },
              );
            },
            itemCount: transactions.length,
            // children: _transactions.map((tx) {
            //   return TransationItem(tx);
            // }).toList(),
          );
  }
}
