import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tx;
  final Function deleteTransaction;

  TransactionItem(
      {Key key, @required this.tx, @required this.deleteTransaction})
      : super(key : key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 32.0,
          backgroundColor: _backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FittedBox(
              child: Text(
                '\$${widget.tx.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tx.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(widget.tx.date).toString(),
        ),
        trailing: MediaQuery
            .of(context)
            .size
            .width > 480
            ? FlatButton.icon(
          icon: const Icon(Icons.delete_forever),
          label: const Text('Delete'),
          onPressed: widget.deleteTransaction,
          textColor: Theme
              .of(context)
              .primaryColor,
        )
            : IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: widget.deleteTransaction,
          color: Theme
              .of(context)
              .primaryColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    const availableColors = [
      Colors.red,
      Colors.amber,
      Colors.lightGreen,
      Colors.deepPurple
    ];

    _backgroundColor = availableColors[Random().nextInt(4)];
  }
}
