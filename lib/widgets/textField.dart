import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  const MyField(
      {super.key,
      required this.controller,
      required this.validate,
      required this.errorText,
      required this.hintText});

  final TextEditingController controller;
  final bool validate;
  final String errorText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          controller: controller,
          decoration: InputDecoration(
              errorText: (validate) ? errorText : null,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: Colors.teal, width: 1.5)),
              fillColor: Colors.grey.shade200,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white54)),
          obscureText: true,
        ));
  }
}
