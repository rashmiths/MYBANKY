
import 'package:hive/hive.dart';

part 'expense.g.dart';


@HiveType(typeId: 0)
class Expense{
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime date;
  

  Expense(this.id,this.title,this.amount,this.date);
}