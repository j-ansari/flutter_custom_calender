import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/src/model/calendar_date_time.dart';
import 'package:flutter_custom_calendar/src/utils/date_utils.dart';

class RowCalendarWeekDayTitle extends StatelessWidget {
  final CalendarType calendarType;

  const RowCalendarWeekDayTitle({
    Key? key,
    required this.calendarType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: CalendarUtils.weekDaysTitle(calendarType)
          .map((day) => Expanded(child: Center(child: Text(day))))
          .toList(),
    );
  }
}
