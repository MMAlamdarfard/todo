import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final int maxline;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.maxline,
      this.textEditingController,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
          controller: textEditingController,
          onChanged:onChanged,
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText),
          maxLines: maxline,
        ));
  }
}
