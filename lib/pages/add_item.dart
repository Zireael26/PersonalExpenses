import 'package:flutter/material.dart';

import 'package:personal_expenses/widgets/custom_textfield.dart';

class AddItem extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final Function onAddItem;

  AddItem({this.titleController, this.amountController, this.onAddItem});
  
  void submitForm() {
    String titleText = titleController.text;
    double amt = double.parse(amountController.text);

    if(titleText.isEmpty || amt <= 0) {
      return;
    }

    onAddItem();
    titleController.text = "";
    amountController.text = "";
  }

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
            CustomTextField(
              label: "Enter Title",
              inputType: TextInputType.text,
              controller: titleController,
            ),
            Container(height: 16.0),
            CustomTextField(
              label: "Enter Price",
              inputType: TextInputType.number,
              controller: amountController,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            MaterialButton(
              child: Text('Add Transaction'),
              textColor: Colors.purpleAccent,
              onPressed: submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
