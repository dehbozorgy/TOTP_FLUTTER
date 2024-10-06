import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CartBank extends StatefulWidget {

  String? Function(String?)? Validator;

  String? hint;

  TextDirection? textDirection;

  TextAlign? textAlign;

  TextInputType? textInputType;

  TextEditingController? controller;

  int? length;

  CartBank({super.key, this.Validator, this.hint, this.textDirection,  this.textAlign,  this.textInputType,  this.controller,  this.length});

  @override
  State<CartBank> createState() => _CartBankState();
}

class _CartBankState extends State<CartBank> {

  late FocusNode _focusNode;

  late TextEditingController _controller;

  late MaskTextInputFormatter _maskTextInputFormatter;

  String PathPng = '';

  String getPngBank(String Input){
    return switch(Input){
      'بانک آینده' => 'assets/bank/ayande.png',
      'بانک انصار' => 'assets/bank/ansar.png',
      'بانک ایران زمین' => 'assets/bank/iran_zamin.png',
      'بانک پارسیان' => 'assets/bank/parsian.png',
      'بانک پاسارگاد' => 'assets/bank/pasargad.png',
      'پست بانک ایران' => 'assets/bank/post_bank.png',
      'بانک تجارت' => 'assets/bank/tejarat.png',
      'بانک توسعه تعاون' => 'assets/bank/tosee.png',
      'بانک رسالت' => 'assets/bank/resalat.png',
      'بانک توسعه صادرات' => 'assets/bank/tosee_saderat.png',
      'بانک حکمت ایرانیان' => 'assets/bank/hekmat_iranian.png',
      'بانک خاورمیانه' => 'assets/bank/khavarmianeh.png',
      'بانک اقتصاد نوین' => 'assets/bank/en.png',
      'بانک دی' => 'assets/bank/day.png',
      'بانک رفاه کارگران' => 'assets/bank/refah.png',
      'بانک سامان' => 'assets/bank/saman.png',
      'بانک سپه' => 'assets/bank/sepah.png',
      'بانک سرمایه' => 'assets/bank/sarmaye.png',
      'بانک سینا' => 'assets/bank/sina.png',
      'بانک شهر' => 'assets/bank/shahr.png',
      'بانک صادرات ایران' => 'assets/bank/saderat.png',
      'بانک صنعت و معدن' => 'assets/bank/sanat_madan.png',
      'بانک قوامین' => 'assets/bank/ghavamin.png',
      'بانک کارآفرین' => 'assets/bank/karafarin.png',
      'بانک کشاورزی' => 'assets/bank/keshavarzi.png',
      'بانک گردشگری' => 'assets/bank/gardeshgari.png',
      'بانک مرکزی' => 'assets/bank/central.png',
      'بانک مسکن' => 'assets/bank/maskan.png',
      'بانک ملت' => 'assets/bank/mellat.png',
      'بانک ملی ایران' => 'assets/bank/melli.png',
      'بانک قرض الحسنه مهر ایران' => 'assets/bank/mehr_iranian.png',
      'موسسه کوثر' => 'assets/bank/kousar.png',
      'موسسه اعتباری ملل' => 'assets/bank/asgariye.png',
      'موسسه اعتباری توسعه' => 'assets/bank/tosee_finance.png',
      'بانک مهر اقتصاد' => 'assets/bank/mehr_eghtesad.png',
        '-' => 'assets/bank/block.png',
        _ => 'assets/bank/block.png'
    };
  }

  @override
  void initState() {

    _maskTextInputFormatter = MaskTextInputFormatter(
        mask: '#### - #### - #### - ####',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );

    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
    // TODO: implement initState
    super.initState();

    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      }
    });

    _controller.addListener(() {

      String tt = _maskTextInputFormatter.unmaskText(_controller.text);
      int ln = tt.length;

      if(ln >= 6) {
        PathPng = getPngBank(tt.getBankNameFromCardNumber());
      }
      else {
        PathPng = '';
      }

      setState(() {});

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
                _maskTextInputFormatter
              ],
              decoration: InputDecoration(
                filled: true,
                // fillColor: Colors.grey.shade300,
                fillColor: Colors.white,
                hintText: widget.hint,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                prefixIcon : (widget.textDirection==TextDirection.ltr) ?
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: widget.textDirection,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: PathPng!='' ? Image.asset(PathPng,fit: BoxFit.fill) : SizedBox(width: 0,height: 0)
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                        width: 10,
                      )
                    ],
                  ),
                ) : null,

                suffixIcon: (widget.textDirection==null || (widget.textDirection==TextDirection.rtl)) ?
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: PathPng!='' ? Image.asset(PathPng,fit: BoxFit.fill) : SizedBox(width: 0,height: 0)
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                        width: 10,
                      )
                    ],
                  ),
                ) : null,

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
