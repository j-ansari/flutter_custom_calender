import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarType calendarType = CalendarType.gregorian;
  CalendarMode calendarMode = CalendarMode.monthlyTable;
  bool showOverflowDays = false;
  bool disablePastDays = false;
  CalendarDateTime selectedDate =
      CalendarDateTime.fromDateTime(DateTime.now().add(Duration(days: 1)));
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCalendarRangePicker(
                calendarType: calendarType,
                showOverFlowDays: showOverflowDays,
                headerModel: const HeaderModel(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10)),
                calendarRangeDayModel: CalendarRangeDayModel(
                  disablePastDays: disablePastDays,
                  width: 64,
                  height: 64,
                  rangeDecoration:
                      BoxDecoration(color: Colors.blue.withOpacity(0.2)),
                  disableStyle: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.4)),
                ),
                selectedRange: PickedRange(
                  startDate: CalendarDateTime.fromDateTime(
                      DateTime.now().add(Duration(days: 1))),
                  endDate: CalendarDateTime.fromDateTime(
                      DateTime.now().add(Duration(days: 3))),
                ),
              ),
              const SizedBox(height: 64),
              CustomCalendar(
                calendarType: calendarType,
                selectedDate: selectedDate,
                showOverFlowDays: showOverflowDays,
                calendarMode: calendarMode,
                onSelectDate: (selectedDate) {
                  this.selectedDate = selectedDate;
                  if (color == Colors.green) {
                    color = Colors.red;
                  } else {
                    color = Colors.green;
                  }
                  setState(() {});
                },
                headerModel: const HeaderModel(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                ),
                calendarDayModel: CalendarDayModel(
                  disablePastDays: disablePastDays,
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.only(bottom: 10),
                  tagBuilder: (p0) => Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      p0.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  selectedDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  disableStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                "Calendar type:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<CalendarType>(
                  value: calendarType,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: CalendarType.jalali,
                      child: Text("jalali"),
                    ),
                    DropdownMenuItem(
                      value: CalendarType.gregorian,
                      child: Text("gregorian"),
                    )
                  ],
                  onChanged: (calendarType) {
                    if (calendarType != null) {
                      this.calendarType = calendarType;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Calendar mode:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<CalendarMode>(
                  value: calendarMode,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: CalendarMode.monthlyTable,
                      child: Text("Table calendar"),
                    ),
                    DropdownMenuItem(
                      value: CalendarMode.weekly,
                      child: Text("weekly calendar"),
                    ),
                    DropdownMenuItem(
                      value: CalendarMode.monthlyLinear,
                      child: Text("monthly calendar"),
                    )
                  ],
                  onChanged: (calendarMode) {
                    if (calendarMode != null) {
                      this.calendarMode = calendarMode;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Show overflow days:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      value: true,
                      groupValue: showOverflowDays,
                      title: const Text("true"),
                      onChanged: (value) {
                        if (value != null) {
                          showOverflowDays = value;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      groupValue: showOverflowDays,
                      title: const Text("false"),
                      onChanged: (value) {
                        if (value != null) {
                          showOverflowDays = value;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Disable past days:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      value: true,
                      groupValue: disablePastDays,
                      title: const Text("true"),
                      onChanged: (value) {
                        if (value != null) {
                          disablePastDays = value;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      groupValue: disablePastDays,
                      title: const Text("false"),
                      onChanged: (value) {
                        if (value != null) {
                          disablePastDays = value;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
              /*
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CustomCalendar(
                        showOverFlowDays: false,
                        calendarMode: CalendarMode.monthlyTable,
                        calendarType: CalendarType.jalali,
                        disableCalendarModeChange: true,
                        selectedDate:
                            CalendarDateTime.fromDateTime(DateTime.now()),
                        headerModel: HeaderModel(
                          titleBuilder: (dateTime, year, mont) => Row(
                            children: [
                              const Text(
                                "ماه قبلی",
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: mont,
                                        child: const Text(
                                          'اردیبهشت',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: year,
                                        child: const Text(
                                          '1404',
                                          style: TextStyle(
                                            color: Colors.brown,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "ماه بعدی ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          iconsSize: 14,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          // menuItemDecoration: _defaultDecoration(context),
                          // selectedMenuItemDecoration:
                          //     _selectedDecoration(context),
                          //  selectedMenuItemStyle: _selectedTextStyle(context),
                          hasTodayIcon: false,
                          //iconsColor: Colors.green,
                          iconAlignment: HeaderIconAlignment.center,
                          // menuItemStyle: _defaultTextStyle(context),
                          headerDecoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // onSelectDate: (calendarDateTime) =>
                        //     onSelectData.call(calendarDateTime.toDateTime),
                        // monthTitles: [],
                        weekDaysTitles: const [
                          "ش",
                          "ی",
                          "د",
                          "س",
                          "چ",
                          "پ",
                          "ج"
                        ],
                        calendarDayModel: CalendarDayModel(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          // decoration: _defaultDecoration(context),
                          // selectedDecoration: _selectedDecoration(context),
                          disablePastDays: false,
                          // style: Styles.bodyText1(context),
                          //weekDayStyle: _defaultTextStyle(context),
                          //todayStyle: Styles.bodyText1(context),
                          height: 48,
                          width: 48,
                          todayDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: context.colorScheme.outline,
                            border: Border.all(color: Colors.pink),
                            boxShadow: const [
                              // CommonConstants.cardShadow(context),
                            ],
                          ),
                          //   selectedStyle: _selectedTextStyle(context),
                        ),
                      );
                    },
                  );
                },
                child: Text('test'),
              ),
               */
            ],
          ),
        ),
      ),
    );
  }
}
