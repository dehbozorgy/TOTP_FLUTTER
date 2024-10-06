import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Component/InputText.dart';
import '../../ModelDataBase/TableBarcode.dart';
import '../PageBarcode.dart';

class PannelBarcodeSave extends StatefulWidget {
  const PannelBarcodeSave({super.key});

  @override
  State<PannelBarcodeSave> createState() => _PannelBarcodeSaveState();
}

class _PannelBarcodeSaveState extends State<PannelBarcodeSave> {

  late String PathPng;

  late GlobalKey<FormState> FormKey;

  late TextEditingController
  txt_Label,
      txt_UserName,
      txt_Password;

  @override
  void initState() {

    txt_Label = TextEditingController();
    txt_UserName = TextEditingController();
    txt_Password = TextEditingController();

    FormKey = GlobalKey<FormState>();

    PathPng = 'assets/png/law.png';

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(10)
      ),
      constraints: BoxConstraints(
        maxHeight: 0.8.sh,
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
              width: 80.w,height: 80.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0,
                        blurRadius: 5
                    )
                  ]
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                  PathPng,
                  alignment: Alignment.center,fit: BoxFit.fill).animate(
                effects: [
                  ScaleEffect(begin: Offset(0.0, 0.0),end: Offset(1.0, 1.0),duration: 300.ms,delay: 300.ms,alignment: Alignment.center)
                ] ,
              )
          ),

          Form(
            key: FormKey,
            child: Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: InputText(
                      pathPng: 'assets/png/wave2.png',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      hint: 'Label',
                      prefix: null,
                      textInputType: TextInputType.text,
                      controller: txt_Label,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: InputText(
                      pathPng: 'assets/png/wave2.png',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      hint: 'UserName',
                      prefix: null,
                      textInputType: TextInputType.text,
                      controller: txt_UserName,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: InputText(
                      pathPng: 'assets/png/wave2.png',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      hint: 'PassWord',
                      prefix: null,
                      textInputType: TextInputType.numberWithOptions(decimal: true,signed: true),
                      controller: txt_Password,
                    ),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 15
            ),
            child: ElevatedButton(
              onPressed: () async {

                if(FormKey.currentState!.validate()){

                  FocusManager.instance.primaryFocus?.unfocus();


                  TableBarcode data = TableBarcode(
                      Label: txt_Label.text,
                      UserName: txt_UserName.text,
                      Password: txt_Password.text);

                  Navigator.pop(context,data);

                }

              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('تایید',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.sp
                  )),
                  SizedBox(width: 5),
                  Image.asset('assets/png/ok.png',width: 30,height: 30)
                ],
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                  fixedSize: WidgetStatePropertyAll(Size(double.maxFinite,40))
              ),
            ),
          ),

        ],

      ),
    ).animate(
      effects: [
        ScaleEffect(begin: Offset(0.0, 0.0),end: Offset(1.0, 1.0),duration: 300.ms,alignment: Alignment.center)
      ] ,
    );
  }

}
