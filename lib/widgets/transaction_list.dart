import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TransationItem(_transactions.elementAt(index));
        },
        itemCount: _transactions.length,
        // children: _transactions.map((tx) {
        //   return TransationItem(tx);
        // }).toList(),
      ),
    );
  }
}
