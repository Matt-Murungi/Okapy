import 'package:fluttertoast/fluttertoast.dart';
import 'package:okapy/core/ui/constants/colors.dart';

buildToast(String message) {
  return Fluttertoast.showToast(
      msg: message, backgroundColor: AppColors.themeColorGrey);
}
