import 'dart:convert';

import 'package:okapydriver/models/Jobtaken.dart';
import 'package:okapydriver/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelpers {

    static setIsDriverAvailable(bool isAvailable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(SharedPreferenceConstants.availability, isAvailable);
  }

  static getIsDriverAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getBool(SharedPreferenceConstants.availability);
  }

  static getActiveJobStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(SharedPreferenceConstants.activeJob);
  }

  static setIsDriverActive(bool isActive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(SharedPreferenceConstants.activeJob, isActive);
  }

  static getIsDriverActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getBool(SharedPreferenceConstants.activeJob);
  }

  static setActiveJobState(int jobState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(SharedPreferenceConstants.activeJobState, jobState);
  }

  static getActiveJobState(int jobState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getInt(SharedPreferenceConstants.activeJobState);
  }

  static setactiveJobDetails(JobTaken job) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(
        SharedPreferenceConstants.activeJobDetails, jsonEncode(job.toJson()));
  }
}
