import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text("No Transactions Yet"),
              Container(height: 32.0),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return TransationItem(_transactions.elementAt(index));
            },
            itemCount: _transactions.length,
            // children: _transactions.map((tx) {
            //   return TransationItem(tx);
            // }).toList(),
          );
  }
}
