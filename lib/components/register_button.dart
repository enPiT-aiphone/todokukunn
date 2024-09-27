import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.onPressed,
  });


  final VoidCallback onPressed;
  
 @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
    );
  }
}
