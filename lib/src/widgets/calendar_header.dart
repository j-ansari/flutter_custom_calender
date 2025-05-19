import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';
import 'package:flutter_custom_calendar/src/utils/calendar_utils.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarDateTime calendarDateTime;
  final VoidCallback onPressNext;
  final VoidCallback onPressPrevious;
  final VoidCallback? onPressCurrentDate;
  final VoidCallback? onPressMonth;
  final VoidCallback? onPressYear;
  final HeaderModel? headerModel;
  final bool isSelectionMenu;
  final VoidCallback onPressBackOnMenu;

  const CalendarHeader({
    Key? key,
    required this.calendarDateTime,
    required this.onPressNext,
    required this.onPressPrevious,
    required this.onPressBackOnMenu,
    this.headerModel = const HeaderModel(),
    this.onPressCurrentDate,
    this.isSelectionMenu = false,
    this.onPressMonth,
    this.onPressYear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: headerModel?.padding,
      margin: headerModel?.margin,
      decoration: headerModel?.headerDecoration,
      child: Visibility(
        visible: isSelectionMenu == false,
        replacement: Row(
          children: [
            GestureDetector(
              onTap: onPressBackOnMenu,
              child: Icon(
                Icons.arrow_back_ios,
                size: headerModel?.iconsSize,
                color: headerModel?.iconsColor ?? Colors.black,
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            if (headerModel?.iconAlignment == HeaderIconAlignment.right)
              titleWidget(context),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12, end: 4),
              child: GestureDetector(
                onTap: onPressPrevious,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: headerModel?.iconsSize,
                  color: headerModel?.iconsColor ?? Colors.red,
                ),
              ),
            ),
            if (headerModel?.iconAlignment == HeaderIconAlignment.center)
              titleWidget(context),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 4, end: 12),
              child: GestureDetector(
                onTap: onPressNext,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: headerModel?.iconsSize,
                  color: headerModel?.iconsColor ?? Colors.black,
                ),
              ),
            ),
            if (headerModel?.iconAlignment == HeaderIconAlignment.left)
              titleWidget(context),
          ],
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: headerModel?.titleBuilder != null
                ? headerModel!.titleBuilder!
                    .call(calendarDateTime, onPressYear!, onPressMonth!)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onPressMonth,
                        child: Text(
                          CalendarUtils.getMonthName(calendarDateTime, context),
                          style: headerModel?.titleStyle ??
                              const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: onPressYear,
                        child: Text(
                          "${calendarDateTime.year}",
                          style: headerModel?.titleStyle ??
                              const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
          ),
          Visibility(
            visible: headerModel?.hasTodayIcon ?? false,
            child: IconButton(
              onPressed: onPressCurrentDate,
              icon: Icon(
                Icons.today,
                color: headerModel?.iconsColor,
                size: headerModel?.iconsSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
