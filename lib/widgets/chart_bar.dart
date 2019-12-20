import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekday;
  final double expenditure;
  final double expPercentOfTotal;

  ChartBar({
    @required this.weekday,
    @required this.expenditure,
    @required this.expPercentOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(child: Text('\$${expenditure.toStringAsFixed(0)}')),
        SizedBox(height: 4),
        Container(
          height: 72,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: expPercentOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(weekday),
      ],
    );
  }
}
