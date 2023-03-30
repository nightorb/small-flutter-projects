import 'package:flutter/material.dart';

class InteractionButton extends StatelessWidget {
  final String buttonName;
  final String result;
  final void Function() onButtonPress;

  const InteractionButton({required this.buttonName, required this.result, required Function() this.onButtonPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          result,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: onButtonPress,
          child: Text(buttonName),
        ),
      ],
    );
  }
}