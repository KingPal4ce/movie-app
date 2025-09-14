import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary)),
        const SizedBox(width: 5),
        Text('Or Continue with', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(width: 5),
        Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary)),
      ],
    );
  }
}
