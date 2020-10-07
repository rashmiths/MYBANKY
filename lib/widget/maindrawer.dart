import 'package:expense/widget/INCOME/incomescreen.dart';
import 'package:expense/widget/spending.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListView(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      onTap: () {
        tapHandler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Colors.black54,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              height: 80,
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.black54,
              alignment: Alignment.centerLeft,
              child: Text(
                "Bank",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoCondensed'),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            buildListView('expense dash', Icons.attach_money, () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
            buildListView('Spending', Icons.settings, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return Spending();
                  },
                ),
              );
            }),
             buildListView('Income', Icons.settings, () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) {
                    return IncomeScreen();
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
