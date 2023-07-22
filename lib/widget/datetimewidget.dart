import 'package:flutter/material.dart';

import '../constant/appstyle.dart';

// ignore: camel_case_types
class dateTimeWidget extends StatelessWidget {
  const dateTimeWidget({
    super.key,
    required this.title,
    required this.textValue,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String textValue;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.headingone,
          ),
          const SizedBox(
            height: 6,
          ),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(icon),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(textValue)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
