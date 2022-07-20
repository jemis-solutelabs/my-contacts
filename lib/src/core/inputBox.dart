import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/src/core/colors.dart';
import 'package:flutter_base_project/src/core/constant.dart';

class InputBox extends StatefulWidget {
  TextEditingController? controller;
  String? labelText, errorText;
  Function? onchanged;
  List<TextInputFormatter>? inuptformat;
  bool obscureText, error;
  bool ispassword = false;
  bool istextarea = false;
  bool readonly = false;
  TextInputType? keyboardtype;
  int? minLine = 1;
  int? maxLength = 300;
  bool? isRounded;
  Widget? prefix;
  Color? bgcolor;
  Widget? suffixIcon;
  double? fontSize;
  int? maxLines;
  Color? color;
  VoidCallback? onTap;

  InputBox(
      {this.controller,
      this.labelText,
      this.error = false,
      this.color,
      this.keyboardtype,
      this.errorText,
      this.inuptformat,
      this.obscureText = false,
      this.ispassword = false,
      this.istextarea = false,
      this.readonly = false,
      this.maxLength,
      this.maxLines,
      this.fontSize,
      this.minLine,
      this.prefix,
      this.isRounded = true,
      this.bgcolor,
      this.onchanged,
      this.onTap,
      this.suffixIcon});

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool? error, obscureText, hidepass = false;

  @override
  void initState() {
    if (widget.obscureText) {
      setState(() {
        hidepass = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: widget.bgcolor ?? transparent,
          borderRadius: BorderRadius.circular(
              widget.isRounded! ? buttonHeight : subMarginHalf)),
      child: TextField(
        onTap: widget.onTap,
        controller: widget.controller,
        cursorColor: Theme.of(context).primaryColor,
        obscureText: hidepass!,
        onChanged: widget.onchanged as void Function(String)?,
        inputFormatters: widget.inuptformat,
        maxLines: widget.istextarea ? widget.maxLines : 1,
        textAlignVertical: TextAlignVertical.center,
        readOnly: widget.readonly,
        maxLength: widget.maxLength,
        textAlign: TextAlign.start,
        keyboardType: widget.keyboardtype ?? TextInputType.text,
        minLines: widget.minLine,
        textInputAction: TextInputAction.next,
        style: TextStyle(

            //height: 2,
            fontSize: widget.fontSize ?? 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.headline1!.color,
            decoration: TextDecoration.none),
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
          fillColor: widget.bgcolor,
          filled: true,
          errorText: widget.error ? widget.errorText : null,

          contentPadding: EdgeInsets.all(subMargin + 8),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
            fontSize: mainMargin,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                widget.isRounded! ? buttonHeight : subMarginHalf),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                widget.isRounded! ? buttonHeight : subMarginHalf),
            borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor.withOpacity(0.7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                widget.isRounded! ? buttonHeight : subMarginHalf),
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).textTheme.headline1!.color!),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.isRounded! ? buttonHeight : subMarginHalf),
              borderSide: const BorderSide(
                width: 1,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.isRounded! ? buttonHeight : subMarginHalf),
              borderSide: BorderSide(width: 1.5, color: errorColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.isRounded! ? buttonHeight : subMarginHalf),
              borderSide: BorderSide(width: 2, color: errorColor)),
          //  isDense: true,
          errorStyle: TextStyle(color: errorColor, height: 0),
          alignLabelWithHint: true,
          prefixIcon: widget.prefix == null
              ? null
              : Padding(
                  padding: EdgeInsets.only(left: subMargin),
                  child: widget.prefix,
                ),

          suffixIcon: widget.ispassword
              ? IconButton(
                  onPressed: () {
                    if (widget.ispassword) {
                      setState(() {
                        if (hidepass == true) {
                          hidepass = false;
                        } else {
                          hidepass = true;
                        }
                      });
                    }
                  },
                  splashColor: Colors.transparent,
                  icon: Icon(
                    hidepass!
                        ? Icons.no_encryption_outlined
                        : Icons.lock_outline,
                    color: widget.ispassword
                        ? Theme.of(context).textTheme.headline1!.color
                        : white,
                  ),
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
