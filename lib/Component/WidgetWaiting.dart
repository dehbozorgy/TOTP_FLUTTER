import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

class WidgetWaiting extends StatefulWidget {
  final Future InputFunction;

  const WidgetWaiting({super.key, required this.InputFunction});

  @override
  State<WidgetWaiting> createState() => _WidgetWaitingState();
}

class _WidgetWaitingState extends State<WidgetWaiting>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.InputFunction.then((value) {
        Navigator.pop(context, value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: EdgeInsets.all(10),
          child: FittedBox(
            child: spinkit.SpinKitPouringHourGlassRefined(
                color: Colors.lightBlueAccent),
          )),
    );
  }
}
