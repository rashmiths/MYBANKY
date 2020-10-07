import 'package:expense/tabscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


import './model/expense.dart'; 

import 'model/expense.dart';
import './model/income.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());
   await Hive.openBox('expense');
   await Hive.openBox('income');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i = 0;
  // final List<Transaction> usertxt = [
  //   // Transaction('t1', 'newshoes', 48.99, DateTime.now()),
  //   // Transaction('t2', 'groceries', 68, DateTime.now()),
  // ];

  

 
  

  bool showChart = false;
  List<Box> boxlist=[];

  Future openingBox() async{
    var expensebox= await Hive.openBox('expense');
   var incomebox=await Hive.openBox('income');
   boxlist.add(expensebox);
   boxlist.add(incomebox);
   return boxlist;

  }
  

  @override
  Widget build(BuildContext context) {
    // var appbar = AppBar(
    //   title: Text(
    //     "PERSONAL EXPENSE",
    //     style: TextStyle(fontFamily: 'OpenSans'),
    //   ),
    //   actions: <Widget>[
    //     Builder(
    //       builder: (context) => IconButton(
    //         icon: Icon(Icons.search),
    //         onPressed: () {
    //           return;
              
    //         },
    //       ),
    //     ),
    //   ],
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ))),
      home: FutureBuilder(
        future: 
        // Hive.openBox('expense'),
        openingBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return TabScreen();
          } else
            return TabScreen();

          // Scaffold(
          //   body: Center(
          //     child: SpinKitRotatingCircle(
          //       color:Colors.black,
          //       size: 50.0,
          //     ),
          //   ),

          // ) ;
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
