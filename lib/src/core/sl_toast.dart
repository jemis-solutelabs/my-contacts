import 'package:flutter/material.dart';
import 'package:flutter_base_project/src/core/colors.dart';

class SlToast {
  String msg;
  bool hasError;
  BuildContext context;
  SlToast({required this.context, required this.msg, this.hasError = false});

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: hasError ? errorColor : null,
    ));
  }
}
