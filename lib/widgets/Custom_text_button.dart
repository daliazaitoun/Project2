import 'package:flutter/material.dart';
import 'package:project2/utils/color_utilis.dart';

class CustomTextButton extends StatelessWidget {
 final String label;
  final void Function()? onPressed;
 const CustomTextButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        TextButton(
          child: Text(
            label,
            style:
                const TextStyle(color: ColorUtility.deepYellow, fontSize: 15),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
