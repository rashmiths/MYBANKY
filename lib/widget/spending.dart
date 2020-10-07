import 'package:expense/model/expense.dart';
import 'package:expense/model/income.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class Spending extends StatelessWidget {
  final incomeBox = Hive.box('income');
  final expensenBox = Hive.box('expense');

  int get manytimes {
    int i = 0;
    for (i = 0; i < 7; i++) {
      final week = DateTime.now().subtract(Duration(days: i));

      if (DateFormat('EEEE').format(week).toString() == 'Monday') {
        break;
      }
    }
    return i + 1;
  }

  List get weekTransaction {
    return List.generate(manytimes, (index) {
      // Hive.openBox('transaction');

      final transactionBox = Hive.box('expense');

      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      var i;

      for (i = 0; i < transactionBox.length; i++) {
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
    return weekTransaction.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  List get weekincome {
    return List.generate(manytimes, (index) {
      // Hive.openBox('transaction');

      final transactionBox = Hive.box('income');

      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      var i;

      for (i = 0; i < transactionBox.length; i++) {
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

  double get totalIncome {
    return weekincome.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  double get todayExpense {
    List<Expense> translist = expensenBox.values.toList().cast<Expense>();
    final recentList=translist.where((trans) {
      return trans.date.day == DateTime.now().day &&
          trans.date.month == DateTime.now().month &&
          trans.date.year == DateTime.now().year;
    }).toList();
    
    return recentList.fold(0.0, (todaysum, item) {
      return todaysum + item.amount;
    });
  }

  double get todayIncome {
    List<Income> translist = incomeBox.values.toList().cast<Income>();
    final recentList=translist.where((trans) {
      return trans.date.day == DateTime.now().day &&
          trans.date.month == DateTime.now().month &&
          trans.date.year == DateTime.now().year;
    }).toList();
    print(translist.length);
    return recentList.fold(0.0, (todaysum, item) {
      return todaysum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SPENDING",
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
      ),
      body: Column(
        children: <Widget>[
          content(context, 'Today\'s Report', todayIncome, todayExpense),
          content(context, 'Weekly Report', totalIncome, totalSpending)
        ],
      ),
    );
  }

  Widget content(BuildContext context, String title, double totalIncome,
      double totalSpending) {
    print(totalIncome);
    print('called once');

    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.all(15.0),
        width: double.infinity,
        height: 100,
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: FractionColumnWidth(.4),
            1: FractionColumnWidth(.2),
            2: FractionColumnWidth(.4)
          },
          children: [
            TableRow(children: [
              Container(
                  margin: EdgeInsets.all(15),
                  child: Text('Expense',
                      style: Theme.of(context).textTheme.title)),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(totalSpending.toString() + ' Rs',
                    style: Theme.of(context).textTheme.title),
              ),
            ]),
            TableRow(children: [
              Container(
                  margin: EdgeInsets.all(15),
                  child:
                      Text('Income', style: Theme.of(context).textTheme.title)),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(totalIncome.toString() + ' Rs',
                    style: Theme.of(context).textTheme.title),
              ),
            ]),
            TableRow(children: [
              Container(
                  margin: EdgeInsets.all(15),
                  child: Text(totalIncome > totalSpending ? 'Profit' : 'Loss',
                      style: Theme.of(context).textTheme.title)),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(
                    totalIncome > totalSpending
                        ? '${totalIncome - totalSpending} Rs'
                        : '${totalSpending - totalIncome} Rs',
                    style: Theme.of(context).textTheme.title),
              ),
            ])
          ],
        ),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.amber.withOpacity(0.5), Colors.amber],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        //   // borderRadius: BorderRadius.circular(15),
        // ),
      ),
      SizedBox(
        height: 80.0,
      ),
    ]);
  }
}
