import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/flash_helper.dart';

import 'Component/WidgetWaiting.dart';

Future showMessageBoxByShrink(context,child) async {

  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    alignment: Alignment.center,
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    elevation: 0,
    content: child,
  );


  return await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (context){
        double _bottom = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: (_bottom>0.0) ? 1.h : 0,
          ),
          child: alertDialog,
        );
      }
  );

}

Future showMessageBox(context,child) async {

  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    alignment: Alignment.center,
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    elevation: 0,
    content: child,
  );

  return await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: false,
      builder: (context){
        return alertDialog;
      }
  );

}

Future waiting(context, Future Input) async {

  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    alignment: Alignment.center,
    elevation: 0,
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    content: WidgetWaiting(InputFunction: Input),
  );

  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return alertDialog;
      });
}

Future ShowFlash(BuildContext context,Color color,Widget child,{int duration = 3}) async {

  Size _size = MediaQuery.of(context).size;
  double padLeft = _size.width*0.1;

  return await context.showFlash(
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    duration: Duration(seconds: duration),
    builder: (context, controller) => FadeTransition(
      opacity: controller.controller,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(),
        ),
        backgroundColor: color,
        contentPadding: EdgeInsets.all(8),
        insetPadding: EdgeInsets.only(
            left: padLeft,
            right: padLeft,
            top: 20,
            bottom: 20
        ),
        content: child,
      ),
    ),
  );

  // return await showFlash(
  //     context: context,
  //     duration: Duration(seconds: duration),
  //     builder: (context,controller){
  //       return Flash.dialog(
  //           controller: controller,
  //           borderRadius: BorderRadius.circular(8),
  //           backgroundColor: color,
  //           margin: EdgeInsets.only(
  //             left: padLeft,
  //             right: padLeft,
  //             top: 20,
  //             bottom: 20
  //           ),
  //           child: child
  //       );
  //     }
  // );

}