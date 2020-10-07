
import 'package:hive/hive.dart';

part 'income.g.dart';


@HiveType(typeId: 1)
class Income{
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime date;
  

  Income(this.id,this.title,this.amount,this.date);
}