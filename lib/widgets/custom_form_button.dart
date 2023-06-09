import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  const CustomFormButton({super.key, required this.innerText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(26),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(innerText, style: const TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}