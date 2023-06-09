import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.4,
        child: Image.asset('assets/images/bmi.png',fit: BoxFit.fill,),
      ),
    );
  }
}
