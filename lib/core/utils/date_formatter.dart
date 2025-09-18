import 'package:intl/intl.dart';

/// Date formatting utilities
class DateFormatter {
  static final DateFormat _defaultFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _fullFormat = DateFormat('EEEE, MMMM d, yyyy');
  static final DateFormat _shortFormat = DateFormat('MMM d, yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateTimeFormat = DateFormat('MMM d, yyyy HH:mm');
  
  /// Format date to default format (yyyy-MM-dd)
  static String formatDefault(DateTime date) {
    return _defaultFormat.format(date);
  }
  
  /// Format date to full format (Monday, January 1, 2024)
  static String formatFull(DateTime date) {
    return _fullFormat.format(date);
  }
  
  /// Format date to short format (Jan 1, 2024)
  static String formatShort(DateTime date) {
    return _shortFormat.format(date);
  }
  
  /// Format time only (HH:mm)
  static String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }
  
  /// Format date and time (Jan 1, 2024 14:30)
  static String formatDateTime(DateTime date) {
    return _dateTimeFormat.format(date);
  }
  
  /// Format with custom pattern
  static String formatCustom(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }
  
  /// Get relative time string (e.g., "2 hours ago", "in 3 days")
  static String formatRelative(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.isNegative) {
      return _formatFuture(difference.abs());
    } else {
      return _formatPast(difference);
    }
  }
  
  static String _formatPast(Duration difference) {
    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
  
  static String _formatFuture(Duration difference) {
    if (difference.inSeconds < 60) {
      return 'in a moment';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return 'in $minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return 'in $hours ${hours == 1 ? 'hour' : 'hours'}';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return 'in $days ${days == 1 ? 'day' : 'days'}';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'in $weeks ${weeks == 1 ? 'week' : 'weeks'}';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return 'in $months ${months == 1 ? 'month' : 'months'}';
    } else {
      final years = (difference.inDays / 365).floor();
      return 'in $years ${years == 1 ? 'year' : 'years'}';
    }
  }
}