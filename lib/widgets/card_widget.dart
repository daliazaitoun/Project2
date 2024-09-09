import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final void Function() onPressed;
  const CardWidget({super.key, required this.title, required this.onPressed});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xffEBEBEB),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        
          
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title ,style: const TextStyle(
                fontSize: 16
              ),),
            ),
            const Spacer(),
            IconButton(
             icon: const Icon(Icons.keyboard_double_arrow_right_outlined), onPressed: widget.onPressed),
          ],
        ),
      ),
    );
  }
}
