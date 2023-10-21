import "package:flutter/material.dart";

class WaitLocationWidget extends StatelessWidget {
  final String message;

  const WaitLocationWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(this.message),
          SizedBox(
            height: 15,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
    ;
  }
}
