import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransationItem extends StatelessWidget {
  final Transaction tx;
  final Function deleteTransaction;


  TransationItem({this.tx, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 32.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FittedBox(
              child: Text('\$${tx.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(tx.date).toString(),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete'),
                onPressed: deleteTransaction,
                textColor: Theme.of(context).primaryColor,
              )
            : IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: deleteTransaction,
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }
}
