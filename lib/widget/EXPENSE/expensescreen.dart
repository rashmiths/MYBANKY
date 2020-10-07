import 'package:expense/model/expense.dart';

import 'package:expense/widget/EXPENSE/Chart.dart';

import 'package:expense/widget/EXPENSE/new_transaction.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';


import './transaction_list.dart';


class Expensescreen extends StatefulWidget {
  @override
  _ExpensescreenState createState() => _ExpensescreenState();
  
}

class _ExpensescreenState extends State<Expensescreen> {






  int i = 0;
  void usertransaction(
      String id, String title, double amount, DateTime selectedDate) {
    final newtxt = Expense(
      id,
      title,
      amount,
      selectedDate == null ? DateTime.now() : selectedDate,
      // DateTime.now()
    );

    setState(() {
      final transactionBox = Hive.box('expense');
      transactionBox.put(id, newtxt);
      // usertxt.add(newtxt);
    });
  }

  void startAddingTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(usertransaction);
        });
  }

  void deletetxt(String id) {
    setState(() {
      print(id);
      // return usertxt.removeWhere((txt) {
      //   return txt.id == id;
      // });
      final transactionbox = Hive.box('expense');
      transactionbox.delete(id);
      
    });
  }
   

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text(
        "PERSONAL EXPENSE",
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
      ],
    );

    return Scaffold(
      
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.all(10.0),
              width: double.infinity,

              child: Chart(appbar),
            ),
            TransactionList(deletetxt, appbar),
            // UserTransaction(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startAddingTransaction(context);
          },
        ),
      ),
    );
  }
}
