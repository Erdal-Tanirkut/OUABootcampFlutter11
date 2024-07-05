import 'package:flutter/material.dart';
class CustomTextBox extends StatelessWidget {
  final String label;
  final bool isTitle;
  final bool isDescription;

  CustomTextBox({
    required this.label,
    this.isTitle = false,
    this.isDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: isDescription ? Colors.grey : (isTitle ? Colors.black : Colors.grey),
        fontSize: isTitle ? 14.0 : (isDescription ? 14.0 : 16.0),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(color: Colors.red, width: 2.0),
        ),
        minimumSize: MaterialStateProperty.all(Size(335, 50)),
      ),
    );
  }
}