import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'default_loading_button.dart';

class DefaultSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final String label;
  final bool noPadding;
  final double? width;
  final bool isOutlineButton;
  final Color? btnColor;

  const DefaultSubmitButton({
    Key? key,
    required this.label,
    this.isLoading = false,
    this.noPadding = false,
    this.width,
    this.onTap,
    this.btnColor,
    this.isOutlineButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
      child: isLoading
          ? const DefaultLoadingButton()
          : ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
              child: Text(
                label,
                selectionColor: isOutlineButton ? Colors.white : Colors.blue[900],
              ),
            ),
    )
        .width(width ?? double.infinity)
        .padding(
          vertical: noPadding ? 0 : 12,
          horizontal: noPadding ? 0 : 21,
        )
        .safeArea(
          top: !noPadding,
          bottom: !noPadding,
        );
  }
}
