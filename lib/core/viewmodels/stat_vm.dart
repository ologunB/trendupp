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
import 'package:provider/provider.dart';

class StatViewModel extends BaseModel {
  final StatApi _statApi = locator<StatApi>();
  final AuthApi _authApi = locator<AuthApi>();
  final PostApi _postApi = locator<PostApi>();
  String? error;

  CreatorStat? creatorStat;
  double tempAmount = 0;

  void setCreatorStat(CreatorStat? data) {
    creatorStat = data;
    tempAmount = creatorStat!.amount!.toDouble();
    notifyListeners();
  }

  Future<void> getCreatorStat(BuildContext context) async {
    setBusy(true);
    try {
      creatorStat = context.read<StatViewModel>().creatorStat;
      tempAmount = context.read<StatViewModel>().tempAmount;
      creatorStat = await _statApi.getCreatorStat();
      creatorStat!.supporters!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      tempAmount = creatorStat!.amount!.toDouble();
      context.read<StatViewModel>().setCreatorStat(creatorStat);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<Supporters>? allSupporters;

  void setSupporters(List<Supporters>? data) {
    allSupporters = data;
    notifyListeners();
  }

  Future<void> getSupporters(BuildContext context) async {
    setBusy(true);
    allSupporters = context.read<StatViewModel>().allSupporters;
    try {
      allSupporters = await _statApi.getSupporters();
      allSupporters!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<StatViewModel>().setSupporters(allSupporters);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  FanPaymentHistoryModel? fanSupportHistory;

  void setFanSupportHistory(FanPaymentHistoryModel? data) {
    fanSupportHistory = data;
    notifyListeners();
  }

  Future<void> creatorGetFanSupportHistory(
      String email, BuildContext context) async {
    setBusy(true);
    if (context.read<StatViewModel>().fanSupportHistory != null) {
      if (context.read<StatViewModel>().fanSupportHistory!.user!.email ==
          email) {
        fanSupportHistory = context.read<StatViewModel>().fanSupportHistory;
      }
    }
    try {
      fanSupportHistory = await _statApi.creatorGetFanSupportHistory(email);
      fanSupportHistory!.history!
          .sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<StatViewModel>().setFanSupportHistory(fanSupportHistory);
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

  void setPayoutHistory(List<PayoutModel>? data) {
    allPayoutHistory = data;
    notifyListeners();
  }

  
  Future<void> getPayoutHistory(BuildContext context) async {
    setBusy(true);
    allPayoutHistory = context.read<StatViewModel>().allPayoutHistory;
    try {
      allPayoutHistory = await _statApi.payoutHistory();
      allPayoutHistory!.forEach((element) {
        totalEarning = totalEarning + double.parse(element.amount!);
      });
      allPayoutHistory!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<StatViewModel>().setPayoutHistory(allPayoutHistory);
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

  void setCreators(List<UserData>? data) {
    allCreators = data;
    filteredCreators = data;
    notifyListeners();
  }

  Future<void> getExploreCreators(BuildContext context) async {
    setBusy(true);
    allCreators = context.read<StatViewModel>().allCreators;
    filteredCreators = allCreators;
    try {
      allCreators = await _statApi.getExploredCreators();
      allCreators!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      filteredCreators = [];
      filteredCreators!.addAll(allCreators!);
      context.read<StatViewModel>().setCreators(allCreators);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<UserData>? allSupportedCreators, filteredSupportedCreators;

  void setSupportedCreators(List<UserData>? data) {
    allSupportedCreators = data;
    filteredSupportedCreators = data;
    notifyListeners();
  }

  Future<void> getSupportedCreators(String email, BuildContext context) async {
    setBusy(true);
    allSupportedCreators = context.read<StatViewModel>().allSupportedCreators;
    filteredSupportedCreators = allSupportedCreators;
    try {
      allSupportedCreators = await _statApi.getSupportedCreators(email);
      allSupportedCreators!
          .sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      filteredSupportedCreators = [];
      filteredSupportedCreators!.addAll(allSupportedCreators!);
      context.read<StatViewModel>().setSupportedCreators(allSupportedCreators);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<PostModel>? allFanPayment;

  void setUserPayment(List<PostModel>? data) {
    allFanPayment = data;
    notifyListeners();
  }

  Future<void> getUserPaymentHistory(String email, BuildContext context) async {
    setBusy(true);
    allFanPayment = context.read<StatViewModel>().allFanPayment;
    try {
      allFanPayment = await _statApi.getUserPaymentHistory(email);
      allFanPayment!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<StatViewModel>().setUserPayment(allFanPayment);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<PostModel>? allPosts;

  void setFanPosts(List<PostModel>? data) {
    allPosts = data;
    notifyListeners();
  }

  Future<void> getFanPosts(String email, BuildContext context) async {
    setBusy(true);
    allPosts = context.read<StatViewModel>().allPosts;
    try {
      allPosts = await _postApi.getFanPosts(email);
      allPosts!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<StatViewModel>().setFanPosts(allPosts);
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
