import "package:flutter/material.dart";

class ErrorDetailWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorDetailWidget({required this.errorMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
