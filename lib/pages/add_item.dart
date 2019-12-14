import 'package:flutter/material.dart';

import 'package:personal_expenses/widgets/custom_textfield.dart';

class AddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add an expense",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 16.0),
            CustomTextField("Enter Title"),
            Container(height: 16.0),
            CustomTextField("Enter Price"),
          ],
        ),
      ),
    );
  }
}
