import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generatekey/ModelDataBase/TableBarcode.dart';
import 'package:generatekey/PageBarcode/PageBarcode.dart';
import 'package:generatekey/PagePayment/PagePayment.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {

  await ScreenUtil.ensureScreenSize();

  await Hive
    ..initFlutter()
    ..registerAdapter(TableBarcodeAdapter())
  ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff43c79f, {
          50: Color.fromRGBO(67, 199, 159, 0.1),
          100: Color.fromRGBO(67, 199, 159, 0.2),
          200: Color.fromRGBO(67, 199, 159, 0.3),
          300: Color.fromRGBO(67, 199, 159, 0.4),
          400: Color.fromRGBO(67, 199, 159, 0.5),
          500: Color.fromRGBO(67, 199, 159, 0.6),
          600: Color.fromRGBO(67, 199, 159, 0.7),
          700: Color.fromRGBO(67, 199, 159, 0.8),
          800: Color.fromRGBO(67, 199, 159, 0.9),
          900: Color.fromRGBO(67, 199, 159, 1),
        }),
        primaryColor: Color(0xff43c79f),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  TextEditingController txt_username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Builder(builder: (context){
            ScreenUtil.init(context, designSize: const Size(360, 690));
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PageBarcode(txt_username: txt_username)));
                      },
                      child: Text('Page Generate Key ... ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        )
                      ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PagePayment(Username: txt_username.text)));
                      },
                      child: Text('Page Payment ... ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                          )
                      ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)
                    ),
                  ),

                ],
              ),
            );
          })
      ),
    );
  }


}
