import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static final now = DateTime.now();

  static final today = DateTime(now.year, now.month, now.day);

  static final dayOfWeekFormat =
      DateFormat('EEEE, dd/MM/yyyy', Get.locale?.languageCode);
  static final dateFormat = DateFormat('dd/MM/yyyy');
  static final timeFormat = DateFormat('HH:mm');
  static final dateTimeFormat = DateFormat('HH:mm, dd/MM/yyyy');
  static final dowDateTimeFormat = DateFormat(
    'EEEE, HH:mm, dd/MM/yyyy',
    Get.locale?.languageCode,
  );
  static DateTime adult() {
    return DateTime(now.year - 18, now.month, now.day);
  }

  static String reCalTimeCheckinBefore(int value) {
    if (value % 60 == 0) return '$value ${'minute'.tr}';
    return '${value % 60} ${'hour'.tr} $value ${'minute'.tr}';
  }

  static String getGreeting() {
    final hour = now.hour;
    if (hour >= 5 && hour < 12) {
      return 'good_morning'.tr;
    } else {
      if (hour < 18) {
        return 'good_afternoon'.tr;
      }
    }

    return 'good_evening'.tr;
  }

  static String getTimeDifferenceFromNow(DateTime date) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    if (difference.inSeconds < 5) {
      return 'now'.tr;
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${'seconds'.tr} ${'ago'.tr}';
    } else if (difference.inMinutes <= 1) {
      return '1 ${'minute'.tr} ${'ago'.tr}';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${'minutes'.tr} ${'ago'.tr}';
    } else if (difference.inHours <= 1) {
      return '1 ${'hour'.tr} ${'ago'.tr}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${'hours'.tr} ${'ago'.tr}';
    } else if (difference.inDays <= 1) {
      return '1 ${'day'.tr} ${'ago'.tr}';
    } else if (difference.inDays < 6) {
      return '${difference.inDays} ${'days'.tr} ${'ago'.tr}';
    } else if ((difference.inDays / 7).ceil() <= 1) {
      return '1 ${'week'.tr} ${'ago'.tr}';
    } else if ((difference.inDays / 7).ceil() < 4) {
      return '${(difference.inDays / 7).ceil()} ${'weeks'.tr} ${'ago'.tr}';
    } else if ((difference.inDays / 30).ceil() <= 1) {
      return '1 ${'month'.tr} ${'ago'.tr}';
    } else if ((difference.inDays / 30).ceil() < 30) {
      return '${(difference.inDays / 30).ceil()} ${'months'.tr} ${'ago'.tr}';
    } else if ((difference.inDays / 365).ceil() <= 1) {
      return '1 ${'year'.tr} ${'ago'.tr}';
    }
    return '${(difference.inDays / 365).floor()} ${'years'.tr} ${'ago'.tr}';
  }

  static String getShortTimeDifferenceFromNow(DateTime date) {
    final now = DateTime.now();
    final timeCompare = DateTime(now.year, now.month, now.day);
    final difference = timeCompare.difference(date);
    if (difference.inHours < 24) {
      return 'today'.tr;
    }
    return dateFormat.format(date);
  }

  static String tryFormat(DateTime? value, DateFormat format,
      [String? fallback]) {
    if (value == null) return fallback ?? '';
    return format.format(value);
  }

  static DateTime? tryFromSecondsSinceEpoch(int? secondsSinceEpoch) {
    if (secondsSinceEpoch == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  }
}

extension DateTimeExt on DateTime {
  bool isSameDateTo(DateTime date) =>
      day == date.day && year == date.year && month == date.month;
}
