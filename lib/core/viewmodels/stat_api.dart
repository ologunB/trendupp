import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/api/auth_api.dart';
import 'package:mms_app/core/api/stat_api.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/models/payout.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import '../../locator.dart';
import 'base_vm.dart';

class StatViewModel extends BaseModel {
  final StatApi _statApi = locator<StatApi>();
  final AuthApi _authApi = locator<AuthApi>();
  String? error;

  CreatorStat? creatorStat;
  double tempAmount = 0;

  Future<void> getCreatorStat() async {
    setBusy(true);
    try {
      creatorStat = await _statApi.getCreatorStat();
      tempAmount = creatorStat!.amount!.toDouble();
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<Supporters>? allSupporters;

  Future<void> getSupporters() async {
    setBusy(true);
    try {
      allSupporters = await _statApi.getSupporters();
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<int>? allPaymentHistory;

  Future<void> paymentHistory(String e) async {
    setBusy(true);
    try {
      allPaymentHistory = await _statApi.paymentHistory(e);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<bool> initPayout(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _statApi.initPayout(a);
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  List<PayoutModel>? allPayoutHistory;

  double totalEarning = 0;

  Future<void> payoutHistory() async {
    setBusy(true);
    try {
      allPayoutHistory = await _statApi.payoutHistory();
      allPayoutHistory!.forEach((element) {
        totalEarning = totalEarning + double.parse(element.amount!);
      });
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<int>? fanSupportHistory;

  Future<void> creatorGetFanSupportHistory(String email) async {
    setBusy(true);
    try {
      fanSupportHistory = await _statApi.creatorGetFanSupportHistory(email);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<String?> initPayment(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      String ref = await _statApi.initPayment(a);
      setBusy(false);
      return ref;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return null;
    }
  }

  Future<bool> confirmPayment(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _statApi.confirmPayment(a);
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  Future<bool> socialCheck(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      String? checkRes = await _authApi.socialCheck(a);
      setBusy(false);
      if (checkRes == 'This user does not exists') {
        return false;
      } else if (checkRes == 'This user already exists') {
        return true;
      }
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  List<int>? allSupportedCreators;

  Future<void> getSupportedCreators(String email) async {
    setBusy(true);
    try {
      allSupportedCreators = await _statApi.getSupportedCreators(email);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<int>? allExploredCreators;

  Future<void> getExploreCreators(String email) async {
    setBusy(true);
    try {
      fanSupportHistory = await _statApi.getExploredCreators(email);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<int>? allUsersPosts;

  Future<void> getUsersPosts(String email) async {
    setBusy(true);
    try {
      fanSupportHistory = await _statApi.getUsersPosts(email);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }

  BuildContext c() => navigate.navigationKey.currentContext!;

  void showDialog(CustomException e) {
    showSnackBar(
      navigate.navigationKey.currentContext!,
      'Error',
      e.message,
      color: AppColors.red,
    );
  }
}
