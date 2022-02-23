import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/api/auth_api.dart';
import 'package:mms_app/core/api/post_api.dart';
import 'package:mms_app/core/api/stat_api.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/models/fan_payment_history.dart';
import 'package:mms_app/core/models/payout.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import '../../locator.dart';
import 'base_vm.dart';

class StatViewModel extends BaseModel {
  final StatApi _statApi = locator<StatApi>();
  final AuthApi _authApi = locator<AuthApi>();
  final PostApi _postApi = locator<PostApi>();
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

  FanPaymentHistoryModel? fanSupportHistory;

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

  List<UserData>? allCreators, filteredCreators;

  Future<void> getSupportedCreators(String email) async {
    setBusy(true);
    try {
      allCreators = await _statApi.getSupportedCreators(email);
      filteredCreators = [];
      filteredCreators!.addAll(allCreators!);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<PostModel>? allFanPayment;

  Future<void> getUserPaymentHistory(String email) async {
    setBusy(true);
    try {
      allFanPayment = await _statApi.getUserPaymentHistory(email);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<void> getExploreCreators() async {
    setBusy(true);
    try {
      allCreators = await _statApi.getExploredCreators();
      filteredCreators = [];
      filteredCreators!.addAll(allCreators!);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<PostModel>? allPosts;

  Future<void> getFanPosts(String email) async {
    setBusy(true);
    try {
      allPosts = await _postApi.getFanPosts(email);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  filterCreators(String? a) {
    a = a!.trim();
    if (a.length > 0) {
      a = a.toUpperCase();
      filteredCreators!.clear();
      for (UserData item in allCreators!) {
        if ((item.firstName?.toUpperCase().contains(a) ?? true) ||
            (item.lastName?.toUpperCase().contains(a) ?? true) ||
            (item.email?.toUpperCase().contains(a) ?? true) ||
            (item.about?.toUpperCase().contains(a) ?? true) ||
            (item.brandName?.toUpperCase().contains(a) ?? true) ||
            (item.creating?.toUpperCase().contains(a) ?? true)) {
          filteredCreators!.add(item);
        }
      }
    } else {
      filteredCreators!.clear();
      filteredCreators!.addAll(allCreators!);
    }
    setBusy(false);
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
