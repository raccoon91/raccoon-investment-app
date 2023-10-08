import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/model/trade_model.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final Map<String, List<Trade>> tradeMap;
  final String? selected;
  final Function(DateTime, DateTime) onDaySelected;

  const Calendar({
    super.key,
    required this.tradeMap,
    required this.selected,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay:
          selected != null ? DateTime.parse(selected ?? '') : DateTime.now(),
      currentDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return DateFormat('yyyy-MM-dd').format(day) == selected;
      },
      onDaySelected: onDaySelected,
      eventLoader: (day) {
        var datetime = DateFormat('yyyy-MM-dd').format(day);
        if (tradeMap[datetime] != null) {
          return tradeMap[datetime] ?? [];
        }

        return [];
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextFormatter: (date, locale) {
          return DateFormat('yyyy MM').format(date);
        },
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          Icons.arrow_left,
          size: 30,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_right,
          size: 30,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        weekendStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        selectedTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '${events.length}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }

          return null;
        },
      ),
    );
  }
}
