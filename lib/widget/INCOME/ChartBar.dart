import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingpctge;
  // final o=MediaQuery.of(context).orientation==Orientation.landscape;

  ChartBar(this.label, this.spendingamount, this.spendingpctge);
  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight*0.10,
            child: FittedBox(
              child: Text(
                ' ${spendingamount.toStringAsFixed(0)} rs',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height:constraints.maxHeight*0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.7,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: 1 - spendingpctge,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                       borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: constraints.maxHeight*0.05,
          // ),
          Container(
            height: constraints.maxHeight*0.15,
            child: Text('$label')),
        ],
      );
    });
  }
}
