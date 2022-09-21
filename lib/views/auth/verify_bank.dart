import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_drop_down.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:social_share/social_share.dart';

import '../../locator.dart';
import '../base_view.dart';

class VerifyBank extends StatefulWidget {
  const VerifyBank({Key? key, required this.data}) : super(key: key);

  final Map<String, String> data;

  @override
  _VerifyBankState createState() => _VerifyBankState();
}

class _VerifyBankState extends State<VerifyBank> {
  TextEditingController number = TextEditingController();
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (m) => null,
        builder: (_, AuthViewModel model, __) => Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                elevation: 0,
                leading: SizedBox(),
                backgroundColor: AppColors.white,
                centerTitle: true,
                title: Image.asset('assets/images/logo.png', height: 32.h),
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        itemCircle(AppColors.red, isDone: true),
                        itemLine(AppColors.red),
                        itemCircle(AppColors.red, isDone: true),
                        itemLine(AppColors.red),
                        itemCircle(AppColors.red),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        itemText(
                            'Are you a\ncreator?', MainAxisAlignment.start),
                        itemText('User Details', MainAxisAlignment.center),
                        itemText(
                            'Bank Account\nDetails', MainAxisAlignment.end),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  regularText(
                    'Verify Your Bank  Account',
                    fontSize: 24.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 10.h),
                  regularText(
                    'All funds tipped to you by your tippers will\nbe sent to this account at your request',
                    fontSize: 12.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(height: 32.h),
                  isDone ? done(model) : process(model),
                  SizedBox(height: 24.h),
                  buttonWithBorder(
                    isDone ? 'Confirm Account Details' : 'Verify Account',
                    buttonColor: AppColors.red,
                    fontSize: 16.sp,
                    height: 52.h,
                    busy: model.busy,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                    onTap: () async {
                      if (isDone) {
                        Map<String, String> data = {
                          "bankName": bank!,
                          "accName": model.resolvedName!,
                          "accNumber": number.text,
                        };
                        data.addAll(widget.data);
                        bool res =
                            await model.updateProfile(data, CreatorLayout());

                        if (res) {
                          showDialog<AlertDialog>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext cContext) =>
                                congratsDialog(data['userName']!, cContext),
                          );
                        }

                        return;
                      } else {
                        if (number.text.length == 10 && bank != null) {
                          Utils.offKeyboard();
                          String c = allNigerianBanks.firstWhere(
                              (e) => e['bank_name'] == bank)['bank_code'];
                          bool res = await model.resolveAccount(number.text, c);
                          if (res) {
                            isDone = !isDone;
                            setState(() {});
                          }
                        } else {
                          return showSnackBar(
                              context, 'Error', 'Fill in all fields');
                        }
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ));
  }

  String? bank;

  Widget process(AuthViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropDownButton(
          hintText: 'Bank Name',
          onChanged: (String? a) {
            bank = a;
            setState(() {});
            return bank!;
          },
          list: allNigerianBanks.map((e) => e['bank_name'].toString()).toList(),
          value: bank,
        ),
        CustomTextField(
          hintText: 'Account Number',
          controller: number,
          maxLength: 10,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
        if (model.error != null && !model.busy)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: regularText(
              model.error!,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
      ],
    );
  }

  Widget done(AuthViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        regularText(
          'Account Name',
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        regularText(
          model.resolvedName!,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ],
    );
  }

  Widget congratsDialog(String a, BuildContext cContext) {
    return Container(
      color: AppColors.black.withOpacity(.1),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ScreenUtil.defaultSize.width - 8.h,
              padding: EdgeInsets.all(10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(cContext);
                    },
                    child: Image.asset(
                      'assets/images/close.png',
                      width: 28.h,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/mark.png',
              width: 42.h,
              color: AppColors.green,
            ),
            SizedBox(height: 22.h),
            regularText(
              'Congratulations',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
            SizedBox(height: 8.h),
            regularText(
              'You’ve successfully created a profile.\nShare your page with your audience to\nget tippers',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              color: AppColors.textGrey,
            ),
            SizedBox(height: 24.h),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.h),
                    border: Border.all(color: AppColors.grey, width: 1.h),
                    color: AppColors.grey),
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo2.png',
                          height: 20.h,
                        ),
                        SizedBox(width: 12.h),
                        regularText(
                          'trendupp.com/$a',
                          fontSize: 12.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textGrey,
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: 'trendupp.com/$a'));
                          showSnackBar(
                            locator<NavigationService>()
                                .navigationKey
                                .currentContext!,
                            'Copied',
                            'Link has been copied to clipboard',
                          );
                        },
                        child:
                            Image.asset('assets/images/tap.png', height: 24.h))
                  ],
                )),
            SizedBox(height: 32.h),
            regularText(
              'Share on',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
            SizedBox(height: 8.h),
            linksWidget(),
            SizedBox(height: 24.h),
            InkWell(
              onTap: () {
                Navigator.pop(cContext);
                cIndexNotifier.value = 2;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
                decoration: BoxDecoration(
                    color: AppColors.lightRed,
                    borderRadius: BorderRadius.circular(20.h)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    regularText(
                      'View your page',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.red,
                    ),
                    SizedBox(width: 8.h),
                    Image.asset('assets/images/back.png', width: 18.h)
                  ],
                ),
              ),
            ),
            SizedBox(height: 70.h),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
      ),
    );
  }

  Widget linksWidget() {
    String link = 'https://trendupp.com/' + AppCache.getUser()!.userName!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            SocialShare.shareTwitter("Support me on Trendupp ",
                hashtags: ["trendupp", "support"], url: link);
          },
          child: Image.asset('assets/images/tw.png', width: 28.h),
        ),
        SizedBox(width: 30.h),
        InkWell(
          onTap: () {
            SocialShare.shareOptions("Support me on Trendupp on $link");
          },
          child: Image.asset('assets/images/fb.png', width: 28.h),
        ),
        SizedBox(width: 30.h),
        InkWell(
          onTap: () {
            SocialShare.shareWhatsapp("Support me on Trendupp on $link");
          },
          child: Image.asset('assets/images/ws.png', width: 28.h),
        ),
      ],
    );
  }
}

