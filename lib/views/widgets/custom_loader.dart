import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mms_app/app/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.defaultSize.height / 3,
      alignment: Alignment.center,
      child: SpinKitDoubleBounce(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      index.isEven ? AppColors.darkBlue : AppColors.textGrey,
                  borderRadius: BorderRadius.circular(100.h)),
            );
          },
          size: 40.h),
    );
  }
}
