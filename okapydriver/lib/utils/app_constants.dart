import 'package:okapydriver/utils/constants.dart';

class ImageConstant {
  static const String pickupImageIcon = 'assets/From.png';
  static const String destinationImageIcon = 'assets/location-icon.png';
  static const String personAvatarImage =
      'https://$baseUrl/media/users.png';
}

class JobState {
  static const int none = 0;
  static const int created = 1;
  static const int confirmed = 2;
  static const int picked = 3;
  static const int transit = 4;
  static const int arrived = 5;
}

class SharedPreferenceConstants {
  static const String availability = 'availability';
  static const String activeJob = 'activeJob';
  static const String activeJobState = 'activeJobState';
  static const String activeJobDetails = 'activeJobDetails';
}
