import 'package:flutter/material.dart';

const kInputFieldColor = Color(0xFFF0F0F0);

const kButtonGradient = LinearGradient(
  colors: [
    Colors.orange,
    Colors.orangeAccent,
  ],
);

const kInputTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: kInputFieldColor,
  hintStyle: TextStyle(
    color: Colors.black38,
  ),
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kInputFieldColor,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kInputFieldColor,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  ),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.black38),
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
