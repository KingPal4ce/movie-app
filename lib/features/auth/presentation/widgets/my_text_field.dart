import 'package:flutter/material.dart';

enum ContentType { email, username, password }

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.contentType,
    required this.textController,
  });

  final String hintText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  final ContentType contentType;
  final TextEditingController textController;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool showText = false;

  _showVisibilityIcon(ContentType contentType) {
    switch (contentType) {
      case ContentType.password:
        return GestureDetector(onTap: _toggleTextVisibility, child: Icon(showText ? Icons.visibility_off : Icons.visibility));
      default:
        return null;
    }
  }

  _toggleTextVisibility() => setState(() => showText = !showText);

  TextInputType _getKeyboardType(ContentType contentType) {
    switch (contentType) {
      case ContentType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  TextCapitalization _textCapitalization(ContentType contentType) {
    switch (contentType) {
      case ContentType.email:
        return TextCapitalization.none;
      default:
        return TextCapitalization.words;
    }
  }

  bool _enableSuggestions(ContentType contentType) {
    switch (contentType) {
      case ContentType.username:
        return false;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffix: _showVisibilityIcon(widget.contentType),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange.shade900), borderRadius: BorderRadius.circular(10)),
      ),
      obscureText: widget.contentType == ContentType.password ? !showText : false,
      enableSuggestions: _enableSuggestions(widget.contentType),
      keyboardType: _getKeyboardType(widget.contentType),
      autocorrect: false,
      textCapitalization: _textCapitalization(widget.contentType),
      validator: widget.validator,
    );
  }
}
