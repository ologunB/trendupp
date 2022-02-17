import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> list;
  final String Function(String?)? onChanged;
  final String? value;
  final String hintText;
  final String? title;

  CustomDropDownButton(
      {required this.list,
      required this.onChanged,
      required this.value,
      required this.hintText,
      this.title});

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: regularText(widget.title!,
                  fontSize: 12.sp, color: AppColors.black),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            decoration: BoxDecoration(
                color: AppColors.grey2,
                borderRadius: BorderRadius.circular(8.h),
                border: Border.all(
                  width: 1.h,
                  color: AppColors.grey2,
                )),
            height: 50.h,
            alignment: Alignment.center,
            child: DropdownButton<String>(
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: AppColors.textGrey,
                fontSize: 12.sp,
              ),
              isExpanded: true,
              hint: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  widget.hintText,
                  style: GoogleFonts.dmSans(
                    color: AppColors.textGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              value: widget.value,
              underline: SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.red,
                size: 24.h,
              ),
              onChanged: widget.onChanged,
              items: widget.list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(value,
                        style: GoogleFonts.dmSans(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
