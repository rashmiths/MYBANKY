import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function usertransaction;
  NewTransaction(this.usertransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var titlecontroller = TextEditingController();

  var amountcontroller = TextEditingController();
  DateTime selectedDate;
  //DateTime _date = new DateTime.now();
  // TimeOfDay _time = new TimeOfDay.now();

  void submitData() {
    if (amountcontroller.text.isEmpty) {
      return;
    }
    if (titlecontroller.text.isEmpty ||
        double.parse(amountcontroller.text) <= 0) {
      return;
    }

    widget.usertransaction(
      DateTime.now().toString(),
      titlecontroller.text,
      double.parse(amountcontroller.text),
      selectedDate,
    );

    Navigator.of(context).pop();
  }
//    Future<Null> _selectDateAndTime(BuildContext context) async {
//    presentDatePicker();
//   await _selectTime(context);
// }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  //  Future<Null> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: new DateTime(2019),
  //     lastDate: new DateTime(2021),
  //   );

  //   if(picked != null && picked != _date) {
  //     print('Date selected: ${_date.toString()}');
  //     setState((){
  //       _date = picked;
  //     });
  //   }
  // }
  // Future<Null> _selectTime(BuildContext context) async {
  //   final TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );

  //   if(picked != null && picked != _time) {

  //     setState((){
  //       _time = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.only(
                // top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.amber)),
                  controller: titlecontroller,
                   onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.amber)),
                  keyboardType: TextInputType.number,
                  controller: amountcontroller,
                   onSubmitted: (_) => submitData(),
                ),
                Container(
                  // height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: selectedDate == null
                            ? Text('No Date Chosen !')
                            : Text(
                                'ChosenDate:${DateFormat.yMd().format(selectedDate)}'),
                      ),
                      FlatButton(
                          child: Text('Choose Date',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            presentDatePicker();
                          }),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: submitData,
                )
              ],
            ),
          )),
    );
  }
}
