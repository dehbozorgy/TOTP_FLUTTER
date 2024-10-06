import '/ModelDataBase/TableBarcode.dart';
import 'package:hive/hive.dart';

Future<List<TableBarcode>> get GetAllBarcode async {
  var tbl = await Hive.openBox<TableBarcode>('TableBarcode');
  List<TableBarcode> data = tbl.values.toList();
  await tbl.close();
  return data;
}

Future SaveBarcode(TableBarcode data) async {
  var tbl = await Hive.openBox<TableBarcode>('TableBarcode');
  await tbl.add(data);
  await tbl.close();
}

Future DeleteItem(TableBarcode item) async {
  var tbl = await Hive.openBox<TableBarcode>('TableBarcode');
  int index = tbl.values.toList().indexWhere((t) => t.Label==item.Label && t.UserName==item.UserName && t.Password==item.Password);
  await tbl.deleteAt(index);
  await tbl.close();
}

Future ClearAll() async {
  var tbl = await Hive.openBox<TableBarcode>('TableBarcode');
  await tbl.deleteFromDisk();
  await tbl.close();
}