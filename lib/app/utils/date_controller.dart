class DateController {
  verificationDateQuarter(
      DateTime startTimeDate, DateTime endTimeDate, DateTime dateComparation) {
    var d = startTimeDate.isBefore(dateComparation) &&
        endTimeDate.isAfter(dateComparation);

    return d;
  }

  List<DateTime> getOneDayMonthDates(DateTime date, int day) {
    final dateNow = date;
    final dayMonth = DateTime(dateNow.year, dateNow.month + 1, -1).day + 1;

    var daysMonth = List.generate(dayMonth, (number) => number + 1);

    var daysSaturday = daysMonth.where((element) =>
        DateTime(dateNow.year, dateNow.month, element).weekday == day);
    var dateSaturday = daysSaturday
        .map((e) => DateTime(dateNow.year, dateNow.month, e))
        .toList();

    return dateSaturday;
  }

  List<DateTime> getDates(DateTime start, DateTime end) {
    List<DateTime> listDateTimes = [];

    bool isok = false;
    int month = start.month;
    int year = start.year;
    while (!isok) {
      var date = DateTime(start.year, month, 1);
      listDateTimes.add(date);
      if (month == 12) {
        month = 1;
        year++;
      }
      if (month == end.month && year == end.year) isok = true;
    }
    return listDateTimes;
  }

  List<DateTime> getSaturdays(DateTime start, DateTime end) {
    var list = getMonthsBetweenTwoDates(start, end); //obtenemos los meses
    List<DateTime> listNew = [];
    for (var element in list) {
      listNew.addAll(getOneDayMonthDates(element, 6)); //obtenemos los sabados
    }

    return listNew
        .where((e) => deepVerificationDatesBetweenDates(start, end, e))
        .toList();
  }

  //Future<List<DateTime>> getAttendanceAll() async {
  /* var listQuarter = await _eessRepositoryImpl.getEESSConfigQuarter();

    var dateTimeNow = DateTime.now();
    Quarter? quater = listQuarter.firstWhereOrNull((element) =>
        deepVerificationDatesBetweenDates(
            element.startTime, element.endTime, dateTimeNow));
    if (quater == null) return [];

    var r = getSaturdays(quater.startTime, quater.endTime);
    return r;*/
  //}

  List<DateTime> getOneDayMonthDatesV2(DateTime date, int day) {
    final dateNow = date;
    final dayMonth = DateTime(dateNow.year, dateNow.month + 1, -1).day + 1; //31
    final daysMin = (dayMonth - dateNow.day) + 1;

    var daysMonth = List.generate(daysMin, (number) => dayMonth - number);

    var daysSaturday = daysMonth.where((element) =>
        DateTime(dateNow.year, dateNow.month, element).weekday == day);
    var dateSaturday = daysSaturday
        .map((e) => DateTime(dateNow.year, dateNow.month, e))
        .toList();

    return dateSaturday;
  }

  List<DateTime> getMonthsBetweenTwoDates(DateTime start, DateTime end) {
    List<DateTime> listDateTimes = [];
    bool isok = false;
    int month = start.month;
    int year = start.year;
    int day = 1;
    while (!isok) {
      if (month == end.month && year == end.year) {
        isok = true;
      }
      listDateTimes.add(DateTime(year, month, day));

      if (month == 12) {
        month = 0;
        year++;
      }
      month++;
    }
    return listDateTimes;
  }

  compareTwoDates(DateTime one, DateTime two) {
    return one.day == two.day && one.month == two.month && one.year == two.year;
  }

  compareTwoDatesMajorDay(DateTime one, DateTime two) {
    return one.day >= two.day && one.month >= two.month && one.year >= two.year;
  }

  compareTwoDatesMajorDayExplicity(DateTime one, DateTime two) {
    //if (compareTwoDates(one, two)) return true;
    return two.isBefore(one);
  }

  deepVerificationDatesBetweenDates(
      DateTime startTimeDate, DateTime endTimeDate, DateTime dateComparation) {
    startTimeDate = DateTime(
        startTimeDate.year, startTimeDate.month, startTimeDate.day - 1);
    endTimeDate =
        DateTime(endTimeDate.year, endTimeDate.month, endTimeDate.day + 1);

    var d = startTimeDate.isBefore(dateComparation) &&
        endTimeDate.isAfter(dateComparation);

    return d;
  }
}
