import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;

  AdaptiveFlatButton({
    @required this.onPressed,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    int platformCode = 0; // 1 is iPhone, 0 is non-iphone
    if (kIsWeb) {
      platformCode = 0;
    } else if (Platform.isIOS) {
      platformCode = 1;
    }

    return platformCode == 1
        ? CupertinoButton(
            child: Text(buttonText),
            onPressed: onPressed,
          )
        : FlatButton(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: onPressed,
          );
  }
}
