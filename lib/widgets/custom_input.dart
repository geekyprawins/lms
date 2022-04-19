import 'package:flutter/material.dart';
import 'package:lms_edutekzila/utils/constants.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    Key? key,
    required this.title,
    required this.ctrl,
    required this.isObscure,
    required this.textInputType,
    required this.textInputAction,
    required this.focusNode,
    required this.nextFocusNode,
    this.trailing,
  }) : super(key: key);
  final String title;
  final TextEditingController ctrl;
  final bool isObscure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  final Widget? trailing;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  // Toggles the password show status
  bool? _obscureText;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLines: null,
      autofocus: true,
      decoration: kInputTextFieldDecoration.copyWith(
          labelText: widget.title,
          suffixIcon: widget.isObscure
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye_sharp),
                  onPressed: _toggle,
                )
              : null),
      controller: widget.ctrl,
      obscureText: _obscureText!,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onFieldSubmitted: (value) {
        widget.focusNode.unfocus();
        FocusScope.of(context).requestFocus(widget.nextFocusNode);
      },
    );
  }
}
