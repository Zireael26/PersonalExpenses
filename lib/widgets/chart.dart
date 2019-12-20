import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i += 1) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpent {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  Chart({this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((dailyData) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                weekday: dailyData['day'],
                expenditure: dailyData['amount'],
                expPercentOfTotal: totalSpent == 0.0
                    ? 0
                    : (dailyData['amount'] as double) / totalSpent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
