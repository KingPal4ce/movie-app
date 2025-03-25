import 'package:flutter/material.dart';

class ToggleScreens extends StatelessWidget {
  const ToggleScreens({super.key, required this.onTap, required this.text, required this.toggleText});

  final String text;
  final String toggleText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text(text), GestureDetector(onTap: onTap, child: Text(toggleText, style: TextStyle(fontWeight: FontWeight.bold)))],
      ),
    );
  }
}
