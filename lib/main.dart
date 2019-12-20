import 'package:flutter/material.dart';

import './pages/add_item.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: "Quicksand",
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20.0,
                ),
              ),
        ),
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
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Daily Groceries', amount: 16.53, date: DateTime.now())
  ];

  List<Transaction> get recentTransactions {
    return _transactions.where(
      (Transaction tx) {
        return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

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
            Chart(recentTransactions: recentTransactions,),
            Expanded(
              child: TransactionList(_transactions),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add an expense"),
        icon: Icon(Icons.attach_money),
        isExtended: true,
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
