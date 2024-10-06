import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import '/Component/NavidPersianDatePicker/src/cupertino/cupertino_date_picker.dart';
import '/Component/NavidPersianDatePicker/src/date/src/jalali/jalali_date.dart';
import 'Component/CartBank.dart';
import 'Component/Input.dart';
import 'Component/InputPassword.dart';
import '/Funcs.dart';

class PagePayment extends StatefulWidget {

  final String Username;

  const PagePayment({super.key,required this.Username});

  @override
  State<PagePayment> createState() => _PagePaymentState();
}

class _PagePaymentState extends State<PagePayment> {

  String date = '    /  ';

  GetData() async {

    FocusManager.instance.primaryFocus!.unfocus();

    Jalali? pickedDate =

    await showModalBottomSheet<Jalali>(
        context: context,
        builder: (context)
        {
          Jalali? tempPickedDate;
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 7
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('لغو'),
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )),
                              backgroundColor: MaterialStatePropertyAll(Colors.red)
                          ),
                        ),
                        Image.asset('assets/png/calender.png',width: 30,height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(tempPickedDate);
                          },
                          child: Text('تایید'),
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )),
                              backgroundColor: MaterialStatePropertyAll(Color(0xff43c79f))
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                Expanded(
                  child: Container(
                    child: PCupertinoDatePicker(
                      mode: PCupertinoDatePickerMode.date,
                      textStyleYear: TextStyle(
                          fontFamily: 'SansFaNum',
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      textStyleMonth: TextStyle(
                          fontFamily: 'SansFaNum',
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      textStyleDay: TextStyle(
                          fontFamily: 'SansFaNum',
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      onDateTimeChanged: (Jalali dateTime) {
                        tempPickedDate = dateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });


    if(pickedDate!=null){
      setState(() {
        date = '${pickedDate.year} / ${pickedDate.month.toString().padLeft(2,'0')}';
      });
    }
  }

  // padding: EdgeInsets.only(bottom: 50.h + MediaQuery.of(context).viewInsets.bottom),

  TextEditingController txt_pass = TextEditingController();

  Future GetValidate() async {

    await Future.delayed(Duration(seconds: 2));

    String BaseUri = 'http://192.168.8.100';

    String body1 = '{"username":"${widget.Username}","token":"${txt_pass.text}"}';

    var bb1 = jsonDecode(body1);

    Response res1 = await post(Uri.parse('${BaseUri}/verify-2fa'),body:bb1);

    var rres1 = jsonDecode(res1.body);

    return rres1;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SafeArea(
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 10.h + MediaQuery.of(context).viewInsets.bottom),
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: 0.9.sw,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300
                    ),
                    child: Column(
                      children: [

                        Container(
                          width: double.maxFinite,
                          color: Colors.white.withOpacity(0.3),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white.withOpacity(0.5),
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                padding: EdgeInsets.all(3),
                                child: Text('شماره کارت بانکی : ',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp
                                  ),
                                ),
                              ),
                              CartBank(
                                  textAlign: TextAlign.center,
                                  hint: 'کارت بانکی',
                                  textInputType: TextInputType.numberWithOptions(),
                                  textDirection: TextDirection.ltr
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            Flexible(
                              child: Container(
                                width: double.maxFinite,
                                color: Colors.white.withOpacity(0.3),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.white.withOpacity(0.5),
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      padding: EdgeInsets.all(3),
                                      child: Text('تاریخ انقضا کارت : ',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      child: GestureDetector(
                                        onTap: GetData,
                                        child: Container(
                                          height: 50,
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.outer
                                                )
                                              ]
                                          ),
                                          child: Center(
                                            child: Text(date,
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  fontFamily: 'SansFaNum'
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 5),

                            Flexible(
                              child: Container(
                                width: double.maxFinite,
                                color: Colors.white.withOpacity(0.3),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.white.withOpacity(0.5),
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      padding: EdgeInsets.all(3),
                                      child: Text('شماره CVV2 : ',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Input(
                                        textAlign: TextAlign.center,
                                        hint: 'CVV2',
                                        textInputType: TextInputType.numberWithOptions(),
                                        textDirection: TextDirection.ltr,
                                        length: 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),

                       Container(
                          width: double.maxFinite,
                          color: Colors.white.withOpacity(0.3),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white.withOpacity(0.5),
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                padding: EdgeInsets.all(3),
                                child: Text('رمز کارت بانکی : ',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InputPassword(
                                  textAlign: TextAlign.center,
                                  controller: txt_pass,
                                  hint: 'رمز کارت بانکی',
                                  textInputType: TextInputType.visiblePassword,
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ],
                          ),
                        ),

                       SizedBox(height: 5.h),

                       ElevatedButton(
                           onPressed: () async {

                             FocusManager.instance.primaryFocus!.unfocus();

                            var data = await waiting(context, GetValidate());

                            await Future.delayed(Duration(milliseconds: 100));

                            if(data['delta']==0){
                              await ShowFlash(context, Colors.lightGreenAccent.shade200, MsgOk());
                              await Future.delayed(Duration(milliseconds: 200));
                              Navigator.pop(context);
                            }
                            else if(data['delta']==-1){
                              await ShowFlash(context, Colors.orangeAccent.shade200, MsgCancel());
                            }

                            int ii = 2;


                           },
                           child: Text('تایید',
                               style: TextStyle(
                                 fontSize: 20.sp,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black
                               )
                           ),
                         style: ButtonStyle(
                           fixedSize: WidgetStatePropertyAll(Size(double.maxFinite,40)),
                           shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(5.0),
                               //side: BorderSide(color: Color(0xff43c79f))
                           )),
                           backgroundColor: WidgetStatePropertyAll(Color(0xff43c79f))
                         ),
                       )
                        

                      ],
                    ),
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}

class MsgOk extends StatelessWidget {
  const MsgOk({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_outline_rounded,size: 100.sp,color: Colors.green),
        SizedBox(height: 10.h),
        Text('پرداخت با موفقیت انجام شد',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.sp,
            )
        )
      ],
    );
  }
}

class MsgCancel extends StatelessWidget {
  const MsgCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.cancel_outlined,size: 100.sp,color: Colors.red),
        SizedBox(height: 10.h),
        Text('تایم این رمز گذشته',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            )
        )
      ],
    );
  }
}

