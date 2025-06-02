import 'package:flutter/material.dart';

class AIChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const AIChatBubble({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isUserMessage ? Color(0xff2D3568): Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: isUserMessage ? Radius.circular(15) : Radius.zero, bottomRight: isUserMessage ? Radius.zero : Radius.circular(15))
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUserMessage ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}