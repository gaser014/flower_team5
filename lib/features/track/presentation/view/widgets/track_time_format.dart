import 'package:flowers_app/core/values/app_strings.dart';

/// Lightweight date/time formatting for the track screens (no intl dependency).
String formatTrackDateTime(DateTime? dateTime) {
  if (dateTime == null) return AppStrings.calculatingArrival;
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final local = dateTime.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = months[local.month - 1];
  final hour12 = local.hour % 12 == 0 ? 12 : local.hour % 12;
  final minute = local.minute.toString().padLeft(2, '0');
  final period = local.hour < 12 ? 'AM' : 'PM';
  return '$day $month ${local.year}, ${hour12.toString().padLeft(2, '0')}:$minute $period';
}
