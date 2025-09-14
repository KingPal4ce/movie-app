import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({super.key, required this.text});

  final String text;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  bool isTextOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkOverflow());
  }

  void checkOverflow() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: const TextStyle(fontSize: 14)),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);
    setState(() {
      isTextOverflowing = textPainter.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: isExpanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 65),
          child: Text(widget.text, softWrap: true, overflow: TextOverflow.fade, style: const TextStyle(fontSize: 14)),
        ),
        if (isTextOverflowing)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Text(isExpanded ? 'Show Less' : 'Read More', style: const TextStyle(color: Colors.blue, fontSize: 14)),
          ),
      ],
    );
  }
}
