import 'package:flutter/material.dart';

import './pages/add_item.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
}

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
                  fontFamily: "Quicksand",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Expenses App'),
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
  final List<Transaction> _transactions = [];
  bool _showChart = true;

  List<Transaction> get recentTransactions {
    return _transactions.where(
      (Transaction tx) {
        return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  int idCounter = 3;

  void _addItem(DateTime date) {
    print(titleController.text);
    setState(() {
      _transactions.add(
        Transaction(
          id: 't$idCounter',
          amount: double.parse(amountController.text),
          title: titleController.text,
          date: date,
        ),
      );
    });
    idCounter += 1;
    Navigator.pop(context);
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      useRootNavigator: true,
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

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => id == tx.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWidget = Expanded(
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

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
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    onChanged: (bool value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                    value: _showChart,
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Chart(
                  recentTransactions: recentTransactions,
                ),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: Chart(
                        recentTransactions: recentTransactions,
                      ),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(
        onPressed: startAddNewTransaction,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  final Function onPressed;

  MyFloatingActionButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text("Add an expense"),
      icon: Icon(Icons.attach_money),
      isExtended: true,
      onPressed: () {
        onPressed(context);
      },
    );
  }
}
