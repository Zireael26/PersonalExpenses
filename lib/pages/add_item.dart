import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_button.dart';
import '../widgets/custom_textfield.dart';

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
    return DraggableScrollableSheet(
      minChildSize: 1,
      initialChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ListView(
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
                      AdaptiveFlatButton(
                        buttonText: "Choose Date",
                        onPressed: _presentDatePicker,
                      )
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
              margin: EdgeInsets.all(16.0),
            );
          },
        );
      },
    );
  }
}
