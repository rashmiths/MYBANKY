import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './ChartBar.dart';
import 'package:hive/hive.dart';

class Chart extends StatelessWidget {
  // List<Transaction> recentTransaction;
  final appbar;

  Chart(this.appbar);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // Hive.openBox('transaction');

      final transactionBox = Hive.box('income');

      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < transactionBox.length; i++) {
        final trans = transactionBox.getAt(i);
        if (trans.date.day == weekday.day &&
            trans.date.month == weekday.month &&
            trans.date.year == weekday.year) {
          totalSum += trans.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).toString().substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);

    return Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top -
              100) *
          0.3,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 6.0,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
                fit: FlexFit.tight,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
