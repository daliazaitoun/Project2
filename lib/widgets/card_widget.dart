import 'package:flutter/material.dart';
import 'package:project2/utils/color_utilis.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final void Function() onPressed;
  CardWidget({super.key, required this.title, required this.onPressed});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer : false,
    //  borderOnForeground :false,
      color: Color(0xffEBEBEB),
      child: ListTile(
        title: Text(widget.title),
        trailing: IconButton(
            icon: Icon(Icons.double_arrow), onPressed: widget.onPressed),
      ),
    );
  }
}
