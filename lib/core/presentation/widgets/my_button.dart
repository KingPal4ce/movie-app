import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        // padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          // color
          color: Theme.of(context).colorScheme.tertiary,

          // curved corners
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary)),
        ),
      ),
    );
  }
}
