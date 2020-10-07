import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense/model/expense.dart';
import 'package:hive/hive.dart';

class TransactionList extends StatefulWidget {
  // final List<Transaction> transactionlist = [
  //   Transaction('t1', 'newshoes', 48.99, DateTime.now()),
  //   Transaction('t2', 'groceries', 68, DateTime.now()),
  // ];
  // List<Transaction> transactionlist;

  final Function deletetxt;
  final appbar;
  TransactionList(this.deletetxt, this.appbar);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void didUpdateWidget(TransactionList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionbox = Hive.box('expense');

    return Container(
      height: (MediaQuery.of(context).size.height -
              widget.appbar.preferredSize.height -
              MediaQuery.of(context).padding.top -
              80) *
          0.7,
      child: transactionbox.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions Added!',
                  style: TextStyle(fontFamily: 'Quicksand'),
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctxt, index) {
                
                final taskList =
                    transactionbox.values.toList().cast<Expense>();
                 taskList.sort((a, b) => -a.date.compareTo(b.date));

                Widget date(indexdate) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      DateFormat.yMMMd().format(taskList[index].date),
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }

                return Column(
                  children: <Widget>[
                    if(index==0)
                      Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      DateFormat.yMMMd().format(taskList[index].date),
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  ),


                    if (index != 0)
                      if (taskList[index].date.day !=
                          taskList[index - 1].date.day)
                        date(taskList[index].date),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 50.0,
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: FittedBox(
                                    child: Text(
                                        //transactionlist[index]
                                        taskList[index]
                                                .amount
                                                .toStringAsFixed(2) +
                                            '\n  rs')),
                              ),
                            ),
                            title: Text(
                              //transactionlist[index].
                              taskList[index].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            subtitle: Text(
                              DateFormat.jm()
                                .format(taskList[index].date)
                               
                                
                                ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  //  transactionlist[index].id=DateTime.now().toString();

                                  widget.deletetxt(taskList[index].id);
                                }))),
                  ],
                );
              },
              itemCount: transactionbox.length),
      //transactionlist.length),
      //     children: transactionlist.map((txt) {

      // }.toList()),
    );
  }
}
