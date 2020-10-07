import 'package:expense/widget/EXPENSE/expensescreen.dart';
import 'package:expense/widget/INCOME/incomescreen.dart';
import 'package:expense/widget/maindrawer.dart';
import 'package:flutter/material.dart';



class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex = 0;
  List<Map> pages = [
    {
      'pages': Expensescreen(),
      'title': 'Expense',
    },
   {
     'pages':IncomeScreen(),
     'title':'Income'
   } 
  ];
  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pages[selectedPageIndex]['title'],
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
        ),
        drawer: MainDrawer(),
        body: pages[selectedPageIndex]['pages'],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            currentIndex: selectedPageIndex,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.shifting,
            onTap: _selectPage,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.monetization_on),
                  title: Text('Expense')),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.money_off),
                  title: Text('Income')),
            ]));
  }
}
