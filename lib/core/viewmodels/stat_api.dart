import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/api/auth_api.dart';
import 'package:mms_app/core/api/stat_api.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import '../../locator.dart';
import 'base_vm.dart';

class StatViewModel extends BaseModel {
  final StatApi _statApi = locator<StatApi>();
  final AuthApi _authApi = locator<AuthApi>();
  String? error;

  CreatorStat? creatorStat;

  Future<void> getCreatorStat() async {
    setBusy(true);
    try {
      creatorStat = await _statApi.getCreatorStat();
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

  Future<void> paymentHistory() async {
    setBusy(true);
    try {
      allPaymentHistory = await _statApi.paymentHistory();
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<int>? fanSupportHistory;

  Future<void> creatorGetFanSupportHistory() async {
    setBusy(true);
    try {
      fanSupportHistory = await _statApi.creatorGetFanSupportHistory();
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
