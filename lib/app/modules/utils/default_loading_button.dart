import 'package:flutter/material.dart';

class DefaultLoadingButton extends StatelessWidget {
  const DefaultLoadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ElevatedButton(
      onPressed: null,
      child: SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
