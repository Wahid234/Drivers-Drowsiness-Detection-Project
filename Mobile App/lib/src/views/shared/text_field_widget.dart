import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      this.controller,
      this.initialValue,
      this.validator,
      this.keyboardType,
      this.onChanged,
      this.focusNode,
      this.inputFormatters,
      this.readOnly,
      this.placeHolder,
      this.textAlign,
      this.onTap,
      this.labelText,
      this.obscureText,
      this.textDirection,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputAction,
      this.maxLines})
      : super(key: key);
  final TextEditingController? controller;
  final String? initialValue;
  final String? labelText;
  final String? placeHolder;
  final bool? readOnly;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;

  // final IconData? icon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child:Text(
              labelText!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6173D2),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ),
        TextFormField(
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          initialValue: initialValue,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textDirection: textDirection,
          controller: controller,
          readOnly: readOnly ?? false,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          onTap: onTap,
          focusNode: focusNode,
          textAlign: textAlign ?? TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.h),
                borderSide: const BorderSide(
                  color: Color(0xFFB1B1B1),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFB1B1B1),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFB1B1B1),
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFFF4848),
                  width: 1,
                ),
              ),
              hintText: placeHolder,
              hintStyle:  TextStyle(
                color: Color(0xFFD1D1D1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon),
        ),
      ],
    );
  }
}
