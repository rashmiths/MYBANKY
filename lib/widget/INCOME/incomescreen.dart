import 'package:expense/model/income.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import './new_transaction.dart';
import './transaction_list.dart';

import './Chart.dart';
class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  int i = 0;
  
 
  void usertransaction(
      String id, String title, double amount, DateTime selectedDate) {
    final newtxt = Income(
      id,
      title,
      amount,
      selectedDate == null ? DateTime.now() : selectedDate,
      // DateTime.now()
    );

    setState(() {
      final transactionBox = Hive.box('income');
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
      // return usertxt.removeWhere((txt) {
      //   return txt.id == id;
      // });
      final transactionbox = Hive.box('income');
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
            onPressed: () {

            },
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