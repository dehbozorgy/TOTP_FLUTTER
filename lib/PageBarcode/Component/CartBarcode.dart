import 'dart:convert';

import 'package:custom_qr_generator_2/colors/color.dart';
import 'package:custom_qr_generator_2/options/colors.dart';
import 'package:custom_qr_generator_2/options/options.dart';
import 'package:custom_qr_generator_2/options/shapes.dart';
import 'package:custom_qr_generator_2/qr_painter.dart';
import 'package:custom_qr_generator_2/shapes/ball_shape.dart';
import 'package:custom_qr_generator_2/shapes/frame_shape.dart';
import 'package:custom_qr_generator_2/shapes/pixel_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:generatekey/ModelDataBase/TableBarcode.dart';
import 'package:http/http.dart';
import 'Ring.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class Cartbarcode extends StatefulWidget {

  final TableBarcode data;

  final VoidCallback Delete;

  final TextEditingController txt_username;

  const Cartbarcode({super.key, required this.data,required this.txt_username,required this.Delete});

  @override
  State<Cartbarcode> createState() => _CartbarcodeState();
}

class _CartbarcodeState extends State<Cartbarcode> with TickerProviderStateMixin {

  late WidgetsBinding _widgetsBinding;

  late AnimationController _animationController;
  late Animation _animation;
  late Animation _animationColor;

  @override
  void initState() {

    _widgetsBinding = WidgetsBinding.instance;

    // TODO: implement initState
    super.initState();

    _widgetsBinding.addPostFrameCallback((timestamp){

    });

  }

  late DataOutPut dataOutPut;

  int _duration = 120;

  Future<DataOutPut> GetData() async {

    String BaseUri = 'http://192.168.8.100';

    String body1 = '{"username":"${widget.data.UserName}","password":"${widget.data.Password}"}';

    var bb1 = jsonDecode(body1);

    Response res1 = await post(Uri.parse('${BaseUri}/register'),body:bb1);

    var rres1 = jsonDecode(res1.body);

    ////////////////////////////////

    String body2 = '{"username":"${widget.data.UserName}","label":"${widget.data.Label}"}';

    var bb2 = jsonDecode(body2);

    Response res2 = await post(Uri.parse('${BaseUri}/enable-2fa'),body:bb2);

    var rres2 = jsonDecode(res2.body);

    dataOutPut = DataOutPut.fromJson(rres2['data']);

    _animationController = AnimationController(
        duration: Duration(seconds: _duration),
        vsync: this);

    _animation = Tween(begin: _duration, end: 0.0).animate(_animationController);

    _animationColor = ColorTween(begin: Colors.blueAccent, end: Colors.red).animate(_animationController);

    var df = 1 - (dataOutPut.second/_duration);

    _animationController.forward(from: df);

    _animationController.addListener((){
      if(_animationController.isCompleted){
        setState(() {});
      }
    });

    int ii = 2;

    return dataOutPut;

  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  String _DurationSplit(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if(duration.inHours > 0)
        hours,
      minutes,
      seconds
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 0.9.sw,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0,
              blurRadius: 5,
              blurStyle: BlurStyle.outer
            )
          ]
        ),
        margin: EdgeInsets.symmetric(
          vertical: 15.h
        ),
        clipBehavior: Clip.hardEdge,
        child: FutureBuilder(
            future: GetData(),
            builder: (child,data){
              if(data.hasData){
                return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context,_child){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300
                            ),
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 7
                            ),
                            child: Text('${data.data!.label}',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 0.8.sw,
                            width: 0.8.sw,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomPaint(
                                painter: Ring(borderColor: _animationColor.value, progress: (_animation.value/_duration)),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: FittedBox(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          CustomPaint(
                                            painter: QrPainter(
                                              data: data.data!.token,
                                              options: const QrOptions(
                                                shapes: QrShapes(
                                                    darkPixel: QrPixelShapeRoundCorners(
                                                        cornerFraction: .5
                                                    ),
                                                    frame: QrFrameShapeRoundCorners(
                                                        cornerFraction: .25
                                                    ),
                                                    ball: QrBallShapeRoundCorners(
                                                        cornerFraction: .25
                                                    )
                                                ),
                                                colors: QrColors(
                                                    dark: QrColorLinearGradient(
                                                        colors: [
                                                          Color.fromARGB(255, 255, 0, 0),
                                                          Color.fromARGB(255, 0, 0, 255),
                                                        ],
                                                        orientation: GradientOrientation.leftDiagonal
                                                    ),
                                                    background: QrColorSolid(Colors.transparent)
                                                ),
                                              ),
                                            ),
                                            size: Size(0.8.sw,0.8.sw),
                                          ),

                                          Text(data.data!.token,
                                              style: TextStyle(
                                                  fontSize: 50.sp,
                                                  fontWeight: FontWeight.bold
                                              ),
                                              textAlign: TextAlign.center),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 7
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection: TextDirection.rtl,
                              children: [

                                IconButton(
                                    onPressed: () async {

                                      widget.txt_username.text = widget.data.UserName;

                                      await Clipboard.setData(ClipboardData(text: dataOutPut.token));

                                      Fluttertoast.showToast(
                                          msg: "کپی شد",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.lightGreen,
                                          textColor: Colors.black,
                                          fontSize: 20.0.sp
                                      );

                                    },
                                    icon: Icon(Icons.copy,color: Colors.blue,size: 30.r)
                                ),

                                Text(_DurationSplit(Duration(seconds: _animation.value.toInt())),
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Seven',
                                      color: Colors.green
                                  ),
                                ),

                                IconButton(
                                    onPressed: widget.Delete,
                                    icon: Icon(Icons.delete,color: Colors.red,size: 30.r)
                                ),

                              ],
                            ),
                          )

                        ],
                      );
                    }
                );
              }
              else if(data.hasError){
                return Text(data.error.toString());
              }
              else {
                return Center(
                  child: Container(
                    width: 50,height: 50,
                      margin: EdgeInsets.all(10),
                      child: CircularProgressIndicator(color: Colors.indigo,strokeWidth: 5)
                  ),
                );
              }
            }
        ),
      ),
    );
  }

}

class DataOutPut {

  late String url;
  late String label;
  late String token;
  late int second;

  DataOutPut.fromJson(Map Input) {
    url = Input['url'];
    label = Input['label'];
    token = Input['token'];
    second = Input['second'];
  }

}
