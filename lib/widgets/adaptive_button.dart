import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  const AdaptiveTextButton(this.btnLabel, this.btnHandler);

  final String btnLabel;
  final Function btnHandler;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              btnLabel,
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onPressed: btnHandler,
          )
        : TextButton(
            onPressed: btnHandler,
            child: Text(
              btnLabel,
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          );
  }
}
