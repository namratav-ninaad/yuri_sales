import 'package:intl/intl.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';

class DateHelper {
  /// Main format function
  static String format(
    String dateStr, {
    String pattern = AppStringsConstants.ddMMMyyyy,
  }) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat(pattern).format(date);
    } catch (_) {
      return dateStr;
    }
  }

  // ── Shortcut methods ──
  static String dMy(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.ddMMMyyyy);

  // → 28 Jul 2026

  static String dMySlash(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.ddMMyyyySlash);

  // → 28/07/2026

  static String dMyDash(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.ddMMyyyyDash);

  // → 28-07-2026

  static String mDy(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.MMMddyyyy);

  // → Jul 28, 2026

  static String yMd(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.yyyyMMdd);

  // → 2026-07-28

  static String dMyTime(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.ddMMMyyyyTime);

  // → 28 Jul 2026, 05:28 AM

  static String dMyHHmm(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.ddMMMyyyyHHmm);

  // → 28 Jul 2026 05:28

  static String full(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.fullDate);

  // → Tuesday, 28 Jul 2026

  static String monthYear(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.MMMyyyy);

  // → Jul 2026

  static String monthDay(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.MMMd);

  // → Jul 6

  static String time(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.time12);

  // → 05:28 AM

  /// Mon, Tue, Wed...
  static String weekdayShort(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.day);

  /// 1 Jul
  static String dayMonth(String dateStr) =>
      format(dateStr, pattern: AppStringsConstants.dMMM);
}
