import 'package:flutter/material.dart';
import 'package:flutter_base_project/src/core/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; 
class PrimaryButton extends StatelessWidget {
  String? title;
  Function? onPressed;
  bool? isloading;
  double? width;
  Color? foregroundColor, backgroundColor;
  double? fontsize;
  double? height;
  double? borderRadius = subMargin;
  IconData? icon;
  double? borderWidth = 0;
  Color? borderColor = Colors.transparent;

  PrimaryButton(
      {Key? key,
      this.title,
      this.width,
      this.onPressed,
      this.foregroundColor,
      this.backgroundColor,
      this.fontsize,
      this.icon,
      this.height,
      this.borderRadius,
      this.borderWidth,
      this.borderColor,
      this.isloading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
          borderRadius == null ? height ?? buttonHeight : borderRadius!),
      child: Material(
        child: InkWell(
          onTap: isloading! ? null : onPressed as void Function()?,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: borderWidth ?? 0,
                    color: borderColor ?? Colors.transparent),
                color: backgroundColor ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(borderRadius == null
                    ? height ?? buttonHeight
                    : borderRadius!)),
            height: height ?? 50,
            width: width ?? MediaQuery.of(context).size.width,
            child: Center(
              child: isloading!
                  ? Center(
                      child: SpinKitThreeBounce(
                      color: foregroundColor,
                      size: buttonHeight * 0.50,
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null
                            ? Icon(
                                Icons.login,
                                size: buttonHeight - 10,
                              )
                            : const SizedBox.shrink(),
                        icon != null
                            ? SizedBox(
                                width: mainMargin,
                              )
                            : const SizedBox.shrink(),
                        Text(
                          title!,
                          style: TextStyle(
                              color: foregroundColor ??
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              fontSize: fontsize ?? 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  String? title;
  Function? onPressed;
  bool? isloading;
  double? width;
  double? fontsize;
  Color? foregroundColor, backgroundColor;
  double? height;
  double? borderRadius;

  BorderedButton(
      {Key? key,
      this.title,
      this.width,
      this.onPressed,
      this.foregroundColor,
      this.backgroundColor,
      this.fontsize,
      this.height,
      this.borderRadius,
      this.isloading=false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isloading! ? null : onPressed as void Function()?,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 2, color: foregroundColor!),
            borderRadius: BorderRadius.circular(borderRadius ?? subMarginHalf)),
        height: height ?? 60,
        width: width ?? MediaQuery.of(context).size.width,
        child: Center(
          child: isloading!
              ? Center(
                  child: SizedBox(
                  width: height == null ? 40 : height! - 20,
                  height: height == null ? 40 : height! - 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color?>(foregroundColor),
                    backgroundColor: backgroundColor,
                    strokeWidth: 2,
                  ),
                ))
              : Text(
                  title!,
                  style: TextStyle(
                      color: foregroundColor,
                      fontSize: fontsize ?? 23,
                      fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
