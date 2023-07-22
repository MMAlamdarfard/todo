import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget(
      {super.key,
      required this.titleRadio,
      required this.categoryColor,
      this.onTap,
      required this.value,
      required this.selectedvalue });
  final String titleRadio;
  final Color categoryColor;
  final Function(int? value)? onTap;
  final int selectedvalue;
  final int value;
  @override
  Widget build(BuildContext context) {
   
    return Expanded(
      child: Material(
        child: Theme(
          data: ThemeData(
              unselectedWidgetColor: categoryColor, disabledColor: Colors.blue),
          child: RadioListTile(
              activeColor: categoryColor,
              contentPadding: EdgeInsets.zero,
              title: Transform.translate(
                offset: const Offset(-22, 0),
                child: Text(
                  titleRadio,
                  style: TextStyle(
                      fontSize: 14,
                      color: categoryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              value: value,
              groupValue: selectedvalue,
              onChanged: onTap),
        ),
      ),
    );
  }
}
