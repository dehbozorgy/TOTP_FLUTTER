
import 'package:hive/hive.dart';

part 'TableBarcode.g.dart';

@HiveType(typeId: 0)
class TableBarcode {

  @HiveField(0)
  final String Label;

  @HiveField(1)
  final String UserName;

  @HiveField(2)
  final String Password;

  TableBarcode({required this.Label, required this.UserName, required this.Password});

}