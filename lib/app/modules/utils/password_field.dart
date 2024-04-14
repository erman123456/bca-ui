import 'package:bca/app/modules/utils/form_utils.dart';
import 'package:bca/constants/assets.dart';
import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:get/get.dart';

class PasswordFormField extends StatelessWidget {
  final isObscureText = true.obs;

  final String? labelText;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final int minLength;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool withRegex;

  PasswordFormField({
    Key? key,
    this.labelText,
    this.hint,
    this.controller,
    this.errorText,
    this.validator,
    this.onChanged,
    this.minLength = 4,
    this.withRegex = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: labelText,
          hintText: hint,
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              isObscureText.value ? Assets.bIconlyHide : Assets.bIconlyShow,
              colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.srcIn),
            ),
            onPressed: () => isObscureText.toggle(),
          ),
        ),
        obscureText: isObscureText.value,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ??
            (value) => FormUtils.passwordValidation(value,
                minLength: minLength, withRegex: withRegex),
      ),
    );
  }
}
