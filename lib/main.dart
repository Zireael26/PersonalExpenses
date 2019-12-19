import 'package:flutter/material.dart';

import 'pages/add_item.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Expenses App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Daily Groceries', amount: 16.53, date: DateTime.now())
  ];

  int idCounter = 3;

  void _addItem() {
    print(titleController.text);
    setState(() {
      _transactions.add(
        Transaction(
          id: 't$idCounter',
          amount: double.parse(amountController.text),
          title: titleController.text,
          date: DateTime.now(),
        ),
      );
    });
    idCounter += 1;
    Navigator.pop(context);
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return AddItem(
          titleController: titleController,
          amountController: amountController,
          onAddItem: _addItem,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Text("Chart"),
              ),
            ),
            Expanded(
              child: TransactionList(_transactions),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: <Widget>[
            Icon(Icons.attach_money),
            Text("Add an expense"),
          ],
        ),
        isExtended: true,
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
