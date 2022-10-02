import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  String text;

  VoidCallback voidCallback;

  MainButton({required this.text, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: voidCallback,
          child: Text(text)),
    );
  }
}
