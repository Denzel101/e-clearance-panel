import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, required this.onPressed, required this.buttonName})
      : super(key: key);
  final VoidCallback onPressed;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 100.0, vertical: 12.5),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.attach_file),
            const SizedBox(
              width: 20.0,
            ),
            Text(buttonName),
          ],
        ));
  }
}
