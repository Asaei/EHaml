function ToPersianDate(dt) {
    return MiladiToShamsi(dt.getFullYear(), dt.getMonth(), dt.getDate());
}


function MiladiIsLeap(miladiYear) {
    if (((miladiYear % 100) != 0 && (miladiYear % 4) == 0) || ((miladiYear % 100) == 0 && (miladiYear % 400) == 0))
        return 1;
    else
        return 0;
}

function MiladiToShamsi(iMiladiYear, iMiladiMonth, iMiladiDay) {
    iMiladiMonth++;
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

    return GetInt(shamsiYear).toString() + "/" + GetInt(shamsiMonth).toString() + "/" + GetInt(shamsiDay).toString();
}

function GetInt(a) {
    if (a > 0) {
        return Math.floor(a);
    } else {
        return Math.ceil(a);
    }
}

function _diffDays(dtstr) {
    var myDateParts = dtstr.replace(/\s+/g, "");

    var dt = Date.parse(myDateParts);
    var today = new Date();


    var td1 = new XDate(today.getFullYear(), today.getMonth() + 1, today.getDate());
    var td2 = new XDate(dt.getFullYear(), dt.getMonth() + 1, dt.getDate());

    var result = td1.diffDays(td2);

    return result;
}

function _diffDays2(dtstr) {
    var myDateParts = dtstr.replace(/\s+/g, "");

    var dt = Date.parse(myDateParts);
    var today = new Date();

    var td1 = new XDate(today.getFullYear(), today.getMonth() + 1, today.getDate());
    var td2 = new XDate(dt.getFullYear(), dt.getMonth() + 1, dt.getDate());

    var result = td2.diffDays(td1);

    return result;
}