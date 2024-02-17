import 'package:flutter/material.dart';

void showCustomSnackbar( {required BuildContext context, required String title }) {

  ScaffoldMessenger.of(context).clearSnackBars();

  final snakback = SnackBar(
    content: Text(title),
    action: SnackBarAction(label: 'Ok!', onPressed: () {}),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snakback);
}
