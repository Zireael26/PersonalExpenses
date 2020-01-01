import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 32.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd()
                        .format(transactions[index].date)
                        .toString(),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete_forever),
                          label: Text('Delete'),
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                          textColor: Theme.of(context).primaryColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete_forever),
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
            // children: _transactions.map((tx) {
            //   return TransationItem(tx);
            // }).toList(),
          );
  }
}
