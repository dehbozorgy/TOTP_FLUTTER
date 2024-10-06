import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generatekey/ModelDataBase/TableBarcode.dart';
import 'package:generatekey/PageBarcode/Component/PannelBarcodeSave.dart';
import '../Component/MessageError.dart';
import '/Funcs.dart';
import '/DataBase.dart';
import 'Component/CartBarcode.dart';

class PageBarcode extends StatefulWidget {

  final TextEditingController txt_username;

  const PageBarcode({super.key,required this.txt_username});

  @override
  State<PageBarcode> createState() => _PageBarcodeState();
}

class _PageBarcodeState extends State<PageBarcode> {

  Future<List<TableBarcode>> GetData() async {
    return await GetAllBarcode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: GetData(),
              builder: (chid,data){
                if(data.hasData){
                  return ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        top: 15.h,
                      bottom: 60.h
                    ),
                    physics: BouncingScrollPhysics(),
                    children: [

                      for(TableBarcode item in data.data!)
                        Cartbarcode(
                            data: item,
                            txt_username: widget.txt_username,
                            Delete: () async {

                              String? res = await showMessageBox(context, MessageError(Message: 'از حذف توکن انتخابی مطمعن هستید ؟'));

                              if(res==null || res=='cancel')
                                return;

                              await DeleteItem(item);
                              setState(() {});
                        })

                    ],
                  );
                }
                else if(data.hasError){
                  return Text(data.error.toString());
                }
                else{
                  return SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: Colors.indigo,strokeWidth: 5));
                }
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {

            // await ClearAll();

            TableBarcode? tableBarcode = await showMessageBoxByShrink(context, PannelBarcodeSave());

            if(tableBarcode!=null){

              await SaveBarcode(tableBarcode);

              setState(() {});

            }

          },
        child: Icon(Icons.add,color: Colors.green,size: 50),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

}

