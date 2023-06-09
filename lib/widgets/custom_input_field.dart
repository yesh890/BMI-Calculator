import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final TextEditingController controller;

  const CustomInputField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.validator,
      this.suffixIcon = false,
      this.isDense,
      this.obscureText = false, required this.controller});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: TextFormField(
        controller: widget.controller,
        obscureText: (widget.obscureText && _obscureText),
        decoration: InputDecoration(
          isDense: (widget.isDense != null) ? widget.isDense : false,
          labelText: widget.labelText,
          labelStyle:
              const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans",
        ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans",
        ),
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.remove_red_eye
                        : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          suffixIconConstraints: (widget.isDense != null)
              ? const BoxConstraints(maxHeight: 33)
              : null,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
      ),
    );
  }
}
