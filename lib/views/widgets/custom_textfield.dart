import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class CustomTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String? hintText;
  final bool? normal;
  final String? title;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;
  final bool? enabled;
  final bool isCode;
  final bool obscureText;
  final bool autoFocus;
  final bool busy;
  final bool enableCopy;
  final FocusNode? focusNode;
  final String? obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextField({
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.hintText,
    this.textInputAction,
    this.textInputType,
    this.textAlign,
    this.onChanged,
    this.controller,
    this.readOnly,
    this.obscureText = false,
    this.obscuringCharacter,
    this.maxLines = 1,
    this.onTap,
    this.autoFocus = false,
    this.focusNode,
    this.maxLength,
    this.title,
    this.normal = false,
    this.enabled,
    this.suffix,
    this.inputFormatters,
    this.isCode = false,
    this.busy = false,
    this.enableCopy = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 6.h, top: 16.h),
                child: regularText(
                  title!,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Spacer(),
              if (busy)
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.darkBlue),
                  ),
                  height: 10.h,
                  width: 10.h,
                )
            ],
          )
        else
          SizedBox(height: 16.h),
        TextFormField(
          enableInteractiveSelection: enableCopy,
          cursorColor: AppColors.black.withOpacity(0.4),
          cursorWidth: 1.h,
          focusNode: focusNode,
          autofocus: autoFocus,
          maxLines: maxLines,
          enabled: enabled ?? true,
          maxLength: maxLength,
          textInputAction: textInputAction,
          style: GoogleFonts.dmSans(
            color: AppColors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.all(15.h),
            hintText: hintText,
            hintStyle: GoogleFonts.dmSans(
              color: AppColors.textGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor:isCode ? AppColors.white: AppColors.grey2,
            errorStyle: GoogleFonts.dmSans(
              color: AppColors.red,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffix: suffix,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey2,
                width: 2.h,
              ),
              borderRadius: BorderRadius.circular(6.h),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey2,
                width: 2.h,
              ),
              borderRadius: BorderRadius.circular(6.h),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey2,
                width: 2.h,
              ),
              borderRadius: BorderRadius.circular(6.h),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey2,
                width: 2.h,
              ),
              borderRadius: BorderRadius.circular(6.h),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey2,
                width: 2.h,
              ),
              borderRadius: BorderRadius.circular(6.h),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey2,
                width: 2.h,
              ),
              borderRadius: BorderRadius.circular(6.h),
            ),
          ),
          obscureText: obscureText,
          onTap: onTap,
          obscuringCharacter: '●',
          controller: controller,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: textInputType,
          onFieldSubmitted: onSaved,
          validator: validator,
          onChanged: onChanged,
        )
      ],
    );
  }
}
