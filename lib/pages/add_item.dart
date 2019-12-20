import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/widgets/custom_textfield.dart';

class AddItem extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final Function onAddItem;

  AddItem({
    this.titleController,
    this.amountController,
    this.onAddItem,
  });

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2019),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  void _submitForm() {
    String titleText = widget.titleController.text;
    double amt = double.parse(widget.amountController.text);

    if (titleText.isEmpty || amt <= 0 || _selectedDate == null) {
      return;
    }

    widget.onAddItem(_selectedDate);
    widget.titleController.clear();
    widget.amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height,
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
            controller: widget.titleController,
            inputAction: TextInputAction.next,
          ),
          Container(height: 16.0),
          CustomTextField(
            label: "Enter Price",
            inputType: TextInputType.number,
            controller: widget.amountController,
            inputAction: TextInputAction.done,
          ),
          Container(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(_selectedDate == null
                    ? "No Date Chosen!"
                    : DateFormat.yMMMd().format(_selectedDate)),
              ),
              FlatButton(
                child: Text(
                  "Choose Date",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _presentDatePicker,
              ),
            ],
          ),
          Container(
            height: 8.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Add Transaction'),
              onPressed: _submitForm,
            ),
          ),
        ],
      ),
    );
  }
}
