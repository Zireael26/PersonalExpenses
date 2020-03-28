import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            headline6: TextStyle(
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<Transaction> _transactions = [];
  bool _showChart = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    print(appLifecycleState);
  }


  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

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

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,
      Widget txListWidget
     ) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Show Chart'),
        Switch.adaptive(
          onChanged: (bool value) {
            setState(() {
              _showChart = value;
            });
          },
          value: _showChart,
        ),
      ],
    ), _showChart
        ? Container(
      height: mediaQuery.size.height * 0.60,
      child: Chart(
        recentTransactions: recentTransactions,
      ),
    )
        : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,
      Widget txtWidget) {
    return [
      Container(
          height: mediaQuery.size.height * 0.30,
          child: Chart(
            recentTransactions: recentTransactions,
          )),
      txtWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    int platformCode = 0; // 1 is iPhone, 0 is non-iphone
    if (kIsWeb) {
      platformCode = 0;
    } else if (Platform.isIOS) {
      platformCode = 1;
    }

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final txListWidget = Expanded(
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
    final pageBody = SafeArea(
      child: Material(
        child: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                ..._buildLandscapeContent(mediaQuery, txListWidget),
              if (!isLandscape)
                ..._buildPortraitContent(mediaQuery, txListWidget),
              ],
          ),
        ),
      ),
    );

    return platformCode == 1
        ? CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Personal Expenses",
          style: TextStyle(fontSize: 24.0),
        ),
        trailing: GestureDetector(
          child: Icon(Icons.add),
          onTap: () {
            startAddNewTransaction(context);
          },
        ),
      ),
      child: pageBody,
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          ),
        ],
      ),
      body: pageBody,
      floatingActionButton: platformCode == 1
          ? Container()
          : MyFloatingActionButton(
        onPressed: startAddNewTransaction,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
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
