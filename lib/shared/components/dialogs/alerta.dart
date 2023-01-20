import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../colors.dart';

alertaApp(BuildContext context, String message, [String buttonText = "OK"]) {
  var size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: branco,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: const BorderSide(color: primary, width: 3)),
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.6,
              constraints: BoxConstraints(
                minWidth: size.width * 0.9,
                minHeight: size.width * 0.6,
              ),
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "PassionOne",
                              fontSize: 32,
                              color: Colors.black)),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      fixedSize: Size(size.width * 0.65, 62),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                          fontFamily: "PassionOne",
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ));
}