List allNigerianBanks = [
  {"bank_name": "3LINE CARD MANAGEMENT LIMITED", "bank_code": "110005"},
  {"bank_name": "9 PAYMENT SOLUTIONS BANK", "bank_code": "120001"},
  {"bank_name": "AB MICROFINANCE BANK", "bank_code": "090270"},
  {"bank_name": "ABBEY MORTGAGE BANK", "bank_code": "070010"},
  {"bank_name": "ABOVE ONLY MICROFINANCE BANK", "bank_code": "090260"},
  {"bank_name": "ABU MICROFINANCE BANK", "bank_code": "090197"},
  {"bank_name": "ACCELEREX NETWORK LIMITED", "bank_code": "90202"},
  {"bank_name": "ACCELEREX NETWORK LIMITED", "bank_code": "090202"},
  {"bank_name": "Access Bank", "bank_code": "044"},
  {"bank_name": "Access Money", "bank_code": "323"},
  {"bank_name": "ACCESS YELLO & BETA", "bank_code": "100052"},
  {"bank_name": "ACCESS(DIAMOND) BANK", "bank_code": "000005"},
  {"bank_name": "ACCION MICROFINANCE BANK", "bank_code": "090134"},
  {"bank_name": "ADDOSSER MICROFINANCE BANK", "bank_code": "090160"},
  {
    "bank_name": "ADEYEMI COLLEGE STAFF MICROFINANCE BANK",
    "bank_code": "090268"
  },
  {"bank_name": "ADVANS LA FAYETTE  MICROFINANCE BANK", "bank_code": "90155"},
  {"bank_name": "ADVANS LA FAYETTE  MICROFINANCE BANK", "bank_code": "090155"},
  {"bank_name": "AFEKHAFE MICROFINANCE BANK", "bank_code": "090292"},
  {"bank_name": "AG MORTGAGE BANK", "bank_code": "100028"},
  {"bank_name": "AGOSASA MICROFINANCE BANK", "bank_code": "090371"},
  {"bank_name": "AL-BARAKAH MICROFINANCE BANK", "bank_code": "090133"},
  {"bank_name": "AL-HAYAT MICROFINANCE BANK", "bank_code": "090277"},
  {"bank_name": "ALEKUN MICROFINANCE BANK", "bank_code": "090259"},
  {"bank_name": "ALERT MICROFINANCE BANK", "bank_code": "090297"},
  {"bank_name": "ALLWORKERS MICROFINANCE BANK", "bank_code": "090131"},
  {"bank_name": "ALPHA KAPITAL MICROFINANCE BANK", "bank_code": "090169"},
  {"bank_name": "AMAC MICROFINANCE BANK", "bank_code": "090394"},
  {"bank_name": "AMJU UNIQUE MICROFINANCE BANK", "bank_code": "090180"},
  {"bank_name": "AMML MICROFINANCE BANK", "bank_code": "090116"},
  {"bank_name": "APEKS MICROFINANCE BANK", "bank_code": "090143"},
  {"bank_name": "APPLE MICROFINANCE BANK", "bank_code": "090376"},
  {"bank_name": "ARISE MICROFINANCE BANK", "bank_code": "090282"},
  {"bank_name": "ASO Savings and & Loans", "bank_code": "401"},
  {"bank_name": "ASSETMATRIX MICROFINANCE BANK", "bank_code": "090287"},
  {"bank_name": "ASTRAPOLARIS MICROFINANCE BANK", "bank_code": "090172"},
  {"bank_name": "AUCHI MICROFINANCE BANK", "bank_code": "090264"},
  {"bank_name": "BAINES CREDIT MICROFINANCE BANK", "bank_code": "090188"},
  {"bank_name": "BALOGUN GAMBARI MICROFINANCE BANK", "bank_code": "090326"},
  {"bank_name": "BAYERO UNIVERSITY MICROFINANCE BANK", "bank_code": "090316"},
  {"bank_name": "BC KASH MICROFINANCE BANK", "bank_code": "090127"},
  {"bank_name": "BIPC MICROFINANCE BANK", "bank_code": "090336"},
  {"bank_name": "BOCTRUST MICROFINANCE BANK LIMITED", "bank_code": "090117"},
  {"bank_name": "BORGU  MICROFINANCE BANK", "bank_code": "090395"},
  {"bank_name": "BOSAK MICROFINANCE BANK", "bank_code": "090176"},
  {"bank_name": "BOWEN MICROFINANCE BANK", "bank_code": "090148"},
  {"bank_name": "BRENT MORTGAGE BANK", "bank_code": "070015"},
  {"bank_name": "BRETHREN MICROFINANCE BANK", "bank_code": "090293"},
  {"bank_name": "BRIDGEWAY MICROFINANACE BANK", "bank_code": "090393"},
  {"bank_name": "BRIGHTWAY MICROFINANCE BANK", "bank_code": "090308"},
  {"bank_name": "BUSINESS SUPPORT MICROFINANCE BANK", "bank_code": "090406"},
  {"bank_name": "CARBON", "bank_code": "100026"},
  {"bank_name": "CASHCONNECT MICROFINANCE BANK", "bank_code": "090360"},
  {"bank_name": "Cellulant", "bank_code": "317"},
  {"bank_name": "CEMCS MICROFINANCE BANK", "bank_code": "090154"},
  {"bank_name": "CHAMS MOBILE", "bank_code": "100015"},
  {"bank_name": "ChamsMobile", "bank_code": "303"},
  {"bank_name": "CHIKUM MICROFINANCE BANK", "bank_code": "090141"},
  {"bank_name": "CIT MICROFINANCE BANK", "bank_code": "090144"},
  {"bank_name": "CITI BANK", "bank_code": "000009"},
  {"bank_name": "CitiBank", "bank_code": "023"},
  {"bank_name": "COASTLINE MICROFINANCE BANK", "bank_code": "090374"},
  {"bank_name": "CONSUMER MICROFINANCE BANK", "bank_code": "090130"},
  {"bank_name": "COOP MORTGAGE BANK", "bank_code": "070021"},
  {"bank_name": "CORESTEP MICROFINANCE BANK", "bank_code": "090365"},
  {"bank_name": "Coronation Merchant Bank", "bank_code": "559"},
  {"bank_name": "Covenant Microfinance Bank", "bank_code": "551"},
  {"bank_name": "CREDIT AFRIQUE MICROFINANCE BANK", "bank_code": "090159"},
  {"bank_name": "CYBERSPACE LIMITED", "bank_code": "110014"},
  {"bank_name": "DAVODANI  MICROFINANCE BANK", "bank_code": "090391"},
  {"bank_name": "DAYLIGHT MICROFINANCE BANK", "bank_code": "090167"},
  {"bank_name": "Diamond Bank", "bank_code": "063"},
  {"bank_name": "E-BARCS MICROFINANCE BANK", "bank_code": "090156"},
  {"bank_name": "EAGLE FLIGHT MICROFINANCE BANK", "bank_code": "090294"},
  {"bank_name": "Eartholeum", "bank_code": "302"},
  {"bank_name": "Ecobank Plc", "bank_code": "050"},
  {"bank_name": "ECOBANK XPRESS ACCOUNT", "bank_code": "100008"},
  {"bank_name": "EcoMobile", "bank_code": "307"},
  {"bank_name": "EDFIN MICROFINANCE BANK", "bank_code": "090310"},
  {"bank_name": "EK-RELIABLE MICROFINANCE BANK", "bank_code": "090389"},
  {"bank_name": "EKONDO MICROFINANCE BANK", "bank_code": "090097"},
  {"bank_name": "EMERALD MICROFINANCE BANK", "bank_code": "090273"},
  {"bank_name": "EMPIRE TRUST MICROFINANCE BANK", "bank_code": "090114"},
  {"bank_name": "Enterprise Bank", "bank_code": "084"},
  {"bank_name": "ESAN MICROFINANCE BANK", "bank_code": "090189"},
  {"bank_name": "ESO-E MICROFINANCE BANK", "bank_code": "090166"},
  {"bank_name": "eTranzact", "bank_code": "306"},
  {"bank_name": "EVANGEL MICROFINANCE BANK", "bank_code": "090304"},
  {"bank_name": "EVERGREEN MICROFINANCE BANK", "bank_code": "090332"},
  {"bank_name": "EYOWO", "bank_code": "090328"},
  {"bank_name": "FAST MICROFINANCE BANK", "bank_code": "090179"},
  {"bank_name": "FBNMobile", "bank_code": "309"},
  {"bank_name": "FBNQUEST MERCHANT BANK", "bank_code": "060002"},
  {"bank_name": "FCMB MOBILE", "bank_code": "100031"},
  {"bank_name": "FCT MICROFINANCE BANK", "bank_code": "090290"},
  {
    "bank_name": "FEDERAL POLYTECHNIC NEKEDE MICROFINANCE BANK",
    "bank_code": "090398"
  },
  {
    "bank_name": "FEDERAL UNIVERSITY DUTSE MICROFINANCE BANK",
    "bank_code": "090318"
  },
  {"bank_name": "FEDPOLY NASARAWA MICROFINANCE BANK", "bank_code": "090298"},
  {"bank_name": "FET", "bank_code": "314"},
  {"bank_name": "FFS MICROFINANCE BANK", "bank_code": "090153"},
  {"bank_name": "Fidelity Bank", "bank_code": "070"},
  {"bank_name": "Fidelity Mobile", "bank_code": "318"},
  {"bank_name": "FIDFUND MICROFINANCE Bank", "bank_code": "090126"},
  {"bank_name": "FINATRUST MICROFINANCE BANK", "bank_code": "090111"},
  {"bank_name": "FINCA MICROFINANCE BANK", "bank_code": "090400"},
  {"bank_name": "FIRMUS MICROFINANCE BANK", "bank_code": "090366"},
  {"bank_name": "FIRST APPLE LIMITED", "bank_code": "110004"},
  {"bank_name": "First Bank of Nigeria", "bank_code": "011"},
  {"bank_name": "First City Monument Bank", "bank_code": "214"},
  {"bank_name": "FIRST GENERATION MORTGAGE BANK", "bank_code": "070014"},
  {"bank_name": "FIRST OPTION MICROFINANCE BANK", "bank_code": "090285"},
  {"bank_name": "FIRST ROYAL MICROFINANCE BANK", "bank_code": "090164"},
  {"bank_name": "FIRST TRUST MORTGAGE BANK PLC", "bank_code": "090107"},
  {"bank_name": "FIRSTMONIE WALLET", "bank_code": "100014"},
  {
    "bank_name": "FLUTTERWAVE TECHNOLOGY SOLUTIONS LIMITED",
    "bank_code": "110002"
  },
  {"bank_name": "Fortis Microfinance Bank", "bank_code": "501"},
  {"bank_name": "FortisMobile", "bank_code": "308"},
  {"bank_name": "FSDH", "bank_code": "601"},
  {"bank_name": "FULLRANGE MICROFINANCE BANK", "bank_code": "090145"},
  {"bank_name": "FUTO MICROFINANCE BANK", "bank_code": "090158"},
  {"bank_name": "GASHUA MICROFINANCE BANK", "bank_code": "090168"},
  {"bank_name": "GATEWAY MORTGAGE BANK", "bank_code": "070009"},
  {"bank_name": "GIREI MICROFINANACE BANK", "bank_code": "090186"},
  {"bank_name": "GLOBUS BANK", "bank_code": "000027"},
  {"bank_name": "GLORY MICROFINANCE BANK", "bank_code": "090278"},
  {"bank_name": "GMB MICROFINANCE BANK", "bank_code": "090408"},
  {"bank_name": "GOWANS MICROFINANCE BANK", "bank_code": "090122"},
  {"bank_name": "GREENBANK MICROFINANCE BANK", "bank_code": "090178"},
  {"bank_name": "GREENVILLE MICROFINANCE BANK", "bank_code": "090269"},
  {"bank_name": "GROOMING MICROFINANCE BANK", "bank_code": "090195"},
  {"bank_name": "GT MOBILE", "bank_code": "100009"},
  {"bank_name": "GTBank Plc", "bank_code": "058"},
  {"bank_name": "GTI MICROFINANCE BANK", "bank_code": "090385"},
  {"bank_name": "GTMobile", "bank_code": "315"},
  {"bank_name": "HACKMAN MICROFINANCE BANK", "bank_code": "090147"},
  {"bank_name": "HAGGAI MORTGAGE BANK LIMITED", "bank_code": "070017"},
  {"bank_name": "HASAL MICROFINANCE BANK", "bank_code": "090121"},
  {"bank_name": "HEADWAY MICROFINANCE BANK", "bank_code": "090363"},
  {"bank_name": "Hedonmark", "bank_code": "324"},
  {"bank_name": "Heritage", "bank_code": "030"},
  {"bank_name": "HOPEPSB", "bank_code": "120002"},
  {"bank_name": "IBILE MICROFINANCE BANK", "bank_code": "090118"},
  {"bank_name": "IKENNE MICROFINANCE BANK", "bank_code": "090324"},
  {"bank_name": "IKIRE MICROFINANCE BANK", "bank_code": "090275"},
  {"bank_name": "IKIRE MICROFINANCE BANK", "bank_code": "090279"},
  {"bank_name": "ILISAN MICROFINANCE BANK", "bank_code": "090370"},
  {"bank_name": "IMO STATE MICROFINANCE BANK", "bank_code": "090258"},
  {"bank_name": "Imperial Homes Mortgage Bank", "bank_code": "415"},
  {"bank_name": "INFINITY MICROFINANCE BANK", "bank_code": "090157"},
  {"bank_name": "INFINITY TRUST MORTGAGE BANK", "bank_code": "070016"},
  {"bank_name": "INNOVECTIVES KESH", "bank_code": "100029"},
  {"bank_name": "INTELLIFIN", "bank_code": "100027"},
  {"bank_name": "INTERLAND MICROFINANCE BANK", "bank_code": "090386"},
  {"bank_name": "INTERSWITCH LIMITED", "bank_code": "110003"},
  {"bank_name": "IRL MICROFINANCE BANK", "bank_code": "090149"},
  {"bank_name": "ISALEOYO MICROFINANCE BANK", "bank_code": "090377"},
  {"bank_name": "JAIZ Bank", "bank_code": "301"},
  {"bank_name": "Jubilee Life Mortgage Bank", "bank_code": "402"},
  {"bank_name": "KADPOLY MICROFINANCE BANK", "bank_code": "090320"},
  {"bank_name": "KCMB MICROFINANCE BANK", "bank_code": "090191"},
  {"bank_name": "Keystone Bank", "bank_code": "082"},
  {"bank_name": "KONTAGORA MICROFINANCE BANK", "bank_code": "090299"},
  {"bank_name": "KREDI MONEY MICROFINANCE BANK", "bank_code": "090380"},
  {"bank_name": "KUDA MICROFINANCE BANK", "bank_code": "090267"},
  {"bank_name": "LAGOS BUILDING AND INVESTMENT COMPANY", "bank_code": "070012"},
  {"bank_name": "LAPO MICROFINANCE BANK", "bank_code": "090177"},
  {"bank_name": "LAVENDER MICROFINANCE BANK", "bank_code": "090271"},
  {"bank_name": "LEGEND MICROFINANCE BANK", "bank_code": "090372"},
  {"bank_name": "LIVINGTRUST MORTGAGE BANK PLC", "bank_code": "070007"},
  {"bank_name": "LOVONUS MICROFINANCE BANK", "bank_code": "090265"},
  {"bank_name": "M36", "bank_code": "100035"},
  {"bank_name": "MAINLAND MICROFINANCE BANK", "bank_code": "090323"},
  {"bank_name": "MAINSTREET MICROFINANCE BANK", "bank_code": "090171"},
  {"bank_name": "MALACHY MICROFINANCE BANK", "bank_code": "090174"},
  {"bank_name": "MANNY MICROFINANCE BANK", "bank_code": "090383"},
  {"bank_name": "MARITIME MICROFINANCE BANK", "bank_code": "090410"},
  {"bank_name": "MAYFAIR MICROFINANCE BANK", "bank_code": "090321"},
  {"bank_name": "MAYFRESH MORTGAGE BANK", "bank_code": "070019"},
  {"bank_name": "MEGAPRAISE MICROFINANCE BANK", "bank_code": "090280"},
  {"bank_name": "MICROCRED MICROFINANCE BANK", "bank_code": "090136"},
  {"bank_name": "MICROVIS MICROFINANCE BANK", "bank_code": "090113"},
  {"bank_name": "MIDLAND MICROFINANCE BANK", "bank_code": "090192"},
  {"bank_name": "MINT-FINEX MFB", "bank_code": "090281"},
  {"bank_name": "Mkudi", "bank_code": "313"},
  {"bank_name": "MOLUSI MICROFINANCE BANK", "bank_code": "090362"},
  {"bank_name": "MONEY BOX", "bank_code": "100020"},
  {"bank_name": "MONEY TRUST MICROFINANCE BANK", "bank_code": "090129"},
  {"bank_name": "MoneyBox", "bank_code": "325"},
  {"bank_name": "MOZFIN MICROFINANCE BANK", "bank_code": "090392"},
  {"bank_name": "MUTUAL BENEFITS MICROFINANCE BANK", "bank_code": "090190"},
  {"bank_name": "MUTUAL TRUST MICROFINANCE BANK", "bank_code": "090151"},
  {"bank_name": "NAGARTA MICROFINANCE BANK", "bank_code": "090152"},
  {"bank_name": "NDIORAH MICROFINANCE BANK", "bank_code": "090128"},
  {"bank_name": "NEPTUNE MICROFINANCE BANK", "bank_code": "090329"},
  {"bank_name": "NEW DAWN MICROFINANCE BANK", "bank_code": "090205"},
  {"bank_name": "NEW GOLDEN PASTURES MICROFINANCE BANK", "bank_code": "090378"},
  {"bank_name": "NEW PRUDENTIAL BANK", "bank_code": "090108"},
  {"bank_name": "NIGERIAN NAVY MICROFINANCE BANK", "bank_code": "090263"},
  {"bank_name": "NIP Virtual Bank", "bank_code": "999"},
  {"bank_name": "NIRSAL NATIONAL MICROFINANCE BANK", "bank_code": "090194"},
  {"bank_name": "NNEW WOMEN MICROFINANCE BANK", "bank_code": "090283"},
  {"bank_name": "NOVA MERCHANT BANK", "bank_code": "060003"},
  {"bank_name": "NOWNOW DIGITAL SYSTEMS LIMITED", "bank_code": "100032"},
  {"bank_name": "NPF MicroFinance Bank", "bank_code": "552"},
  {"bank_name": "NUTURE MICROFINANCE BANK", "bank_code": "090364"},
  {"bank_name": "NWANNEGADI MICROFINANCE BANK", "bank_code": "090399"},
  {"bank_name": "OCHE MICROFINANCE BANK", "bank_code": "090333"},
  {"bank_name": "OHAFIA MICROFINANCE BANK", "bank_code": "090119"},
  {"bank_name": "OKPOGA MICROFINANCE BANK", "bank_code": "090161"},
  {
    "bank_name": "OLABISI ONABANJO UNIVERSITY MICROFINANCE",
    "bank_code": "090272"
  },
  {"bank_name": "OLOWOLAGBA MICROFINANCE BANK", "bank_code": "090404"},
  {"bank_name": "OMIYE MICROFINANCE BANK", "bank_code": "090295"},
  {"bank_name": "Omoluabi Mortgage Bank", "bank_code": "990"},
  {"bank_name": "OPAY", "bank_code": "100004"},
  {"bank_name": "OSCOTECH MICROFINANCE BANK", "bank_code": "090396"},
  {"bank_name": "Pagatech", "bank_code": "327"},
  {"bank_name": "Page MFBank", "bank_code": "560"},
  {"bank_name": "PALMPAY", "bank_code": "100033"},
  {"bank_name": "PARALLEX", "bank_code": "090004"},
  {"bank_name": "Parralex", "bank_code": "526"},
  {"bank_name": "PATRICKGOLD MICROFINANCE BANK", "bank_code": "090317"},
  {"bank_name": "PayAttitude Online", "bank_code": "329"},
  {"bank_name": "Paycom", "bank_code": "305"},
  {"bank_name": "PAYSTACK PAYMENT LIMITED", "bank_code": "110006"},
  {"bank_name": "PECANTRUST MICROFINANCE BANK", "bank_code": "090137"},
  {"bank_name": "PENNYWISE MICROFINANCE BANK", "bank_code": "090196"},
  {"bank_name": "PERSONAL TRUST MICROFINANCE BANK", "bank_code": "090135"},
  {"bank_name": "PETRA MICROFINANCE BANK", "bank_code": "90165"},
  {"bank_name": "PETRA MICROFINANCE BANK", "bank_code": "090165"},
  {"bank_name": "PILLAR MICROFINANCE BANK", "bank_code": "090289"},
  {"bank_name": "PLATINUM MORTGAGE BANK", "bank_code": "070013"},
  {"bank_name": "POLARIS BANK", "bank_code": "000008"},
  {"bank_name": "POLYUNWANA MICROFINANCE BANK", "bank_code": "090296"},
  {"bank_name": "PRESTIGE MICROFINANCE BANK", "bank_code": "090274"},
  {"bank_name": "PROVIDUS BANK", "bank_code": "101"},
  {"bank_name": "PURPLEMONEY MICROFINANCE BANK", "bank_code": "090303"},
  {"bank_name": "QUICKFUND MICROFINANCE BANK", "bank_code": "090261"},
  {"bank_name": "RAND MERCHANT BANK", "bank_code": "000024"},
  {"bank_name": "ReadyCash (Parkway)", "bank_code": "311"},
  {"bank_name": "REFUGE MORTGAGE BANK", "bank_code": "070011"},
  {"bank_name": "REGENT MICROFINANCE BANK", "bank_code": "090125"},
  {"bank_name": "RELIANCE MICROFINANCE BANK", "bank_code": "090173"},
  {"bank_name": "RENMONEY MICROFINANCE BANK", "bank_code": "090198"},
  {"bank_name": "REPHIDIM MICROFINANCE BANK", "bank_code": "090322"},
  {"bank_name": "RICHWAY MICROFINANCE BANK", "bank_code": "090132"},
  {"bank_name": "ROLEZ MICROFINANCE BANK", "bank_code": "090405"},
  {"bank_name": "ROYAL EXCHANGE MICROFINANCE BANK", "bank_code": "090138"},
  {"bank_name": "RUBIES MICROFINANCE BANK", "bank_code": "090175"},
  {"bank_name": "SAFE HAVEN MICROFINANCE BANK", "bank_code": "090286"},
  {"bank_name": "SafeTrust Mortgage Bank", "bank_code": "403"},
  {"bank_name": "SAGAMU MICROFINANCE BANK", "bank_code": "090140"},
  {"bank_name": "SEED CAPITAL MICROFINANCE BANK", "bank_code": "090112"},
  {"bank_name": "SEEDVEST MICROFINANCE BANK", "bank_code": "090369"},
  {"bank_name": "SHERPERD TRUST MICROFINANCE BANK", "bank_code": "090401"},
  {"bank_name": "Skye Bank", "bank_code": "076"},
  {"bank_name": "SPARKLE", "bank_code": "090325"},
  {"bank_name": "STANBIC IBTC @Ease WALLET", "bank_code": "100007"},
  {"bank_name": "Stanbic IBTC Bank", "bank_code": "221"},
  {"bank_name": "Stanbic Mobile Money", "bank_code": "304"},
  {"bank_name": "Standard Chartered Bank", "bank_code": "068"},
  {"bank_name": "STANFORD MICROFINANCE BANK", "bank_code": "090162"},
  {"bank_name": "STELLAS MICROFINANCE BANK", "bank_code": "090262"},
  {"bank_name": "Sterling Bank", "bank_code": "232"},
  {"bank_name": "Sterling Mobile", "bank_code": "326"},
  {"bank_name": "SULSPAP MICROFINANCE BANK", "bank_code": "090305"},
  {"bank_name": "SunTrust Bank", "bank_code": "100"},
  {"bank_name": "TagPay", "bank_code": "328"},
  {"bank_name": "TAJ BANK", "bank_code": "000026"},
  {"bank_name": "TCF MFB", "bank_code": "90115"},
  {"bank_name": "TEAMAPT LIMITED", "bank_code": "110007"},
  {"bank_name": "TEASY MOBILE", "bank_code": "100010"},
  {"bank_name": "TeasyMobile", "bank_code": "319"},
  {"bank_name": "THINK FINANCE MICROFINANCE BANK", "bank_code": "090373"},
  {"bank_name": "TITAN TRUST BANK", "bank_code": "000025"},
  {"bank_name": "TRIDENT MICROFINANCE BANK", "bank_code": "090146"},
  {"bank_name": "TRUST MICROFINANCE BANK", "bank_code": "090327"},
  {
    "bank_name": "TRUSTBANC J6 MICROFINANCE BANK LIMITED",
    "bank_code": "090123"
  },
  {"bank_name": "Trustbond", "bank_code": "523"},
  {"bank_name": "TRUSTFUND MICROFINANCE BANK", "bank_code": "090276"},
  {"bank_name": "U & C MICROFINANCE BANK", "bank_code": "090315"},
  {"bank_name": "UNAAB MICROFINANCE BANK", "bank_code": "090331"},
  {"bank_name": "UNIBEN MICROFINANCE BANK", "bank_code": "090266"},
  {"bank_name": "UNICAL MICROFINANCE BANK", "bank_code": "090193"},
  {"bank_name": "UNICAL MICROFINANCE BANK", "bank_code": "90193"},
  {"bank_name": "Union Bank", "bank_code": "032"},
  {"bank_name": "United Bank for Africa", "bank_code": "033"},
  {"bank_name": "Unity Bank", "bank_code": "215"},
  {
    "bank_name": "UNIVERSITY OF NIGERIA, NSUKKA MICROFINANCE BANK",
    "bank_code": "090251"
  },
  {"bank_name": "VENTURE GARDEN NIGERIA LIMITED", "bank_code": "110009"},
  {"bank_name": "VFD MFB", "bank_code": "090110"},
  {"bank_name": "VIRTUE MICROFINANCE BANK", "bank_code": "090150"},
  {"bank_name": "VISA MICROFINANCE BANK", "bank_code": "090139"},
  {"bank_name": "VT NETWORKS", "bank_code": "100012"},
  {"bank_name": "VTNetworks", "bank_code": "320"},
  {"bank_name": "Wema Bank", "bank_code": "035"},
  {"bank_name": "WETLAND  MICROFINANCE BANK", "bank_code": "090120"},
  {"bank_name": "XSLNCE MICROFINANCE BANK", "bank_code": "090124"},
  {"bank_name": "YES MICROFINANCE BANK", "bank_code": "090142"},
  {"bank_name": "YOBE MICROFINANCE  BANK", "bank_code": "090252"},
  {"bank_name": "Zenith Bank", "bank_code": "057"},
  {"bank_name": "ZENITH EASY WALLET", "bank_code": "100034"},
  {"bank_name": "ZenithMobile", "bank_code": "322"},
  {"bank_name": "ZINTERNET - KONGAPAY", "bank_code": "100025"}
];
