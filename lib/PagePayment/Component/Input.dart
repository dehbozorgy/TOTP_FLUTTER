import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Input extends StatefulWidget {

  String? Function(String?)? Validator;

  String? hint;

  TextDirection? textDirection;

  TextAlign? textAlign;

  TextInputType? textInputType;

  TextEditingController? controller;

  int? length;

  Input({super.key, this.Validator,  this.hint, this.textDirection,  this.textAlign,  this.textInputType,  this.controller,  this.length});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  late FocusNode _focusNode;

  late TextEditingController _controller;

  @override
  void initState() {

    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
    // TODO: implement initState
    super.initState();

    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      }
    });

  }

  @override
  void dispose() {
    if(widget.controller==null){
      _controller.dispose();
    }
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer
                )
              ]
          ),
          child: Directionality(
            textDirection: widget.textDirection ?? TextDirection.rtl,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'SansFaNum'
              ),
              validator: widget.Validator,
              focusNode: _focusNode,
              controller: _controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlign: widget.textAlign ?? TextAlign.right,
              keyboardType: widget.textInputType ?? TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.length),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hint,

                contentPadding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
