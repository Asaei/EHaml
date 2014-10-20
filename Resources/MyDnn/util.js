function MiladiIsLeap(miladiYear) {
    if (((miladiYear % 100) != 0 && (miladiYear % 4) == 0) || ((miladiYear % 100) == 0 && (miladiYear % 400) == 0))
        return 1;
    else
        return 0;
}

function MiladiToShamsi(iMiladiYear, iMiladiMonth, iMiladiDay) {
    if (iMiladiYear < 1900) return [iMiladiYear, iMiladiMonth, iMiladiDay];
    var shamsiDay;
    var shamsiMonth;
    var shamsiYear;
    var dayCount;
    var farvardinDayDiff;
    var deyDayDiff;
    var sumDayMiladiMonth = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    var sumDayMiladiMonthLeap = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335];

    farvardinDayDiff = 79;

    if (MiladiIsLeap(iMiladiYear)) {
        dayCount = sumDayMiladiMonthLeap[iMiladiMonth - 1] + iMiladiDay;
    }
    else {
        dayCount = sumDayMiladiMonth[iMiladiMonth - 1] + iMiladiDay;
    }
    if ((MiladiIsLeap(iMiladiYear - 1))) {
        deyDayDiff = 11;
    }
    else {
        deyDayDiff = 10;
    }
    if (dayCount > farvardinDayDiff) {
        dayCount = dayCount - farvardinDayDiff;
        if (dayCount <= 186) {
            switch (dayCount % 31) {
                case 0:
                    shamsiMonth = dayCount / 31;
                    shamsiDay = 31;
                    break;
                default:
                    shamsiMonth = (dayCount / 31) + 1;
                    shamsiDay = (dayCount % 31);
                    break;
            }
            shamsiYear = iMiladiYear - 621;
        }
        else {
            dayCount = dayCount - 186;
            switch (dayCount % 30) {
                case 0:
                    shamsiMonth = (dayCount / 30) + 6;
                    shamsiDay = 30;
                    break;
                default:
                    shamsiMonth = (dayCount / 30) + 7;
                    shamsiDay = (dayCount % 30);
                    break;
            }
            shamsiYear = iMiladiYear - 621;
        }
    }
    else {
        dayCount = dayCount + deyDayDiff;

        switch (dayCount % 30) {
            case 0:
                shamsiMonth = (dayCount / 30) + 9;
                shamsiDay = 30;
                break;
            default:
                shamsiMonth = (dayCount / 30) + 10;
                shamsiDay = (dayCount % 30);
                break;
        }
        shamsiYear = iMiladiYear - 622;

    }

    return [GetInt(shamsiYear), GetInt(shamsiMonth), GetInt(shamsiDay)];
}

function ShamsiToMiladi(y, m, d) {
    if (y > 1500) return [y, m, d];
    var sumshamsi = [31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336, 365];
    var miladidays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var yy;
    var mm;
    var dd;
    var dd;
    var daycount;
    daycount = d;
    if (m > 1) daycount = daycount + sumshamsi[m - 2];
    yy = y + 621;
    daycount = daycount + 79;
    if (MiladiIsLeap(yy)) {
        if (daycount > 366) {
            daycount -= 366;
            yy++;
        }

    }
    else if (daycount > 365) {
        daycount -= 365;
        yy++;
    }
    if (MiladiIsLeap(yy)) miladidays[1] = 29;
    mm = 0;
    while (daycount > miladidays[mm]) {
        daycount = daycount - miladidays[mm];
        mm++;
    }
    return [yy, mm + 1, daycount];
}
