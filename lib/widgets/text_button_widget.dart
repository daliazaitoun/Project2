import 'package:flutter/material.dart';
import 'package:project2/utils/color_utilis.dart';

class TextButtonWidget extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  const TextButtonWidget(
      {super.key, required this.text, required this.onPressed});

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: ColorUtility.grayLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 17,color: Colors.black),
      ),
    );
  }
}
