import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
 import 'package:mms_app/views/widgets/utils.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
     this.body,
    this.title,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.removeBack = false,
  })  ;

  final Widget? body;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool removeBack;

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.offKeyboard();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: widget.title == null
            ? null
            : AppBar(
                centerTitle: true,
                elevation: 0,
                leading: widget.removeBack
                    ? SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.darkBlue,
                            ),
                          )
                        ],
                      ),
                iconTheme: IconThemeData(color: AppColors.darkBlue),
                title: regularText(
                  widget.title!,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              ),
        body: widget.body,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
      ),
    );
  }
}
