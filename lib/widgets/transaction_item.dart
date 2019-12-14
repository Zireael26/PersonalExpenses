import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransationItem extends StatelessWidget {
  final Transaction tx;
  TransationItem(this.tx);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                '\$${tx.amount.toString()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  tx.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(tx.date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
