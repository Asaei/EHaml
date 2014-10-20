Type.registerNamespace("Telerik.Web.UI");
$telerik.findCalendar = $find;
$telerik.toCalendar = function (a) {
    return a;
};
Telerik.Web.UI.RadCalendar = function (a) {
    Telerik.Web.UI.RadCalendar.initializeBase(this, [a]);
    this._formatInfoArray = null;
    this._specialDaysArray = null;
    this._viewsHash = null;
    this._monthYearNavigationSettings = null;
    this._stylesHash = null;
    this._dayRenderChangedDays = null;
    this._viewRepeatableDays = null;
    this._postBackCall = null;
    this._firstDayOfWeek = null;
    this._skin = null;
    this._calendarWeekRule = null;
    this._culture = null;
    this._zIndex = null;
    this._enableShadows = true;
    this._nextFocusedCell = null;
    this._hoveredDate = null;
    this._hoveredDateTriplet = null;
    this._documentKeyDownDelegate = null;
    this._enabled = true;
    this._useColumnHeadersAsSelectors = true;
    this._useRowHeadersAsSelectors = true;
    this._showOtherMonthsDays = true;
    this._enableMultiSelect = true;
    this._singleViewColumns = 7;
    this._singleViewRows = 6;
    this._multiViewColumns = 1;
    this._multiViewRows = 1;
    this._fastNavigationStep = 3;
    this._enableNavigationAnimation = false;
    this._cellDayFormat = "%d";
    this._presentationType = Telerik.Web.UI.Calendar.PresentationType.Interactive;
    this._orientation = Telerik.Web.UI.Calendar.Orientation.RenderInRows;
    this._titleFormat = "MMMM yyyy";
    this._dayCellToolTipFormat = "dddd, MMMM dd, yyyy";
    this._showDayCellToolTips = true;
    this._dateRangeSeparator = " - ";
    this._autoPostBack = false;
    this._calendarEnableNavigation = true;
    this._calendarEnableMonthYearFastNavigation = true;
    this._enableRepeatableDaysOnClient = true;
    this._enableViewSelector = false;
    this._enableKeyboardNavigation = false;
    this._enableAriaSupport = true;
    this._showRowHeaders = false;
    this._navigateFromLinksButtons = true;
    this._rangeSelectionStartDate = null;
    this._rangeSelectionEndDate = null;
    this._rangeSelectionMode = {};
    this._hideNavigationControls = false;
    this._onLoadDelegate = null;
};
Telerik.Web.UI.RadCalendar.prototype = {
    initialize: function () {
        Telerik.Web.UI.RadCalendar.callBaseMethod(this, "initialize");
        this.EnableTodayButtonSelection = (this.get_monthYearNavigationSettings()[4] == "False") ? false : true;
        this.DateTimeFormatInfo = new Telerik.Web.UI.Calendar.DateTimeFormatInfo(this.get__FormatInfoArray());
        this.DateTimeFormatInfo.Calendar = (this.get_culture() == "fa-IR" ? Telerik.Web.UI.Calendar.PersianCalendar : Telerik.Web.UI.Calendar.GregorianCalendar);
        this.DateTimeFormatInfo.CalendarWeekRule = this._calendarWeekRule;
        var r, p, m;
        var b = this._auxDatesHidden();
        var t = eval(b.value);
        this.RangeMinDate = (this.get_culture() == "fa-IR" ? [1280, 1, 1] : t[0]);
        this.RangeMaxDate = t[1];
        this.FocusedDate = MiladiToShamsi(t[2][0], t[2][1],t[2][2]);
        this.SpecialDays = new Telerik.Web.UI.Calendar.DateCollection();
        for (r = 0;
        r < this.get_specialDaysArray().length;
        r++) {
            var c = new Telerik.Web.UI.Calendar.RenderDay(this.get_specialDaysArray()[r]);
            this.SpecialDays.Add(c.get_date(), c);
        }
        this.RecurringDays = new Telerik.Web.UI.Calendar.DateCollection();
        for (var q in this.get__ViewRepeatableDays()) {
            if (!this.get__ViewRepeatableDays().hasOwnProperty(q)) {
                continue;
            }
            var o = q.split("_");
            var a = this.get__ViewRepeatableDays()[q].split("_");
            var l = this.SpecialDays.Get(a);
            this.RecurringDays.Add(o, l);
        }
        this.RangeValidation = new Telerik.Web.UI.Calendar.RangeValidation(this.RangeMinDate, this.RangeMaxDate);
        this.Selection = new Telerik.Web.UI.Calendar.Selection(this.RangeValidation, this.SpecialDays, this.RecurringDays, this.get_enableMultiSelect());
        var e = [];
        for (var n in this.get__ViewsHash()) {
            if (!this.get__ViewsHash().hasOwnProperty(n)) {
                continue;
            }
            e[e.length] = n;
        }
        this._topViewID = e[0];
        this._titleID = this.get_id() + "_Title";
        var h = this._selectedDatesHidden();
        var g = eval(h.value);
        for (r = 0;
        r < g.length;
        r++) {
            this.Selection.Add(g[r]);
        }
        this._lastSelectedDate = null;
        this._calendarDomObject = $get(this.get_id());
        this._viewIDs = e;
        this._initViews();
        this._enableNavigation(this._isNavigationEnabled());
        this._attachEventHandlers();
        $addHandlers(this.get_element(), {
            click: Function.createDelegate(this, this._click)
        });
        if ($telerik.isRightToLeft(this.get_element())) {
            if (this.get_multiViewColumns() > 1 || this.get_multiViewRows() > 1) {
                Sys.UI.DomElement.addCssClass(this.get_element(), String.format("RadCalendarRTL_{0} RadCalendarMultiViewRTL_{0}", this.get_skin()));
            } else {
                Sys.UI.DomElement.addCssClass(this.get_element(), String.format("RadCalendarRTL_{0}", this.get_skin()));
            }
        }
        this.raise_init(Sys.EventArgs.Empty);
        if (this._enableKeyboardNavigation && !this._enableMultiSelect) {
            this._documentKeyDownDelegate = Function.createDelegate(this, this._documentKeyDown);
            $telerik.addExternalHandler(document, "keydown", this._documentKeyDownDelegate);
        }
        if (this.get_enableAriaSupport()) {
            this._initializeAriaSupport();
        }
        var d = this._selectedRangeDatesHidden();
        if (d) {
            var f = eval(d.value);
            var k = f[0];
            var s = f[1];
            if (!(k[0] == "1980" && k[1] == "1" && k[2] == "1")) {
                this._rangeSelectionStartDate = new Date(k[0], k[1] - 1, k[2]);
            }
            if (!(s[0] == "2099" && s[1] == "12" && s[2] == "30")) {
                this._rangeSelectionEndDate = new Date(s[0], s[1] - 1, s[2]);
            }
        }
    },
    dispose: function () {
        if (this.get_element()) {
            $clearHandlers(this.get_element());
        }
        if (!this.disposed) {
            this.disposed = true;
            this._destroyViews();
            this._calendarDomObject = null;
            if (this.MonthYearFastNav) {
                this.MonthYearFastNav.dispose();
            }
        }
        if (this._documentKeyDownDelegate) {
            $telerik.removeExternalHandler(document, "keydown", this._documentKeyDownDelegate);
            this._documentKeyDownDelegate = null;
        }
        Telerik.Web.UI.RadCalendar.callBaseMethod(this, "dispose");
    },
    _click: function (a) {
        var b = (a.srcElement) ? a.srcElement : a.target;
        if (b.tagName && b.tagName.toLowerCase() == "a") {
            var c = b.getAttribute("href", 2);
            if (c == "#" || (location.href + "#" == c)) {
                if (a.preventDefault) {
                    a.preventDefault();
                }
                return false;
            }
        }
    },
    _documentKeyDown: function (a) {
        if (this._enableKeyboardNavigation) {
            a = a || window.event;
            if (a.ctrlKey && a.keyCode == 89) {
                try {
                    this.CurrentViews[0].DomTable.tabIndex = 100;
                    this.CurrentViews[0].DomTable.focus();
                    return false;
                } catch (b) {
                    return false;
                }
            }
        }
    },
    get_enableAriaSupport: function () {
        return this._enableAriaSupport;
    },
    _initializeAriaSupport: function () {
        var b = this.get_element();
        var e = document.getElementById(b.id + "_Title");
        b.setAttribute("role", "grid");
        b.setAttribute("aria-atomic", "true");
        b.setAttribute("aria-labelledby", e.id);
        e.setAttribute("aria-live", "assertive");
        e.parentNode.parentNode.parentNode.setAttribute("role", "presentation");
        var d = b.getElementsByTagName("th");
        for (var f = 0, c = d.length;
        f < c;
        f++) {
            var a = d[f];
            if (a.scope === "col") {
                a.setAttribute("role", "columnheader");
            } else {
                if (a.scope === "row") {
                    a.setAttribute("role", "rowheader");
                }
            }
        }
        this._initializeAriaForCalendarDays();
    },
    _initializeAriaForCalendarDays: function () {
        var d = this.get_element();
        var f = d.getElementsByTagName("a");
        for (var j = 0, e = f.length;
        j < e;
        j++) {
            var c = f[j];
            c.tabIndex = -1;
            c.setAttribute("role", "presentation");
        }
        var h = this.get_selectedDates();
        if (!h.length) {
            var k = this.get_focusedDate();
            if (k) {
                var g = this._hoveredDate;
                var b = new Date(k[0], k[1] - 1, k[2]);
                if (g && (g - b) !== 0) {
                    k = [g.getFullYear(), g.getMonth() + 1, g.getDate()];
                }
                this._activateDate(k);
            }
        } else {
            for (var j = 0, e = h.length;
            j < e;
            j++) {
                var a = this._findRenderDay(h[j]);
                if (a) {
                    var c = a.DomElement.getElementsByTagName("a")[0];
                    if (c) {
                        c.tabIndex = 0;
                    }
                }
            }
        }
    },
    _activateDate: function (a) {
        var c = this._findRenderDay(a);
        if (c && c.DomElement) {
            this._nextFocusedCell = c.DomElement;
            this._hoveredDateTriplet = a;
            this._hoveredDate = new Date(a[0], a[1] - 1, a[2]);
            c.RadCalendarView._addClassAndGetFocus(this._nextFocusedCell, c.RadCalendarView.DomTable);
            if (this.get_enableAriaSupport()) {
                var b = c.DomElement.getElementsByTagName("a")[0];
                if (b) {
                    b.tabIndex = 0;
                }
            }
            return true;
        }
        return false;
    },
    selectDate: function (b, a) {
        if (this.EnableDateSelect == false) {
            return false;
        }
        this._performDateSelection(b, true, a);
    },
    selectDates: function (c, b) {
        if (false == this.EnableDateSelect) {
            return false;
        }
        for (var a = 0;
        a < c.length;
        a++) {
            this._performDateSelection(c[a], true, false, false);
        }
        if (b || b == null) {
            this.navigateToDate(c[c.length - 1]);
        }
    },
    unselectDate: function (a) {
        if (false == this.EnableDateSelect) {
            return false;
        }
        this._performDateSelection(a, false, false);
    },
    unselectDates: function (b) {
        if (false == this.EnableDateSelect) {
            return false;
        }
        for (var a = 0;
        a < b.length;
        a++) {
            this._performDateSelection(b[a], false, false, true);
        }
        this._submit("d");
    },
    calculateDateFromStep: function (c) {
        var b = this.CurrentViews[0];
        if (!b) {
            return;
        }
        var a = (c < 0 ? b._MonthStartDate : b._MonthEndDate);
        a = this.DateTimeFormatInfo.Calendar.AddDays(a, c);
        return a;
    },
    navigateToDate: function (b) {
        if (!this.RangeValidation.IsDateValid(b)) {
            b = this._getBoundaryDate(b);
            if (b == null) {
                if (this._getFastNavigation().DateIsOutOfRangeMessage != null && this._getFastNavigation().DateIsOutOfRangeMessage != " ") {
                    alert(this._getFastNavigation().DateIsOutOfRangeMessage);
                }
                return;
            }
        }
        var a = this._getStepFromDate(b);
        this._navigate(a);
    },
    GetSelectedDates: function () {
        return this.get_selectedDates();
    },
    GetRangeMinDate: function () {
        return this.get_rangeMinDate();
    },
    SetRangeMinDate: function (a) {
        this.set_rangeMinDate(a);
    },
    GetRangeMaxDate: function () {
        return this.get_rangeMaxDate();
    },
    SetRangeMaxDate: function (a) {
        this.set_rangeMaxDate(a);
    },
    get_selectedDates: function () {
        return this.Selection._selectedDates.GetValues();
    },
    get_rangeMinDate: function () {
        return this.RangeMinDate;
    },
    set_rangeMinDate: function (b) {
        if (this.RangeValidation.CompareDates(b, this.RangeMaxDate) > 0) {
            alert("RangeMinDate should be less than the RangeMaxDate value!");
            return;
        }
        var c = this.RangeMinDate;
        this.RangeMinDate = b;
        this.RangeValidation._rangeMinDate = b;
        this.MonthYearFastNav = null;
        var a = [this.FocusedDate[0], this.FocusedDate[1], 1];
        if (this.RangeValidation.CompareDates(a, this.RangeMinDate) <= 0 || this.RangeValidation.InSameMonth(a, c) || this.RangeValidation.InSameMonth(a, this.RangeMinDate)) {
            if (!this.RangeValidation.IsDateValid(this.FocusedDate)) {
                var d = new Date();
                d.setFullYear(b[0], b[1] - 1, b[2] + 1);
                this.FocusedDate = [d.getFullYear(), d.getMonth() + 1, d.getDate()];
            }
            this._moveToDate(this.FocusedDate, true);
        }
        this._serializeAuxDates();
        this._updateSelectedDates();
    },
    get_rangeMaxDate: function () {
        return this.RangeMaxDate;
    },
    set_rangeMaxDate: function (b) {
        if (this.RangeValidation.CompareDates(b, this.RangeMinDate) < 0) {
            alert("RangeMaxDate should be greater than the RangeMinDate value!");
            return;
        }
        var d = this.RangeMaxDate;
        this.RangeMaxDate = b;
        this.RangeValidation._rangeMaxDate = b;
        this.MonthYearFastNav = null;
        var a = [this.FocusedDate[0], this.FocusedDate[1], 1];
        if (this.RangeValidation.CompareDates(a, this.RangeMaxDate) > 0 || this.RangeValidation.InSameMonth(a, d) || this.RangeValidation.InSameMonth(a, this.RangeMaxDate)) {
            if (!this.RangeValidation.IsDateValid(this.FocusedDate)) {
                var c = new Date();
                c.setFullYear(b[0], b[1] - 1, b[2] - 1);
                this.FocusedDate = [c.getFullYear(), c.getMonth() + 1, c.getDate()];
            }
            this._moveToDate(this.FocusedDate, true);
        }
        this._serializeAuxDates();
        this._updateSelectedDates();
    },
    get_focusedDate: function () {
        return this.FocusedDate;
    },
    set_focusedDate: function (a) {
        this.FocusedDate = a;
    },
    get_specialDaysArray: function () {
        return this._specialDaysArray;
    },
    set_specialDaysArray: function (a) {
        if (this._specialDaysArray !== a) {
            this._specialDaysArray = a;
            this.raisePropertyChanged("specialDaysArray");
        }
    },
    get_enabled: function () {
        return this._enabled;
    },
    set_enabled: function (a) {
        if (this._enabled !== a) {
            this._enabled = a;
            if (this.RangeValidation) {
                this._moveToDate(this.FocusedDate, true);
            }
            this.raisePropertyChanged("enabled");
        }
    },
    get_useColumnHeadersAsSelectors: function () {
        return this._useColumnHeadersAsSelectors;
    },
    set_useColumnHeadersAsSelectors: function (a) {
        if (this._useColumnHeadersAsSelectors !== a) {
            this._useColumnHeadersAsSelectors = a;
            this.raisePropertyChanged("useColumnHeadersAsSelectors");
        }
    },
    get_useRowHeadersAsSelectors: function () {
        return this._useRowHeadersAsSelectors;
    },
    set_useRowHeadersAsSelectors: function (a) {
        if (this._useRowHeadersAsSelectors !== a) {
            this._useRowHeadersAsSelectors = a;
            this.raisePropertyChanged("useRowHeadersAsSelectors");
        }
    },
    get_showOtherMonthsDays: function () {
        return this._showOtherMonthsDays;
    },
    set_showOtherMonthsDays: function (a) {
        if (this._showOtherMonthsDays !== a) {
            this._showOtherMonthsDays = a;
            this.raisePropertyChanged("showOtherMonthsDays");
        }
    },
    get_enableMultiSelect: function () {
        return this._enableMultiSelect;
    },
    set_enableMultiSelect: function (c) {
        if (this._enableMultiSelect !== c) {
            this._enableMultiSelect = c;
            var f = this.Selection;
            if (f) {
                f._enableMultiSelect = c;
                var d = f._selectedDates;
                if (d && d.Count() > 0) {
                    this._removeAllSelectedDatesStyle();
                    var d = f._selectedDates;
                    var e;
                    if (d._lastInsertedKey) {
                        e = d.Get(d._lastInsertedKey);
                    } else {
                        var a = d.Count();
                        e = d.GetValues()[a - 1];
                    }
                    d.Clear();
                    f.Add(e);
                    var b = this._findRenderDay(e);
                    if (b != null) {
                        this._setStyleToRenderedDate(b, true);
                    }
                }
            }
            this.raisePropertyChanged("enableMultiSelect");
        }
    },
    get_singleViewColumns: function () {
        return this._singleViewColumns;
    },
    set_singleViewColumns: function (a) {
        if (this._singleViewColumns !== a) {
            this._singleViewColumns = a;
            this.raisePropertyChanged("singleViewColumns");
        }
    },
    get_singleViewRows: function () {
        return this._singleViewRows;
    },
    set_singleViewRows: function (a) {
        if (this._singleViewRows !== a) {
            this._singleViewRows = a;
            this.raisePropertyChanged("singleViewRows");
        }
    },
    get_multiViewColumns: function () {
        return this._multiViewColumns;
    },
    set_multiViewColumns: function (a) {
        if (this._multiViewColumns !== a) {
            this._multiViewColumns = a;
            this.raisePropertyChanged("multiViewColumns");
        }
    },
    get_multiViewRows: function () {
        return this._multiViewRows;
    },
    set_multiViewRows: function (a) {
        if (this._multiViewRows !== a) {
            this._multiViewRows = a;
            this.raisePropertyChanged("multiViewRows");
        }
    },
    get_fastNavigationStep: function () {
        return this._fastNavigationStep;
    },
    set_fastNavigationStep: function (a) {
        if (this._fastNavigationStep !== a) {
            this._fastNavigationStep = a;
            this.raisePropertyChanged("fastNavigationStep");
        }
    },
    get_skin: function () {
        return this._skin;
    },
    set_skin: function (a) {
        if (this._skin !== a) {
            this._skin = a;
            this.raisePropertyChanged("skin");
        }
    },
    get_enableNavigationAnimation: function () {
        return this._enableNavigationAnimation;
    },
    set_enableNavigationAnimation: function (a) {
        if (this._enableNavigationAnimation !== a) {
            this._enableNavigationAnimation = a;
            this.raisePropertyChanged("enableNavigationAnimation");
        }
    },
    get_cellDayFormat: function () {
        return this._cellDayFormat;
    },
    set_cellDayFormat: function (a) {
        if (this._cellDayFormat !== a) {
            this._cellDayFormat = a;
            this.raisePropertyChanged("cellDayFormat");
        }
    },
    get_presentationType: function () {
        return this._presentationType;
    },
    set_presentationType: function (a) {
        if (this._presentationType !== a) {
            this._presentationType = a;
            if (this.RangeValidation) {
                if (a == Telerik.Web.UI.Calendar.PresentationType.Preview) {
                    $telerik.$(".rcMain", this.get_element()).addClass("rcPreview");
                } else {
                    $telerik.$(".rcMain", this.get_element()).removeClass("rcPreview");
                }
                this._moveToDate(this.FocusedDate, true);
            }
            this.raisePropertyChanged("presentationType");
        }
    },
    get_orientation: function () {
        return this._orientation;
    },
    set_orientation: function (a) {
        if (this._orientation !== a) {
            this._orientation = a;
            this.raisePropertyChanged("orientation");
        }
    },
    get_titleFormat: function () {
        return this._titleFormat;
    },
    set_titleFormat: function (a) {
        if (this._titleFormat !== a) {
            this._titleFormat = a;
            this.raisePropertyChanged("titleFormat");
        }
    },
    get_showDayCellToolTips: function () {
        return this._showDayCellToolTips;
    },
    set_showDayCellToolTips: function (a) {
        if (this._showDayCellToolTips != a) {
            this._showDayCellToolTips = a;
            this.raisePropertyChanged("showDayCellToolTips");
        }
    },
    get_dayCellToolTipFormat: function () {
        return this._dayCellToolTipFormat;
    },
    set_dayCellToolTipFormat: function (a) {
        if (this._dayCellToolTipFormat !== a) {
            this._dayCellToolTipFormat = a;
            this.raisePropertyChanged("dayCellToolTipFormat");
        }
    },
    get_dateRangeSeparator: function () {
        return this._dateRangeSeparator;
    },
    set_dateRangeSeparator: function (a) {
        if (this._dateRangeSeparator !== a) {
            this._dateRangeSeparator = a;
            this.raisePropertyChanged("dateRangeSeparator");
        }
    },
    get_autoPostBack: function () {
        return this._autoPostBack;
    },
    set_autoPostBack: function (a) {
        if (this._autoPostBack !== a) {
            this._autoPostBack = a;
            this.raisePropertyChanged("autoPostBack");
        }
    },
    get_calendarEnableNavigation: function () {
        return this._calendarEnableNavigation;
    },
    set_calendarEnableNavigation: function (a) {
        if (this._calendarEnableNavigation !== a) {
            this._calendarEnableNavigation = a;
            this.raisePropertyChanged("calendarEnableNavigation");
        }
    },
    get_calendarEnableMonthYearFastNavigation: function () {
        return this._calendarEnableMonthYearFastNavigation;
    },
    set_calendarEnableMonthYearFastNavigation: function (a) {
        if (this._calendarEnableMonthYearFastNavigation !== a) {
            this._calendarEnableMonthYearFastNavigation = a;
            if (!a) {
                $telerik.$(".rcTitlebar", this.get_element()).addClass("rcNoNav");
            } else {
                $telerik.$(".rcTitlebar", this.get_element()).removeClass("rcNoNav");
            }
            this.raisePropertyChanged("calendarEnableMonthYearFastNavigation");
        }
    },
    get_enableRepeatableDaysOnClient: function () {
        return this._enableRepeatableDaysOnClient;
    },
    set_enableRepeatableDaysOnClient: function (a) {
        if (this._enableRepeatableDaysOnClient !== a) {
            this._enableRepeatableDaysOnClient = a;
            this.raisePropertyChanged("enableRepeatableDaysOnClient");
        }
    },
    get_monthYearNavigationSettings: function () {
        return this._monthYearNavigationSettings;
    },
    set_monthYearNavigationSettings: function (a) {
        if (this._monthYearNavigationSettings !== a) {
            this._monthYearNavigationSettings = a;
            this.raisePropertyChanged("monthYearNavigationSettings");
        }
    },
    get_stylesHash: function () {
        return this._stylesHash;
    },
    set_stylesHash: function (a) {
        if (this._stylesHash !== a) {
            this._stylesHash = a;
            this.raisePropertyChanged("stylesHash");
        }
    },
    get_culture: function () {
        return this._culture;
    },
    get_enableViewSelector: function () {
        return this._enableViewSelector;
    },
    set_datesInRange: function (b, a) {
        if (b && b) {
            if (b > a) {
                var c = b;
                b = a;
                a = c;
            }
            this._rangeSelectionStartDate = b;
            this._rangeSelectionEndDate = a;
            this.Selection._selectedDates.Clear();
            this._removeAllSelectedDatesStyle();
            this._initialRangeSelection(this._rangeSelectionStartDate, this._rangeSelectionEndDate);
        }
    },
    get_rangeSelectionStartDate: function () {
        return this._rangeSelectionStartDate;
    },
    get_rangeSelectionEndDate: function () {
        return this._rangeSelectionEndDate;
    },
    get_hideNavigationControls: function () {
        return this._hideNavigationControls;
    },
    set_hideNavigationControls: function (a) {
        if (this._hideNavigationControls !== a) {
            this._hideNavigationControls = a;
            this.raisePropertyChanged("hideNavigationControls");
        }
    },
    _destroyViews: function () {
        for (var a = this._viewIDs.length - 1;
        a >= 0;
        a--) {
            this._disposeView(this._viewIDs[a]);
        }
        this.CurrentViews = null;
        this._viewsHash = null;
    },
    _attachEventHandlers: function () {
        this._onLoadDelegate = Function.createDelegate(this, this._onLoadHandler);
        Sys.Application.add_load(this._onLoadDelegate);
    },
    _isRtl: function () {
        if (typeof (this.Rtl) == "undefined") {
            this.Rtl = (this._getTextDirection() == "rtl");
        }
        return this.Rtl;
    },
    _getTextDirection: function () {
        var a = this._calendarDomObject;
        while (a != null) {
            if (a.dir.toLowerCase() == "rtl") {
                return "rtl";
            }
            a = a.parentNode;
        }
        return "ltr";
    },
    _getItemStyle: function (f, c, d, a, g, b) {
        var e;
        if (c) {
            e = this.get_stylesHash()["OutOfRangeDayStyle"];
        } else {
            if (f && !this.get_showOtherMonthsDays()) {
                e = this.get_stylesHash()["OtherMonthDayStyle"];
            } else {
                if (a) {
                    e = this.get_stylesHash()["SelectedDayStyle"];
                } else {
                    if (b) {
                        e = b;
                    } else {
                        if (f) {
                            e = this.get_stylesHash()["OtherMonthDayStyle"];
                        } else {
                            if (d) {
                                e = this.get_stylesHash()["WeekendDayStyle"];
                            } else {
                                e = this.get_stylesHash()["DayStyle"];
                            }
                        }
                    }
                }
            }
        }
        return e;
    },
    _isNavigationEnabled: function () {
        if (!this.get_enabled() || !this.get_calendarEnableNavigation()) {
            return false;
        }
        return true;
    },
    _isMonthYearNavigationEnabled: function () {
        if (!this.get_enabled() || !this.get_calendarEnableMonthYearFastNavigation()) {
            return false;
        }
        return true;
    },
    _hideDisabledNavigation: function (b, c) {
        var d = this.DateTimeFormatInfo.Calendar.AddMonths(this.FocusedDate, c);
        var a = [this.get_rangeMinDate()[0], this.get_rangeMinDate()[1], this.get_rangeMinDate()[2]];
        var g = [this.get_rangeMaxDate()[0], this.get_rangeMaxDate()[1], this.get_rangeMaxDate()[2]];
        d[2] = a[2] = g[2] = 1;
        var e = this.RangeValidation.CompareDates(d, a);
        var f = this.RangeValidation.CompareDates(d, g);
        if (this.RangeValidation.IsDateValid(d) || e == 0 || f == 0) {
            b.style.visibility = "";
        } else {
            b.style.visibility = "hidden";
        }
    },
    _enableNavigation: function (a) {
        a = (false != a);
        var b = $get(this.get_id() + "_FNP");
        if (b) {
            b.onclick = (!a ? null : Telerik.Web.UI.Calendar.Utils.AttachMethod(this._fastNavigatePrev, this));
            if (this.get_hideNavigationControls()) {
                this._hideDisabledNavigation(b, -this.get_fastNavigationStep());
            }
        }
        b = $get(this.get_id() + "_NP");
        if (b) {
            b.onclick = (!a ? null : Telerik.Web.UI.Calendar.Utils.AttachMethod(this._navigatePrev, this));
            if (this.get_hideNavigationControls()) {
                this._hideDisabledNavigation(b, -1);
            }
        }
        b = $get(this.get_id() + "_NN");
        if (b) {
            b.onclick = (!a ? null : Telerik.Web.UI.Calendar.Utils.AttachMethod(this._navigateNext, this));
            if (this.get_hideNavigationControls()) {
                this._hideDisabledNavigation(b, 1);
            }
        }
        b = $get(this.get_id() + "_FNN");
        if (b) {
            b.onclick = (!a ? null : Telerik.Web.UI.Calendar.Utils.AttachMethod(this._fastNavigateNext, this));
            if (this.get_hideNavigationControls()) {
                this._hideDisabledNavigation(b, this.get_fastNavigationStep());
            }
        }
        b = $get(this._titleID);
        if (b && this._isMonthYearNavigationEnabled()) {
            b.onclick = Telerik.Web.UI.Calendar.Utils.AttachMethod(this._showMonthYearFastNav, this);
            b.oncontextmenu = Telerik.Web.UI.Calendar.Utils.AttachMethod(this._showMonthYearFastNav, this);
        }
    },
    _findRenderDay: function (a) {
        var b = null;
        for (var c = 0;
        c < this.CurrentViews.length;
        c++) {
            var d = this.CurrentViews[c];
            if (d.RenderDays == null) {
                continue;
            }
            b = d.RenderDays.Get(a);
            if (b != null) {
                return b;
            }
        }
        return null;
    },
    _performDateSelection: function (f, d, c, e) {
        if (this.Selection.CanSelect(f)) {
            if (c == true) {
                this.navigateToDate(f);
            }
            var a = this._findRenderDay(f);
            if (d) {
                if (a) {
                    a.Select(true, e);
                } else {
                    var b = this._findRenderDay(this._lastSelectedDate);
                    if (b && !this.get_enableMultiSelect()) {
                        b.PerformSelect(false);
                    }
                    this.Selection.Add(f);
                    this._serializeSelectedDates();
                    this._lastSelectedDate = f;
                }
            } else {
                if (a) {
                    a.Select(false, e);
                } else {
                    this.Selection.Remove(f);
                    this._serializeSelectedDates();
                }
            }
        }
    },
    _disposeView: function (a) {
        for (var g = 0;
        g < this.CurrentViews.length;
        g++) {
            var b = this.CurrentViews[g];
            if (b.DomTable && b.DomTable.id == a) {
                var e = b.DomTable.getElementsByTagName("a");
                for (var f = 0, d = e.length;
                f < d;
                f++) {
                    var c = e[f];
                    $clearHandlers(c);
                }
                b.dispose();
                this.CurrentViews.splice(g, 1);
                return;
            }
        }
    },
    _findView: function (d) {
        var b = null;
        for (var c = 0;
        c < this.CurrentViews.length;
        c++) {
            var a = this.CurrentViews[c];
            if (a.DomTable.id == d) {
                b = a;
                break;
            }
        }
        return b;
    },
    _initViews: function (d) {
        if (!d) {
            d = this._viewIDs;
        }
        this.CurrentViews = [];
        var e;
        for (var c = 0;
        c < d.length;
        c++) {
            e = (c == 0 && d.length > 1);
            var b = d[c];
            var a = new Telerik.Web.UI.Calendar.CalendarView(this, $get(d[c]), b, e ? this.get_multiViewColumns() : this.get_singleViewColumns(), e ? this.get_multiViewRows() : this.get_singleViewRows(), e, this.get_useRowHeadersAsSelectors(), this.get_useColumnHeadersAsSelectors(), this.get_orientation());
            a.MonthsInView = this.get__ViewsHash()[b][1];
            this._disposeView(d[c]);
            this.CurrentViews[c] = a;
        }
        if ((typeof (this.CurrentViews) != "undefined") && (typeof (this.CurrentViews[0]) != "undefined") && this.CurrentViews[0].IsMultiView) {
            this.CurrentViews[0]._ViewStartDate = this.CurrentViews[0]._MonthStartDate = this.CurrentViews[1]._MonthStartDate;
            this.CurrentViews[0]._ViewEndDate = this.CurrentViews[0]._MonthEndDate = this.CurrentViews[(this.CurrentViews.length - 1)]._MonthEndDate;
        }
    },
    _serializeSelectedDates: function () {
        var a = "[";
        var e = this.Selection._selectedDates;
        var c = e.GetValues();
        var b = e.Get(e._lastInsertedKey);
        for (var d = 0;
        d < c.length;
        d++) {
            if (c[d] && c[d] !== b) {
                a += "[" + c[d][0] + "," + c[d][1] + "," + c[d][2] + "],";
            }
        }
        if (b) {
            a += "[" + b[0] + "," + b[1] + "," + b[2] + "],";
        }
        if (a.length > 1) {
            a = a.substring(0, a.length - 1);
        }
        a += "]";
        if (this._selectedDatesHidden() != null) {
            this._selectedDatesHidden().value = a;
        }
    },
    _selectedDatesHidden: function () {
        return $get(this.get_id() + "_SD");
    },
    _serializeAuxDates: function () {
        var a = "[[" + this.RangeMinDate + "],[" + this.RangeMaxDate + "],[" + this.FocusedDate + "]]";
        if (this._auxDatesHidden() != null) {
            this._auxDatesHidden().value = a;
        }
    },
    _auxDatesHidden: function () {
        return $get(this.get_id() + "_AD");
    },
    _submit: function (a) {
        if (this.get_autoPostBack()) {
            this._doPostBack(a);
        } else {
            this._execClientAction(a);
        }
    },
    _deserializeNavigationArgument: function (a) {
        var b = a.split(":");
        return b;
    },
    _execClientAction: function (d) {
        var e = d.split(":");
        switch (e[0]) {
            case "d":
                break;
            case "n":
                if (this.CurrentViews && !this.CurrentViews[0].IsMultiView) {
                    var c = parseInt(e[1], 0);
                    var a = parseInt(e[2], 0);
                    this._moveByStep(c, a);
                }
                break;
            case "nd":
                var b = [parseInt(e[1]), parseInt(e[2]), parseInt(e[3])];
                this._moveToDate(b);
                break;
        }
    },
    _moveByStep: function (c, b) {
        var a = this.CurrentViews[0];
        if (!a) {
            return;
        }
        var d = (c < 0 ? a._MonthStartDate : a._MonthEndDate);
        d = this.DateTimeFormatInfo.Calendar.AddMonths(d, c);
        if (!this.RangeValidation.IsDateValid(d)) {
            if (c > 0) {
                d = [this.RangeMaxDate[0], this.RangeMaxDate[1], this.RangeMaxDate[2]];
            } else {
                d = [this.RangeMinDate[0], this.RangeMinDate[1], this.RangeMinDate[2]];
            }
        }
        //dnn change
        //if (c != 0) {
        //    this._moveToDate(d);
        //}
        this._moveToDate(d);
    },
    _moveToDate: function (d, e) {
        if (typeof (e) == "undefined") {
            e = false;
        }
        if (this.get_multiViewColumns() > 1 || this.get_multiViewRows() > 1) {
            return false;
        }
        if (!this.RangeValidation.IsDateValid(d)) {
            d = this._getBoundaryDate(d);
            if (d == null) {
                if (this._getFastNavigation().DateIsOutOfRangeMessage != null && this._getFastNavigation().DateIsOutOfRangeMessage != " ") {
                    alert(this._getFastNavigation().DateIsOutOfRangeMessage);
                }
                return;
            }
        }
        var f = this.FocusedDate;
        this.FocusedDate = d;
        d[2] = f[2] = 1;
        var b = this.RangeValidation.CompareDates(d, f);
        //dnn change
        //if (b == 0 && !e) {
        //    return;
        //}
        var c = this._viewIDs[0];
        var g = false;
        this._disposeView(c);
        var a = new Telerik.Web.UI.Calendar.CalendarView(this, $get(c), c, g ? this.get_multiViewColumns() : this.get_singleViewColumns(), g ? this.get_multiViewRows() : this.get_singleViewRows(), g, this.get_useRowHeadersAsSelectors(), this.get_useColumnHeadersAsSelectors(), this.get_orientation(), d);
        this.CurrentViews[this.CurrentViews.length] = a;
        a.ScrollDir = b;
        a.RenderDaysSingleView();
    },
    _checkRequestConditions: function (b) {
        var c = this._deserializeNavigationArgument(b);
        var a = 0;
        var d = null;
        if (c[0] != "d") {
            if (c[0] == "n") {
                a = parseInt(c[1], 0);
                d = this.calculateDateFromStep(a);
            } else {
                if (c[0] == "nd") {
                    d = [parseInt(c[1]), parseInt(c[2]), parseInt(c[3])];
                }
            }
            if (!this.RangeValidation.IsDateValid(d)) {
                d = this._getBoundaryDate(d);
                if (d == null) {
                    if (this._getFastNavigation().DateIsOutOfRangeMessage != null && this._getFastNavigation().DateIsOutOfRangeMessage != " ") {
                        alert(this._getFastNavigation().DateIsOutOfRangeMessage);
                    }
                    return false;
                }
            }
        }
        return true;
    },
    _doPostBack: function (a) {
        if (this._checkRequestConditions(a)) {
            var b = this._postBackCall.replace("@@", a);
            if (this.postbackAction != null) {
                window.clearTimeout(this.postbackAction);
            }
            var c = this;
            this.postbackAction = window.setTimeout(function () {
                c.postbackAction = null;
                eval(b);
            }, 200);
        }
    },
    _getStepFromDate: function (b) {
        //mydnn change
        if (this.get_culture() == "fa-IR" && b[0] > 1900) b = MiladiToShamsi(b[0], b[1], b[2]);

        var a = b[0] - this.FocusedDate[0];
        var d = b[1] - this.FocusedDate[1];
        var c = a * 12 + d;
        return c;
    },
    _getBoundaryDate: function (a) {
        if (!this.RangeValidation.IsDateValid(a)) {
            if (this._isInSameMonth(a, this.RangeMinDate)) {
                return [this.RangeMinDate[0], this.RangeMinDate[1], this.RangeMinDate[2]];
            }
            if (this._isInSameMonth(a, this.RangeMaxDate)) {
                return [this.RangeMaxDate[0], this.RangeMaxDate[1], this.RangeMaxDate[2]];
            }
            return null;
        }
        return a;
    },
    _navigate: function (c) {
        var a = new Telerik.Web.UI.CalendarViewChangingEventArgs(c);
        this.raise_calendarViewChanging(a);
        if (a.get_cancel()) {
            return;
        }
        this.navStep = c;
        this._submit("n:" + c);
        this._serializeAuxDates();
        var b = new Telerik.Web.UI.CalendarViewChangedEventArgs(c);
        if (this.get_enableAriaSupport()) {
            this._initializeAriaForCalendarDays();
        }
        this.raise_calendarViewChanged(b);
    },
    _clearKeyBoardNavigationProperties: function () {
        if (this._navigateFromLinksButtons && this._enableKeyboardNavigation && !this._enableMultiSelect) {
            this.CurrentViews[0].RadCalendar._nextFocusedCell = null;
            this.CurrentViews[0].RadCalendar._hoveredDate = null;
            this.CurrentViews[0].RadCalendar._hoveredDateTriplet = null;
            this.CurrentViews[0]._removeHoverStyles(this.CurrentViews[0].DomTable);
        }
    },
    _fastNavigatePrev: function () {
        this._clearKeyBoardNavigationProperties();
        var b = this._findView(this._topViewID);
        var a = (-this.get_fastNavigationStep()) * b.MonthsInView;
        this._navigate(a);
        return false;
    },
    _navigatePrev: function () {
        this._clearKeyBoardNavigationProperties();
        var a = this._findView(this._topViewID);
        this._navigate(-a.MonthsInView);
        return false;
    },
    _navigateNext: function () {
        this._clearKeyBoardNavigationProperties();
        var a = this._findView(this._topViewID);
        this._navigate(a.MonthsInView);
        return false;
    },
    _fastNavigateNext: function () {
        this._clearKeyBoardNavigationProperties();
        var b = this._findView(this._topViewID);
        var a = this.get_fastNavigationStep() * b.MonthsInView;
        this._navigate(a);
        return false;
    },
    _getRenderDayID: function (a) {
        return (this.get_id() + "_" + a.join("_"));
    },
    _isInSameMonth: function (d, c) {
        if (!d || d.length != 3) {
            throw new Error("Date1 must be array: [y, m, d]");
        }
        if (!c || c.length != 3) {
            throw new Error("Date2 must be array: [y, m, d]");
        }
        var a = d[0];
        var e = c[0];
        if (a < e) {
            return false;
        }
        if (a > e) {
            return false;
        }
        var b = d[1];
        var f = c[1];
        if (b < f) {
            return false;
        }
        if (b > f) {
            return false;
        }
        return true;
    },
    _getFastNavigation: function () {
        var a = this.MonthYearFastNav;
        if (!a) {
            a = new Telerik.Web.UI.Calendar.MonthYearFastNavigation(this.DateTimeFormatInfo.AbbreviatedMonthNames, this.RangeMinDate, this.RangeMaxDate, this.get_skin(), this.get_id(), this.get_monthYearNavigationSettings());
            this.MonthYearFastNav = a;
        }
        return this.MonthYearFastNav;
    },
    _showMonthYearFastNav: function (a) {
        if (!a) {
            a = window.event;
        }
        this._enableNavigation(this._isNavigationEnabled());
        if (this._isMonthYearNavigationEnabled()) {
            this._getFastNavigation().Show(this._getPopup(), RadHelperUtils.MouseEventX(a), RadHelperUtils.MouseEventY(a), this.FocusedDate[1], this.FocusedDate[0], Telerik.Web.UI.Calendar.Utils.AttachMethod(this._monthYearFastNavExitFunc, this), this.get_stylesHash()["FastNavigationStyle"]);
        }
        a.returnValue = false;
        a.cancelBubble = true;
        if (a.stopPropagation) {
            a.stopPropagation();
        }
        if (!document.all) {
            window.setTimeout(function () {
                try {
                    document.getElementsByTagName("INPUT")[0].focus();
                } catch (b) { }
            }, 1);
        }
        return false;
    },
    _getPopup: function () {
        var a = this.Popup;
        if (!a) {
            a = new Telerik.Web.UI.Calendar.Popup();
            if (this._zIndex) {
                a.zIndex = this._zIndex;
            }
            if (!this._enableShadows) {
                a.EnableShadows = false;
            }
            this.Popup = a;
        }
        return a;
    },
    _monthYearFastNavExitFunc: function (a, c, b) {
        if (!b || !this.EnableTodayButtonSelection) {
            this.navigateToDate([a, c + 1, 1]);
        } else {
            this.unselectDate([a, c + 1, b]);
            this.selectDate([a, c + 1, b], true);
            if (this.EnableTodayButtonSelection && this.get_autoPostBack()) {
                this._submit(["nd", a, (c + 1), b].join(":"));
            }
        }
    },
    _updateSelectedDates: function () {
        debugger
        var b = this.get_selectedDates();
        for (var a = 0;
        a < b.length;
        a++) {
            if (!this.RangeValidation.IsDateValid(b[a])) {
                this.Selection.Remove(b[a]);
            }
        }
    },
    _onLoadHandler: function (a) {
        this.raise_load(Sys.EventArgs.Empty);
    },
    get__FormatInfoArray: function () {
        return this._formatInfoArray;
    },
    set__FormatInfoArray: function (a) {
        if (this._formatInfoArray !== a) {
            this._formatInfoArray = a;
            this.raisePropertyChanged("formatInfoArray");
        }
    },
    get__ViewsHash: function () {
        return this._viewsHash;
    },
    set__ViewsHash: function (a) {
        if (this._viewsHash !== a) {
            this._viewsHash = a;
            this.raisePropertyChanged("viewsHash");
        }
    },
    get__DayRenderChangedDays: function () {
        return this._dayRenderChangedDays;
    },
    set__DayRenderChangedDays: function (a) {
        if (this._dayRenderChangedDays !== a) {
            this._dayRenderChangedDays = a;
            this.raisePropertyChanged("dayRenderChangedDays");
        }
    },
    get__ViewRepeatableDays: function () {
        return this._viewRepeatableDays;
    },
    set__ViewRepeatableDays: function (a) {
        if (this._viewRepeatableDays !== a) {
            this._viewRepeatableDays = a;
            this.raisePropertyChanged("viewRepeatableDays");
        }
    },
    add_init: function (a) {
        this.get_events().addHandler("init", a);
    },
    remove_init: function (a) {
        this.get_events().removeHandler("init", a);
    },
    raise_init: function (a) {
        this.raiseEvent("init", a);
    },
    add_load: function (a) {
        this.get_events().addHandler("load", a);
    },
    remove_load: function (a) {
        this.get_events().removeHandler("load", a);
    },
    raise_load: function (a) {
        this.raiseEvent("load", a);
    },
    add_dateSelecting: function (a) {
        this.get_events().addHandler("dateSelecting", a);
    },
    remove_dateSelecting: function (a) {
        this.get_events().removeHandler("dateSelecting", a);
    },
    raise_dateSelecting: function (a) {
        this.raiseEvent("dateSelecting", a);
    },
    add_dateSelected: function (a) {
        this.get_events().addHandler("dateSelected", a);
    },
    remove_dateSelected: function (a) {
        this.get_events().removeHandler("dateSelected", a);
    },
    raise_dateSelected: function (a) {
        this.raiseEvent("dateSelected", a);
    },
    add_dateClick: function (a) {
        this.get_events().addHandler("dateClick", a);
    },
    remove_dateClick: function (a) {
        this.get_events().removeHandler("dateClick", a);
    },
    raise_dateClick: function (a) {
        this.raiseEvent("dateClick", a);
    },
    add_calendarViewChanging: function (a) {
        this.get_events().addHandler("calendarViewChanging", a);
    },
    remove_calendarViewChanging: function (a) {
        this.get_events().removeHandler("calendarViewChanging", a);
    },
    raise_calendarViewChanging: function (a) {
        this.raiseEvent("calendarViewChanging", a);
    },
    add_calendarViewChanged: function (a) {
        this.get_events().addHandler("calendarViewChanged", a);
    },
    remove_calendarViewChanged: function (a) {
        this.get_events().removeHandler("calendarViewChanged", a);
    },
    raise_calendarViewChanged: function (a) {
        this.raiseEvent("calendarViewChanged", a);
    },
    add_dayRender: function (a) {
        this.get_events().addHandler("dayRender", a);
    },
    remove_dayRender: function (a) {
        this.get_events().removeHandler("dayRender", a);
    },
    raise_dayRender: function (a) {
        this.raiseEvent("dayRender", a);
    },
    add_rowHeaderClick: function (a) {
        this.get_events().addHandler("rowHeaderClick", a);
    },
    remove_rowHeaderClick: function (a) {
        this.get_events().removeHandler("rowHeaderClick", a);
    },
    raise_rowHeaderClick: function (a) {
        this.raiseEvent("rowHeaderClick", a);
    },
    add_columnHeaderClick: function (a) {
        this.get_events().addHandler("columnHeaderClick", a);
    },
    remove_columnHeaderClick: function (a) {
        this.get_events().removeHandler("columnHeaderClick", a);
    },
    raise_columnHeaderClick: function (a) {
        this.raiseEvent("columnHeaderClick", a);
    },
    add_viewSelectorClick: function (a) {
        this.get_events().addHandler("viewSelectorClick", a);
    },
    remove_viewSelectorClick: function (a) {
        this.get_events().removeHandler("viewSelectorClick", a);
    },
    raise_viewSelectorClick: function (a) {
        this.raiseEvent("viewSelectorClick", a);
    },
    _selectedRangeDatesHidden: function () {
        return $get(this.get_id() + "_RS");
    },
    _serializeRangeSelectionDates: function () {
        var b = null;
        var a = null;
        if (this._rangeSelectionStartDate) {
            b = [this._rangeSelectionStartDate.getFullYear(), this._rangeSelectionStartDate.getMonth() + 1, this._rangeSelectionStartDate.getDate()];
        } else {
            b = [1980, 1, 1];
        }
        if (this._rangeSelectionEndDate) {
            a = [this._rangeSelectionEndDate.getFullYear(), this._rangeSelectionEndDate.getMonth() + 1, this._rangeSelectionEndDate.getDate()];
        } else {
            a = [2099, 12, 30];
        }
        var c = "[[" + b + "],[" + a + "]]";
        if (this._selectedRangeDatesHidden() != null) {
            this._selectedRangeDatesHidden().value = c;
        }
    },
    _removeRangeSelection: function () {
        if (this._rangeSelectionEndDate && this._rangeSelectionStartDate) {
            this._removeAllSelectedDatesStyle();
            this.Selection._selectedDates.Clear();
            this._rangeSelectionEndDate = null;
            this._rangeSelectionStartDate = null;
        }
    },
    _dateClick: function (b) {
        var d = b._renderDay.RadCalendarView.ID;
        var f = b._renderDay._date;
        if (this._rangeSelectionStartDate && this._rangeSelectionEndDate) {
            this._removeAllSelectedDatesStyle();
            this.Selection._selectedDates.Clear();
            this._rangeSelectionEndDate = null;
            this._rangeSelectionStartDate = null;
        }
        if (b._domEvent.shiftKey && this._rangeSelectionStartDate && Telerik.Web.UI.Calendar.RangeSelectionMode.OnKeyHold == this._rangeSelectionMode || this._rangeSelectionStartDate && Telerik.Web.UI.Calendar.RangeSelectionMode.ConsecutiveClicks == this._rangeSelectionMode) {
            this._removeAllSelectedDatesStyle();
            this.Selection._selectedDates.Clear();
            this._rangeSelectionEndDate = new Date(f[0], f[1] - 1, f[2]);
            var a = false;
            if (this._rangeSelectionStartDate > this._rangeSelectionEndDate) {
                var c = this._rangeSelectionStartDate;
                this._rangeSelectionStartDate = this._rangeSelectionEndDate;
                this._rangeSelectionEndDate = c;
                a = true;
            }
            this._performSelection(this._rangeSelectionStartDate, this._rangeSelectionEndDate, a, d);
        } else {
            this._rangeSelectionStartDate = new Date(f[0], f[1] - 1, f[2]);
            this._rangeSelectionEndDate = null;
        }
        this._serializeRangeSelectionDates();
    },
    _removeAllSelectedDatesStyle: function () {
        for (var b = 0;
        b < this.CurrentViews.length;
        b++) {
            var a = this.CurrentViews[b].RenderDays;
            if (a) {
                for (var c = 0;
                c < a.GetValues().length;
                c++) {
                    var d = a.GetValues()[c];
                    this._setStyleToRenderedDate(d, false);
                }
            }
        }
    },
    _getAllSelectedDates: function (d, c) {
        var e = new Array();
        var g = [d.getFullYear(), d.getMonth() + 1, d.getDate()];
        e.push(g);
        var a = new Date(d.getTime() + 86400000);
        var f = a.getHours();
        while (a < c) {
            g = [a.getFullYear(), a.getMonth() + 1, a.getDate()];
            e.push(g);
            a = new Date(a.getTime() + 86400000);
            if (f != a.getHours()) {
                var b = this._addDays(a, -1);
                g = [b.getFullYear(), b.getMonth() + 1, b.getDate()];
                e.push(g);
            }
            f = a.getHours();
        }
        g = [c.getFullYear(), c.getMonth() + 1, c.getDate()];
        e.push(g);
        return e;
    },
    _initialRangeSelection: function (a, c) {
        var d = this._getAllSelectedDates(a, c);
        for (var e = 0;
        e < d.length;
        e++) {
            this.Selection.Add(d[e]);
            var b = this._findRenderDay(d[e]);
            if (b) {
                this._setStyleToRenderedDate(b, true);
            }
        }
        this._serializeSelectedDates();
    },
    _performSelection: function (a, c, g, b) {
        var e = this._getAllSelectedDates(a, c);
        for (var f = 0;
        f < e.length;
        f++) {
            this.Selection.Add(e[f]);
        }
        this._serializeSelectedDates();
        var d;
        if (!g) {
            d = [c.getFullYear(), c.getMonth() + 1, c.getDate()];
        } else {
            d = [a.getFullYear(), a.getMonth() + 1, a.getDate()];
        }
        this._applyStyles(d, b);
    },
    _addDays: function (b, a) {
        var c = new Date(b.getFullYear(), b.getMonth(), b.getDate());
        return new Date(c.setDate(c.getDate() + a));
    },
    _setStyleToRenderedDate: function (a, c) {
        a.IsSelected = c;
        var b = a.GetDefaultItemStyle();
        if (b) {
            a.DomElement.className = b[1];
            a.DomElement.style.cssText = b[0];
        }
    },
    _applyStyles: function (g, b) {
        var a = false;
        var d = this.CurrentViews;
        for (var f = 0;
        f < d.length;
        f++) {
            var c = d[f].RenderDays;
            if (c) {
                for (var e = 0;
                e < c.GetValues().length;
                e++) {
                    if (this.Selection._selectedDates.Get(c.GetValues()[e]._date)) {
                        var h = c.GetValues()[e];
                        if (h._date.toString() == g.toString() && b == this.CurrentViews[f].ID) {
                            continue;
                        }
                        this._setStyleToRenderedDate(h, true);
                    }
                }
            }
        }
    }
};
Telerik.Web.UI.RadCalendar.registerClass("Telerik.Web.UI.RadCalendar", Telerik.Web.UI.RadWebControl);
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.DateTimeFormatInfo = function (a) {
    this.DayNames = a[0];
    this.AbbreviatedDayNames = a[1];
    this.MonthNames = a[2];
    this.AbbreviatedMonthNames = a[3];
    this.FullDateTimePattern = a[4];
    this.LongDatePattern = a[5];
    this.LongTimePattern = a[6];
    this.MonthDayPattern = a[7];
    this.RFC1123Pattern = a[8];
    this.ShortDatePattern = a[9];
    this.ShortTimePattern = a[10];
    this.SortableDateTimePattern = a[11];
    this.UniversalSortableDateTimePattern = a[12];
    this.YearMonthPattern = a[13];
    this.AMDesignator = a[14];
    this.PMDesignator = a[15];
    this.DateSeparator = a[16];
    this.TimeSeparator = a[17];
    this.FirstDayOfWeek = a[18];
    this.CalendarWeekRule = 0;
    this.Calendar = null;
};
Telerik.Web.UI.Calendar.DateTimeFormatInfo.prototype = {
    LeadZero: function (a) {
        return (a < 0 || a > 9 ? "" : "0") + a;
    },
    FormatDate: function (b, N) {
        N = N + "";
        N = N.replace(/%/ig, "");
        var S = "";
        var Q = 0;
        var G = "";
        var p = "";
        var v = "" + b[0];
        var o = b[1];
        var a = b[2];
        var r = this.Calendar.GetDayOfWeek(b);
        var P = 0;
        var F = 0;
        var x = 0;
        var g, j, L, z, f, J, B, u, R, n, D, P, O, l, I, A;
        var w = new Object();
        if (v.length < 4) {
            var e = v.length;
            for (var C = 0;
            C < 4 - e;
            C++) {
                v = "0" + v;
            }
        }
        var q = v.substring(2, 4);
        var t = 0 + q;
        if (t < 10) {
            w.y = "" + q.substring(1, 2);
        } else {
            w.y = "" + q;
        }
        w.yyyy = v;
        w.yy = q;
        w.M = o;
        w.MM = this.LeadZero(o);
        w.MMM = this.AbbreviatedMonthNames[o - 1];
        w.MMMM = this.MonthNames[o - 1];
        w.d = a;
        w.dd = this.LeadZero(a);
        w.dddd = this.DayNames[r];
        w.ddd = this.AbbreviatedDayNames[r];
        w.H = P;
        w.HH = this.LeadZero(P);
        if (P == 0) {
            w.h = 12;
        } else {
            if (P > 12) {
                w.h = P - 12;
            } else {
                w.h = P;
            }
        }
        w.hh = this.LeadZero(w.h);
        if (P > 11) {
            w.tt = "PM";
            w.t = "P";
        } else {
            w.tt = "AM";
            w.t = "A";
        }
        w.m = F;
        w.mm = this.LeadZero(F);
        w.s = x;
        w.ss = this.LeadZero(x);
        while (Q < N.length) {
            G = N.charAt(Q);
            p = "";
            if (N.charAt(Q) == "'") {
                Q++;
                while ((N.charAt(Q) != "'")) {
                    p += N.charAt(Q);
                    Q++;
                }
                Q++;
                S += p;
                continue;
            }
            while ((N.charAt(Q) == G) && (Q < N.length)) {
                p += N.charAt(Q++);
            }
            if (w[p] != null) {
                S += w[p];
            } else {
                S += p;
            }
        }
        return S;
    }
};
Telerik.Web.UI.Calendar.DateTimeFormatInfo.registerClass("Telerik.Web.UI.Calendar.DateTimeFormatInfo");
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.MonthYearFastNavigation = function (f, e, d, a, b, c) {
    this.MonthNames = f;
    this.MinYear = e;
    this.MaxYear = d;
    this.Skin = a;
    this.CalendarID = b;
    this.TodayButtonCaption = c[0];
    this.OkButtonCaption = c[1];
    this.CancelButtonCaption = c[2];
    this.DateIsOutOfRangeMessage = c[3];
    this.EnableTodayButtonSelection = c[4];
    this.EnableScreenBoundaryDetection = c[5];
    this.ShowAnimationDuration = c[6];
    this.ShowAnimationType = c[7];
    this.HideAnimationDuration = c[8];
    this.HideAnimationType = c[9];
    this.DisableOutOfRangeMonths = c[10];
};
Telerik.Web.UI.Calendar.MonthYearFastNavigation.prototype = {
    CreateLayout: function (l) {
        var h = this;
        var n = this.Month;
        var f = document.createElement("table");
        f.id = this.CalendarID + "_FastNavPopup";
        f.cellSpacing = 0;
        f.className = l[1];
        f.style.cssText = l[0];
        var b = this.MonthNames;
        var a = b.length;
        if (!b[12]) {
            a--;
        }
        var j = Math.ceil(a / 2);
        f.YearRowsCount = j - 1;
        var k = 0;
        var g, d;
        this.YearCells = [];
        this.MonthCells = [];
        for (var m = 0;
        m < j;
        m++) {
            g = f.insertRow(f.rows.length);
            d = this.AddMonthCell(g, k++);
            if (null != d.Month) {
                this.MonthCells[this.MonthCells.length] = d;
            }
            d = this.AddMonthCell(g, k++);
            if (null != d.Month) {
                this.MonthCells[this.MonthCells.length] = d;
            }
            d = g.insertCell(g.cells.length);
            d.unselectable = "on";
            if (m < (j - 1)) {
                this.YearCells[this.YearCells.length] = d;
                var c = document.createElement("a");
                d.appendChild(c);
                c.href = "#";
                c.innerHTML = "&nbsp;";
                c.onclick = function (i) {
                    if (!i) {
                        var i = window.event;
                    }
                    h.SelectYear(this.Year);
                    h._disableOutOfRangeMonths();
                    if (i.preventDefault) {
                        i.preventDefault();
                    }
                    return false;
                };
            } else {
                d.id = "rcMView_PrevY";
                var c = document.createElement("a");
                d.appendChild(c);
                c.href = "#";
                c.innerHTML = "&lt;&lt;";
                this.FastNavPrevYearsLink = c;
                if (h.StartYear >= h.MinYear[0]) {
                    c.onclick = function (i) {
                        if (!i) {
                            var i = window.event;
                        }
                        h.ScrollYears(-10);
                        if (i.preventDefault) {
                            i.preventDefault();
                        }
                        return false;
                    };
                }
            }
            d = g.insertCell(g.cells.length);
            d.unselectable = "on";
            if (m < (j - 1)) {
                this.YearCells[this.YearCells.length] = d;
                var c = document.createElement("a");
                d.appendChild(c);
                c.href = "#";
                c.innerHTML = "&nbsp;";
                c.onclick = function (i) {
                    if (!i) {
                        var i = window.event;
                    }
                    h.SelectYear(this.Year);
                    h._disableOutOfRangeMonths();
                    if (i.preventDefault) {
                        i.preventDefault();
                    }
                    return false;
                };
            } else {
                d.id = "rcMView_NextY";
                var c = document.createElement("a");
                d.appendChild(c);
                c.href = "#";
                c.innerHTML = "&gt;&gt;";
                this.FastNavNextYearsLink = c;
                var e = h.StartYear + 10;
                if (e <= h.MaxYear[0]) {
                    c.onclick = function (i) {
                        if (!i) {
                            var i = window.event;
                        }
                        h.ScrollYears(10);
                        if (i.preventDefault) {
                            i.preventDefault();
                        }
                        return false;
                    };
                }
            }
        }
        g = f.insertRow(f.rows.length);
        d = g.insertCell(g.cells.length);
        d.className = "rcButtons";
        d.colSpan = 4;
        d.noWrap = true;
        this.CreateButton("rcMView_Today", d, this.TodayButtonCaption, Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnToday, this));
        d.appendChild(document.createTextNode(" "));
        this.CreateButton("rcMView_OK", d, this.OkButtonCaption, Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnOK, this));
        d.appendChild(document.createTextNode(" "));
        this.CreateButton("rcMView_Cancel", d, this.CancelButtonCaption, Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnCancel, this));
        return f;
    },
    _appendStylesAndPropertiesToMonthYearView: function (k, p) {
        var n = this;
        k.cellSpacing = 0;
        k.style.cssText = p[0];
        var b = this.MonthNames;
        var a = b.length;
        if (!b[12]) {
            a--;
        }
        var s = Math.ceil(a / 2);
        k.YearRowsCount = s - 1;
        var o = 0;
        var l, f;
        var e;
        var h = k.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
        this.YearCells = [];
        this.MonthCells = [];
        var m = 0;
        for (var q = 0;
        q < s;
        q++) {
            l = h[q];
            e = l.cells.length;
            f = l.cells[e - 4];
            f = this._appendMonthCellProperties(f, m);
            if (null != f.Month) {
                this.MonthCells[this.MonthCells.length] = f;
            }
            f = l.cells[e - 3];
            f = this._appendMonthCellProperties(f, m + 1);
            if (null != f.Month) {
                this.MonthCells[this.MonthCells.length] = f;
            }
            f = l.cells[e - 2];
            this.FastNavPrevYears = f;
            f.unselectable = "on";
            if (q < (s - 1)) {
                this.YearCells[this.YearCells.length] = f;
                var c = f.childNodes[0];
                c.onclick = function (i) {
                    if (!i) {
                        var i = window.event;
                    }
                    var t = n.Year;
                    n.SelectYear(this.Year);
                    n._fireYearSelectedEvent(t, this.parentNode);
                    n._disableOutOfRangeMonths();
                    if (i.preventDefault) {
                        i.preventDefault();
                    }
                    return false;
                };
            } else {
                if (!f.childNodes[0] && !f.childNodes[0].childNodes[0]) {
                    f.id = "rcMView_PrevY";
                }
                var c = f.childNodes[0];
                this.FastNavPrevYearsLink = c;
                if (n.StartYear >= n.MinYear[0]) {
                    c.onclick = function (i) {
                        if (!i) {
                            var i = window.event;
                        }
                        n.ScrollYears(-10);
                        if (i.preventDefault) {
                            i.preventDefault();
                        }
                        return false;
                    };
                }
            }
            f = l.cells[e - 1];
            this.FastNavNextYears = f;
            f.unselectable = "on";
            if (q < (s - 1)) {
                this.YearCells[this.YearCells.length] = f;
                var c = f.childNodes[0];
                c.onclick = function (i) {
                    if (!i) {
                        var i = window.event;
                    }
                    var t = n.Year;
                    n.SelectYear(this.Year);
                    n._fireYearSelectedEvent(t, this.parentNode);
                    n._disableOutOfRangeMonths();
                    if (i.preventDefault) {
                        i.preventDefault();
                    }
                    return false;
                };
            } else {
                if (!f.childNodes[0] && !f.childNodes[0].childNodes[0]) {
                    f.id = "rcMView_NextY";
                }
                var c = f.childNodes[0];
                this.FastNavNextYearsLink = c;
                var j = n.StartYear + 10;
                if (j <= n.MaxYear[0]) {
                    c.onclick = function (i) {
                        if (!i) {
                            var i = window.event;
                        }
                        n.ScrollYears(10);
                        if (i.preventDefault) {
                            i.preventDefault();
                        }
                        return false;
                    };
                }
            }
            m += 2;
        }
        var g = k.rows.length;
        l = k.rows[g - 1];
        f = l.cells[0];
        f.colSpan = 4;
        f.noWrap = true;
        var r = (this.EnableTodayButtonSelection == "False" ? false : true);
        if (r) {
            this._appendButtonProperties(f.childNodes[0], "rcMView_Today", Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnToday, this));
        } else {
            var d = f.childNodes[0];
            d.id = "rcMView_Today";
            d.onclick = "return false;";
        }
        f.appendChild(document.createTextNode(" "));
        this._appendButtonProperties(f.childNodes[1], "rcMView_OK", Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnOK, this));
        f.appendChild(document.createTextNode(" "));
        this._appendButtonProperties(f.childNodes[2], "rcMView_Cancel", Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnCancel, this));
        return k;
    },
    _appendButtonProperties: function (b, a, c) {
        b.id = a;
        if ("function" == typeof (c)) {
            b.onclick = c;
        }
    },
    _disableOutOfRangeMonths: function () {
        var m = (this.DisableOutOfRangeMonths == "False" ? false : true);
        if (!m) {
            return;
        }
        var d = this;
        var c = this.MonthCells.length;
        for (var k = 0;
        k < c;
        k++) {
            var e = this.MonthCells[k];
            e.className = e.className.replace("rcDisabled", "");
            var g = e.childNodes[0];
            if (g.onclick == null) {
                g.onclick = function (j) {
                    if (!j) {
                        var j = window.event;
                    }
                    var i = d.Month;
                    d.SelectMonth(this.Month);
                    var q = d._getMonthYearPicker();
                    if (q) {
                        d._fireMonthSelectedEvent(q, d, i, e);
                    }
                    if (j.preventDefault) {
                        j.preventDefault();
                    }
                    return false;
                };
            }
        }
        var a = this.MinYear[0];
        var n = this.MaxYear[0];
        var f = this.MinYear[1];
        var b = this.MinYear[1] - 1;
        f = f + 1;
        if (a == this.GetYear()) {
            for (var p = 1;
            p < f - 1;
            p++) {
                var e = this.MonthCells[p - 1];
                if (e) {
                    var l = e.childNodes[0];
                    l.onclick = null;
                    e.className = "rcDisabled";
                }
            }
            this.SelectMonth(b);
        }
        b = this.MaxYear[1];
        if (n == this.GetYear()) {
            var o = b;
            for (var h = o + 1;
            h <= c;
            h++) {
                var e = this.MonthCells[h - 1];
                if (e) {
                    var l = e.childNodes[0];
                    l.onclick = null;
                    e.className = "rcDisabled";
                }
            }
            this.SelectMonth(o - 1);
        }
    },
    _isMonthYearPicker: function () {
        return this._getMonthYearPicker();
    },
    CreateButton: function (b, c, a, e) {
        var d = document.createElement("input");
        d.id = b;
        d.type = "button";
        d.value = a;
        if ("function" == typeof (e)) {
            d.onclick = e;
        }
        c.appendChild(d);
        return d;
    },
    FillYears: function () {
        var e = this.StartYear;
        var h = this.YearCells;
        var b = [];
        var f;
        var c = h.length / 2;
        for (var g = 0;
        g < c;
        g++) {
            f = h[g * 2];
            this.SelectCell(f, false);
            f.id = "rcMView_" + e.toString();
            var d = f.getElementsByTagName("a")[0];
            d.href = "#";
            d.innerHTML = e;
            d.Year = e;
            if (d.Year < this.MinYear[0] || d.Year > this.MaxYear[0]) {
                d.onclick = null;
                f.className = "rcDisabled";
            } else {
                f.className = "";
                if (d.onclick == null) {
                    var a = this;
                    d.onclick = function (i) {
                        if (!i) {
                            i = window.event;
                        }
                        var j = a.Year;
                        a.SelectYear(this.Year);
                        a._fireYearSelectedEvent(j, this.parentNode);
                        a._disableOutOfRangeMonths();
                        if (i.preventDefault) {
                            i.preventDefault();
                        }
                        return false;
                    };
                }
            }
            b[e] = f;
            f = h[g * 2 + 1];
            this.SelectCell(f, false);
            f.id = "rcMView_" + (e + c).toString();
            var d = f.getElementsByTagName("a")[0];
            d.href = "#";
            d.innerHTML = e + c;
            d.Year = e + c;
            if (d.Year < this.MinYear[0] || d.Year > this.MaxYear[0]) {
                d.onclick = null;
                f.className = "rcDisabled";
            } else {
                f.className = "";
                if (d.onclick == null) {
                    var a = this;
                    d.onclick = function (i) {
                        if (!i) {
                            i = window.event;
                        }
                        var j = a.Year;
                        a.SelectYear(this.Year);
                        a._fireYearSelectedEvent(j, this.parentNode);
                        a._disableOutOfRangeMonths();
                        if (i.preventDefault) {
                            i.preventDefault();
                        }
                        return false;
                    };
                }
            }
            b[e + c] = f;
            e++;
        }
        this.YearsLookup = b;
    },
    _fireYearSelectedEvent: function (e, b) {
        var c = this._getMonthYearPicker();
        if (c) {
            var a = null;
            var d = null;
            if (e != undefined) {
                a = new Date(e, this.Month, 1);
                d = new Date(this.Year, this.Month, 1);
            } else {
                d = new Date(this.Year, 0, 1);
            }
            c._raiseYearSelected(a, d, b);
        }
    },
    SelectCell: function (b, a) {
        if (b) {
            var c = "rcSelected";
            if (false == a) {
                if (b.className.indexOf("rcDisabled") == -1) {
                    c = "";
                } else {
                    c = b.className.replace("rcSelected", "");
                }
            }
            b.className = c;
        }
    },
    SelectYear: function (a) {
        var c = this.Year;
        var b = this.YearsLookup[a];
        this.Year = a;
        this.SelectCell(this.SelectedYearCell, false);
        this.SelectCell(b, true);
        this.SelectedYearCell = b;
    },
    _getMonthYearPicker: function () {
        var a = $find(this.CalendarID);
        if (a && a.constructor.getName() == "Telerik.Web.UI.RadMonthYearPicker") {
            return a;
        }
        return null;
    },
    SelectMonth: function (c) {
        var a = this.Month;
        var b = this.MonthCells[c];
        this.Month = c;
        this.SelectCell(this.SelectedMonthCell, false);
        this.SelectCell(b, true);
        this.SelectedMonthCell = b;
    },
    ScrollYears: function (b) {
        this.StartYear += b;
        this.FillYears();
        this.SetNavCells();
        var a = this._getMonthYearPicker();
        if (a) {
            a._raiseViewChangedEvent();
        }
        this.SelectYear(this.Year);
    },
    SetNavCells: function () {
        var c = this.StartYear + 10;
        var a = this.FastNavPrevYearsLink;
        var b = this.FastNavNextYearsLink;
        var d = this;
        if (this.StartYear < this.MinYear[0]) {
            a.className = "rcDisabled";
            a.onclick = null;
        } else {
            a.className = "";
            if (a.onclick == null) {
                a.onclick = function () {
                    d.ScrollYears(-10);
                };
            }
        }
        if (c > this.MaxYear[0]) {
            b.className = "rcDisabled";
            b.onclick = null;
        } else {
            b.className = "";
            if (b.onclick == null) {
                b.onclick = function () {
                    d.ScrollYears(10);
                };
            }
        }
    },
    _appendMonthCellProperties: function (c, b) {
        var a = c.childNodes[0];
        c.unselectable = "on";
        var e = this.MonthNames[b];
        if (e) {
            c.id = "rcMView_" + e;
            c.Month = a.Month = b;
            var d = this;
            a.onclick = function (g) {
                if (!g) {
                    var g = window.event;
                }
                var f = d.Month;
                d.SelectMonth(this.Month);
                var h = d._getMonthYearPicker();
                if (h) {
                    d._fireMonthSelectedEvent(h, d, f, c);
                }
                if (g.preventDefault) {
                    g.preventDefault();
                }
                return false;
            };
        }
        return c;
    },
    _fireMonthSelectedEvent: function (f, a, b, d) {
        var e = null;
        var c = null;
        if (b != undefined) {
            e = new Date(a.Year, b, 1);
            c = new Date(a.Year, this.Month, 1);
        } else {
            c = new Date(a.Year, this.Month, 1);
        }
        f._raiseMonthSelected(e, c, d);
    },
    AddMonthCell: function (f, e) {
        var d = f.insertCell(f.cells.length);
        var b = document.createElement("a");
        d.appendChild(b);
        b.href = "#";
        b.innerHTML = "&nbsp;";
        d.unselectable = "on";
        var c = this.MonthNames[e];
        if (c) {
            d.id = "rcMView_" + c;
            b.innerHTML = c;
            d.Month = b.Month = e;
            var a = this;
            b.onclick = function (g) {
                if (!g) {
                    var g = window.event;
                }
                a.SelectMonth(this.Month);
                if (g.preventDefault) {
                    g.preventDefault();
                }
                return false;
            };
        }
        return d;
    },
    GetYear: function () {
        return this.Year;
    },
    GetMonth: function () {
        return this.Month;
    },
    ShowMonthYearView: function (i, j, h, f, g, a, d, b) {
        if (!i) {
            return;
        }
        i.EnableScreenBoundaryDetection = this.EnableScreenBoundaryDetection.toUpperCase() == "FALSE" ? false : true;
        i.ShowAnimationDuration = parseInt(this.ShowAnimationDuration, 10);
        i.ShowAnimationType = parseInt(this.ShowAnimationType, 10);
        i.HideAnimationDuration = parseInt(this.HideAnimationDuration, 10);
        i.HideAnimationType = parseInt(this.HideAnimationType, 10);
        this.Popup = i;
        this.StartYear = g - 4;
        var e = this.DomElement;
        if (!e) {
            var c = $get(b + "_wrapperElement");
            e = this._appendStylesAndPropertiesToMonthYearView(c.childNodes[0], d);
            this.DomElement = e;
        } else {
            this.SetNavCells();
        }
        this.FillYears();
        this.SetNavCells();
        this.SelectYear(g);
        this.SelectMonth(f - 1);
        this._disableOutOfRangeMonths();
        this.ExitFunc = a;
        i.Show(j, h, e, Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnExit, this));
    },
    Show: function (g, h, f, d, e, a, b) {
        if (!g) {
            return;
        }
        g.EnableScreenBoundaryDetection = this.EnableScreenBoundaryDetection.toUpperCase() == "FALSE" ? false : true;
        g.ShowAnimationDuration = parseInt(this.ShowAnimationDuration, 10);
        g.ShowAnimationType = parseInt(this.ShowAnimationType, 10);
        g.HideAnimationDuration = parseInt(this.HideAnimationDuration, 10);
        g.HideAnimationType = parseInt(this.HideAnimationType, 10);
        this.Popup = g;
        this.StartYear = e - 4;
        var c = this.DomElement;
        if (!c) {
            c = this.CreateLayout(b);
            this.DomElement = c;
        } else {
            this.SetNavCells();
        }
        this.FillYears();
        this.SelectYear(e);
        this._disableOutOfRangeMonths();
        this.SelectMonth(d - 1);
        this.ExitFunc = a;
        g.Show(h, f, c, Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnExit, this));
    },
    OnExit: function () {
        if ("function" == typeof (this.ExitFunc)) {
            this.ExitFunc(this.Year, this.Month, this.Date);
            this.Date = null;
        }
    },
    OnToday: function (a) {
        var b = new Date();
        this.Date = b.getDate();
        this.Month = b.getMonth();
        this.Year = b.getFullYear();
        this.Popup.Hide(true);
    },
    OnOK: function (a) {
        this.Popup.Hide(true);
    },
    OnCancel: function (a) {
        this.Popup.Hide();
    },
    dispose: function () {
        if (this.DomElement) {
            var a = this.DomElement.getElementsByTagName("a");
            for (var b = 0;
            b < a.length;
            b++) {
                a[b].onclick = null;
            }
            this.DomElement = null;
        }
    }
};
Telerik.Web.UI.Calendar.MonthYearFastNavigation.registerClass("Telerik.Web.UI.Calendar.MonthYearFastNavigation", null, Sys.IDisposable);
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.Selector = function (b, d, f, a, c, e) {
    this.SelectorType = b;
    this.RadCalendar = a;
    this.RadCalendarView = c;
    this.DomElement = e;
    this.IsSelected = false;
    this.RowIndex = d;
    this.ColIndex = f;
    var g = this;
};
Telerik.Web.UI.Calendar.Selector.prototype = {
    Dispose: function () {
        this.disposed = true;
        this.DomElement = null;
        this.RadCalendar = null;
        this.RadCalendarView = null;
    },
    MouseOver: function () {
        var d = document.getElementById(this.RadCalendarView.ID);
        switch (this.SelectorType) {
            case Telerik.Web.UI.Calendar.Utils.COLUMN_HEADER:
                for (var b = 0;
                b < this.RadCalendarView.Rows;
                b++) {
                    var a = d.rows[this.RowIndex + b].cells[this.ColIndex].DayId;
                    var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                    var e = this.RadCalendarView.RenderDays.Get(f);
                    if (e) {
                        e.MouseOver();
                    }
                }
                break;
            case Telerik.Web.UI.Calendar.Utils.VIEW_HEADER:
                for (var b = 0;
                b < this.RadCalendarView.Rows;
                b++) {
                    for (var c = 0;
                    c < this.RadCalendarView.Cols;
                    c++) {
                        var a = d.rows[this.RowIndex + b].cells[this.ColIndex + c].DayId;
                        var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                        var e = this.RadCalendarView.RenderDays.Get(f);
                        if (e) {
                            e.MouseOver();
                        }
                    }
                }
                break;
            case Telerik.Web.UI.Calendar.Utils.ROW_HEADER:
                for (var b = 0;
                b < this.RadCalendarView.Cols;
                b++) {
                    var a = d.rows[this.RowIndex].cells[this.ColIndex + b].DayId;
                    var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                    var e = this.RadCalendarView.RenderDays.Get(f);
                    if (e) {
                        e.MouseOver();
                    }
                }
                break;
        }
    },
    MouseOut: function () {
        var d = document.getElementById(this.RadCalendarView.ID);
        switch (this.SelectorType) {
            case Telerik.Web.UI.Calendar.Utils.COLUMN_HEADER:
                for (var b = 0;
                b < this.RadCalendarView.Rows;
                b++) {
                    var a = d.rows[this.RowIndex + b].cells[this.ColIndex].DayId;
                    var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                    var e = this.RadCalendarView.RenderDays.Get(f);
                    if (e) {
                        e.MouseOut();
                    }
                }
                break;
            case Telerik.Web.UI.Calendar.Utils.VIEW_HEADER:
                for (var b = 0;
                b < this.RadCalendarView.Rows;
                b++) {
                    for (var c = 0;
                    c < this.RadCalendarView.Cols;
                    c++) {
                        var a = d.rows[this.RowIndex + b].cells[this.ColIndex + c].DayId;
                        var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                        var e = this.RadCalendarView.RenderDays.Get(f);
                        if (e) {
                            e.MouseOut();
                        }
                    }
                }
                break;
            case Telerik.Web.UI.Calendar.Utils.ROW_HEADER:
                for (var b = 0;
                b < this.RadCalendarView.Cols;
                b++) {
                    var a = d.rows[this.RowIndex].cells[this.ColIndex + b].DayId;
                    var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                    var e = this.RadCalendarView.RenderDays.Get(f);
                    if (e) {
                        e.MouseOut();
                    }
                }
                break;
        }
    },
    _removeRangeSelection: function () {
        var a = this.RadCalendar;
        if (a._rangeSelectionMode != Telerik.Web.UI.Calendar.RangeSelectionMode.None) {
            a._removeRangeSelection();
            a._serializeRangeSelectionDates();
        }
    },
    Click: function () {
        switch (this.SelectorType) {
            case Telerik.Web.UI.Calendar.Utils.COLUMN_HEADER:
                var b = new Telerik.Web.UI.CalendarClickEventArgs(this.DomElement, this.ColIndex);
                this._removeRangeSelection();
                this.RadCalendar.raise_columnHeaderClick(b);
                if (b.get_cancel() == true) {
                    return;
                }
                break;
            case Telerik.Web.UI.Calendar.Utils.ROW_HEADER:
                var b = new Telerik.Web.UI.CalendarClickEventArgs(this.DomElement, this.RowIndex);
                this._removeRangeSelection();
                this.RadCalendar.raise_rowHeaderClick(b);
                if (b.get_cancel() == true) {
                    return;
                }
                break;
            case Telerik.Web.UI.Calendar.Utils.VIEW_HEADER:
                var b = new Telerik.Web.UI.CalendarClickEventArgs(this.DomElement, -1);
                this._removeRangeSelection();
                this.RadCalendar.raise_viewSelectorClick(b);
                if (b.get_cancel() == true) {
                    return;
                }
                break;
        }
        if (this.RadCalendar.get_enableMultiSelect()) {
            var d = document.getElementById(this.RadCalendarView.ID);
            this.IsSelected = true;
            switch (this.SelectorType) {
                case Telerik.Web.UI.Calendar.Utils.COLUMN_HEADER:
                    for (var c = 0;
                    c < this.RadCalendarView.Rows;
                    c++) {
                        var a = d.rows[this.RowIndex + c].cells[this.ColIndex].DayId;
                        var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                        var e = this.RadCalendarView.RenderDays.Get(f);
                        if (!e) {
                            continue;
                        }
                        if (e.IsSelected == false) {
                            this.IsSelected = !this.IsSelected;
                            break;
                        }
                    }
                    for (var g = 0;
                    g < this.RadCalendarView.Rows;
                    g++) {
                        var a = d.rows[this.RowIndex + g].cells[this.ColIndex].DayId;
                        var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                        var e = this.RadCalendarView.RenderDays.Get(f);
                        if (!e) {
                            continue;
                        }
                        if (this.IsSelected) {
                            if (e.IsSelected) {
                                e.Select(false, true);
                            }
                        } else {
                            if (!e.IsSelected) {
                                e.Select(true, true);
                            }
                        }
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.VIEW_HEADER:
                    for (var g = 0;
                    g < this.RadCalendarView.Rows;
                    g++) {
                        for (var c = 0;
                        c < this.RadCalendarView.Cols;
                        c++) {
                            var a = d.rows[this.RowIndex + g].cells[this.ColIndex + c].DayId;
                            var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                            var e = this.RadCalendarView.RenderDays.Get(f);
                            if (!e) {
                                continue;
                            }
                            if (e.IsSelected == false) {
                                this.IsSelected = !this.IsSelected;
                                break;
                            }
                        }
                        if (this.IsSelected == false) {
                            break;
                        }
                    }
                    for (var g = 0;
                    g < this.RadCalendarView.Rows;
                    g++) {
                        for (var c = 0;
                        c < this.RadCalendarView.Cols;
                        c++) {
                            var a = d.rows[this.RowIndex + g].cells[this.ColIndex + c].DayId;
                            var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                            var e = this.RadCalendarView.RenderDays.Get(f);
                            if (!e) {
                                continue;
                            }
                            if (this.IsSelected) {
                                if (e.IsSelected) {
                                    e.Select(false, true);
                                }
                            } else {
                                if (!e.IsSelected) {
                                    e.Select(true, true);
                                }
                            }
                        }
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.ROW_HEADER:
                    for (var c = 0;
                    c < this.RadCalendarView.Cols;
                    c++) {
                        var a = d.rows[this.RowIndex].cells[this.ColIndex + c].DayId;
                        var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                        var e = this.RadCalendarView.RenderDays.Get(f);
                        if (!e) {
                            continue;
                        }
                        if (e.IsSelected == false) {
                            this.IsSelected = !this.IsSelected;
                            break;
                        }
                    }
                    for (var g = 0;
                    g < this.RadCalendarView.Cols;
                    g++) {
                        var a = d.rows[this.RowIndex].cells[this.ColIndex + g].DayId;
                        var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
                        var e = this.RadCalendarView.RenderDays.Get(f);
                        if (!e) {
                            continue;
                        }
                        if (this.IsSelected) {
                            if (e.IsSelected) {
                                e.Select(false, true);
                            }
                        } else {
                            if (!e.IsSelected) {
                                e.Select(true, true);
                            }
                        }
                    }
                    break;
            }
            this.RadCalendar._serializeSelectedDates();
            this.RadCalendar._submit("d");
        }
    }
};
Telerik.Web.UI.Calendar.Selector.registerClass("Telerik.Web.UI.Calendar.Selector");
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.RangeValidation = function (a, b) {
    this._rangeMinDate = a;
    this._rangeMaxDate = b;
};
Telerik.Web.UI.Calendar.RangeValidation.prototype = {
    IsDateValid: function (a) {
        return (this.CompareDates(this._rangeMinDate, a) <= 0 && this.CompareDates(a, this._rangeMaxDate) <= 0);
    },
    CompareDates: function (e, c) {
        if (!e || e.length != 3) {
            throw new Error("Date1 must be array: [y, m, d]");
        }
        if (!c || c.length != 3) {
            throw new Error("Date2 must be array: [y, m, d]");
        }
        var a = e[0];
        var g = c[0];
        if (a < g) {
            return -1;
        }
        if (a > g) {
            return 1;
        }
        var b = e[1];
        var h = c[1];
        if (b < h) {
            return -1;
        }
        if (b > h) {
            return 1;
        }
        var f = e[2];
        var d = c[2];
        if (f < d) {
            return -1;
        }
        if (f > d) {
            return 1;
        }
        return 0;
    },
    InSameMonth: function (b, a) {
        return ((b[0] == a[0]) && (b[1] == a[1]));
    }
};
Telerik.Web.UI.Calendar.RangeValidation.registerClass("Telerik.Web.UI.Calendar.RangeValidation");
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.Selection = function (a, d, c, b) {
    this._specialDays = d;
    this._recurringDays = c;
    this._enableMultiSelect = b;
    this._selectedDates = new Telerik.Web.UI.Calendar.DateCollection();
    this._rangeValidation = a;
};
Telerik.Web.UI.Calendar.Selection.prototype = {
    CanSelect: function (a) {
        if (!this._rangeValidation.IsDateValid(a)) {
            return false;
        }
        var c = this._specialDays.Get(a);
        if (c != null) {
            return c.IsSelectable != 0;
        } else {
            var b = this._recurringDays.Get(a);
            if (b != null) {
                return b.IsSelectable != 0;
            } else {
                return true;
            }
        }
    },
    Add: function (a) {
        if (!this.CanSelect(a)) {
            return;
        }
        if (!this._enableMultiSelect) {
            this._selectedDates.Clear();
        }
        this._selectedDates.Add(a, a);
    },
    Remove: function (a) {
        this._selectedDates.Remove(a);
    }
};
Telerik.Web.UI.Calendar.Selection.registerClass("Telerik.Web.UI.Calendar.Selection");
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.GregorianCalendar = {
    DatePartDay: 3,
    DatePartDayOfYear: 1,
    DatePartMonth: 2,
    DatePartYear: 0,
    DaysPer100Years: 36524,
    DaysPer400Years: 146097,
    DaysPer4Years: 1461,
    DaysPerYear: 365,
    DaysTo10000: 3652059,
    DaysToMonth365: [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365],
    DaysToMonth366: [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366],
    MaxMillis: 315537897600000,
    MillisPerDay: 86400000,
    MillisPerHour: 3600000,
    MillisPerMinute: 60000,
    MillisPerSecond: 1000,
    TicksPerDay: 864000000000,
    TicksPerHour: 36000000000,
    TicksPerMillisecond: 10000,
    TicksPerMinute: 600000000,
    TicksPerSecond: 10000000,
    MaxYear: 9999,
    GetDateFromArguments: function () {
        var a, c, b;
        switch (arguments.length) {
            case 1:
                var b = arguments[0];
                if ("object" != typeof (b)) {
                    throw new Error("Unsupported input format");
                }
                if (b.getDate) {
                    a = b.getFullYear();
                    c = b.getMonth() + 1;
                    b = b.getDate();
                } else {
                    if (3 == b.length) {
                        a = b[0];
                        c = b[1];
                        b = b[2];
                    } else {
                        throw new Error("Unsupported input format");
                    }
                }
                break;
            case 3:
                a = arguments[0];
                c = arguments[1];
                b = arguments[2];
                break;
            default:
                throw new Error("Unsupported input format");
                break;
        }
        a = parseInt(a);
        if (isNaN(a)) {
            throw new Error("Invalid YEAR");
        }
        c = parseInt(c);
        if (isNaN(c)) {
            throw new Error("Invalid MONTH");
        }
        b = parseInt(b);
        if (isNaN(b)) {
            throw new Error("Invalid DATE");
        }
        return [a, c, b];
    },
    DateToTicks: function () {
        var b = this.GetDateFromArguments.apply(null, arguments);
        var a = b[0];
        var d = b[1];
        var c = b[2];
        return (this.GetAbsoluteDate(a, d, c) * this.TicksPerDay);
    },
    TicksToDate: function (c) {
        var b = this.GetDatePart(c, 0);
        var a = this.GetDatePart(c, 2);
        var e = this.GetDatePart(c, 3);
        return [b, a, e];
    },
    GetAbsoluteDate: function (f, d, h) {
        if (f < 1 || f > this.MaxYear + 1) {
            throw new Error("Year is out of range [1..9999].");
        }
        if (d < 1 || d > 12) {
            throw new Error("Month is out of range [1..12].");
        }
        var e = ((f % 4 == 0) && ((f % 100 != 0) || (f % 400 == 0)));
        var b = e ? this.DaysToMonth366 : this.DaysToMonth365;
        var c = b[d] - b[d - 1];
        if (h < 1 || h > c) {
            throw new Error("Day is out of range for the current month.");
        }
        var g = f - 1;
        var a = g * this.DaysPerYear + this.GetInt(g / 4) - this.GetInt(g / 100) + this.GetInt(g / 400) + b[d - 1] + h - 1;
        return a;
    },
    GetDatePart: function (c, e) {
        var i = this.GetInt(c / this.TicksPerDay);
        var a = this.GetInt(i / this.DaysPer400Years);
        i -= this.GetInt(a * this.DaysPer400Years);
        var d = this.GetInt(i / this.DaysPer100Years);
        if (d == 4) {
            d = 3;
        }
        i -= this.GetInt(d * this.DaysPer100Years);
        var j = this.GetInt(i / this.DaysPer4Years);
        i -= this.GetInt(j * this.DaysPer4Years);
        var b = this.GetInt(i / this.DaysPerYear);
        if (b == 4) {
            b = 3;
        }
        if (e == 0) {
            return (((((a * 400) + (d * 100)) + (j * 4)) + b) + 1);
        }
        i -= this.GetInt(b * 365);
        if (e == 1) {
            return (i + 1);
        }
        var f = (b == 3) && ((j != 24) || (d == 3));
        var g = f ? this.DaysToMonth366 : this.DaysToMonth365;
        var h = i >> 6;
        while (i >= g[h]) {
            h++;
        }
        if (e == 2) {
            return h;
        }
        return ((i - g[h - 1]) + 1);
    },
    GetDayOfMonth: function (a) {
        return (this.GetDatePart(this.DateToTicks(a), 3) + 1);
    },
    GetDayOfWeek: function (a) {
        var b = this.DateToTicks(a);
        var c = (b / 864000000000) + 1;
        return this.GetInt(c % 7);
    },
    AddMonths: function (h, c) {
        var f = this.DateToTicks(h);
        var d = this.GetInt(this.GetDatePart(f, 0));
        var a = this.GetInt(this.GetDatePart(f, 2));
        var i = this.GetInt(this.GetDatePart(f, 3));
        var j = this.GetInt((a - 1) + c);
        if (j >= 0) {
            a = this.GetInt((j % 12) + 1);
            d += this.GetInt((j / 12));
        } else {
            a = this.GetInt(12 + ((j + 1) % 12));
            d += this.GetInt((j - 11) / 12);
        }
        var e = (((d % 4) == 0) && (((d % 100) != 0) || ((d % 400) == 0))) ? this.DaysToMonth366 : this.DaysToMonth365;
        var b = e[a] - e[a - 1];
        if (i > b) {
            i = b;
        }
        var g = this.GetInt(this.DateToTicks(d, a, i) + (f % 864000000000));
        return ([this.GetDatePart(g, 0), this.GetDatePart(g, 2), this.GetDatePart(g, 3)]);
    },
    AddYears: function (b, a) {
        return this.AddMonths(b, a * 12);
    },
    AddDays: function (b, a) {
        return this.Add(b, a, this.MillisPerDay);
    },
    Add: function (e, d, b) {
        var c = this.DateToTicks(e);
        var a = this.GetInt(d * b * this.TicksPerMillisecond);
        var f = this.GetInt(c + a);
        if (f < 0) {
            f = 0;
        }
        return this.TicksToDate(f);
    },
    GetWeekOfYear: function (b, a, c) {
        switch (a) {
            case Telerik.Web.UI.Calendar.Utils.FIRST_DAY:
                return this.GetInt(this.GetFirstDayWeekOfYear(b, c));
            case Telerik.Web.UI.Calendar.Utils.FIRST_FULL_WEEK:
                return this.GetInt(this.InternalGetWeekOfYearFullDays(b, c, 7, 365));
            case Telerik.Web.UI.Calendar.Utils.FIRST_FOUR_DAY_WEEK:
                return this.GetInt(this.InternalGetWeekOfYearFullDays(b, c, 4, 365));
        }
    },
    InternalGetWeekOfYearFullDays: function (a, e, f, g) {
        var b = this.GetDayOfYear(a) - 1;
        var d = ((this.GetDayOfWeek(a)) - (b % 7));
        var i = ((e - d) + 14) % 7;
        if ((i != 0) && (i >= f)) {
            i -= 7;
        }
        var h = b - i;
        if (h >= 0) {
            return ((h / 7) + 1);
        }
        var c = this.GetYear(a);
        b = this.GetDaysInYear(c - 1);
        d -= (b % 7);
        i = ((e - d) + 14) % 7;
        if ((i != 0) && (i >= f)) {
            i -= 7;
        }
        h = b - i;
        return ((h / 7) + 1);
    },
    GetFirstDayWeekOfYear: function (a, e) {
        var b = this.GetDayOfYear(a) - 1;
        var d = (this.GetDayOfWeek(a)) - (b % 7);
        var c = ((d - e) + 14) % 7;
        return (((b + c) / 7) + 1);
    },
    GetLeapMonth: function (a) {
        var a = this.GetGregorianYear(a);
        return 0;
    },
    GetMonth: function (a) {
        return this.GetDatePart(this.DateToTicks(a), 2);
    },
    GetMonthsInYear: function (a) {
        var a = this.GetGregorianYear(a);
        return 12;
    },
    GetDaysInMonth: function (a, c) {
        var a = this.GetGregorianYear(a);
        var b = (((a % 4) == 0) && (((a % 100) != 0) || ((a % 400) == 0))) ? this.DaysToMonth366 : this.DaysToMonth365;
        return (b[c] - b[c - 1]);
    },
    GetDaysInYear: function (a) {
        var a = this.GetGregorianYear(a);
        if (((a % 4) == 0) && (((a % 100) != 0) || ((a % 400) == 0))) {
            return 366;
        }
        return 365;
    },
    GetDayOfYear: function (a) {
        return this.GetInt(this.GetDatePart(this.DateToTicks(a), 1));
    },
    GetGregorianYear: function (a) {
        return a;
    },
    GetYear: function (a) {
        var b = this.DateToTicks(a);
        var c = this.GetDatePart(b, 0);
        return (c);
    },
    IsLeapDay: function (b) {
        var a = b.getFullYear();
        var d = b.getMonth();
        var c = b.getDate();
        if (this.IsLeapYear(b) && ((d == 2) && (c == 29))) {
            return true;
        }
        return false;
    },
    IsLeapMonth: function (b) {
        var a = b.getFullYear();
        var c = b.getMonth();
        if (this.IsLeapYear(b)) {
            if (c == 2) {
                return true;
            }
        }
        return false;
    },
    IsLeapYear: function (b) {
        var a = b.getFullYear();
        if ((a % 4) != 0) {
            return false;
        }
        if ((a % 100) == 0) {
            return ((a % 400) == 0);
        }
        return true;
    },
    GetInt: function (a) {
        if (a > 0) {
            return Math.floor(a);
        } else {
            return Math.ceil(a);
        }
    }
};
Telerik.Web.UI.Calendar.PersianCalendar = {
    DatePartDay: 3,
    DatePartDayOfYear: 1,
    DatePartMonth: 2,
    DatePartYear: 0,
    DaysPer100Years: 36524,
    DaysPer400Years: 146097,
    DaysPer4Years: 1461,
    DaysPerYear: 365,
    DaysTo10000: 3652059,
    DaysToMonth365: [0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336, 365],
    DaysToMonth366: [0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336, 366],
    LeapYears33: [0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0],
    MaxMillis: 315537897600000,
    MillisPerDay: 86400000,
    MillisPerHour: 3600000,
    MillisPerMinute: 60000,
    MillisPerSecond: 1000,
    TicksPerDay: 864000000000,
    TicksPerHour: 36000000000,
    TicksPerMillisecond: 10000,
    TicksPerMinute: 600000000,
    TicksPerSecond: 10000000,
    MaxYear: 9378,
    GetDateFromArguments: function () {
        var a, c, b;
        switch (arguments.length) {
            case 1:
                var b = arguments[0];
                if ("object" != typeof (b)) {
                    throw new Error("Unsupported input format");
                }
                if (b.getDate) {
                    a = b.getFullYear();
                    c = b.getMonth() + 1;
                    b = b.getDate();
                } else {
                    if (3 == b.length) {
                        a = b[0];
                        c = b[1];
                        b = b[2];
                    } else {
                        throw new Error("Unsupported input format");
                    }
                }
                break;
            case 3:
                a = arguments[0];
                c = arguments[1];
                b = arguments[2];
                break;
            default:
                throw new Error("Unsupported input format");
                break;
        }
        a = parseInt(a);
        if (isNaN(a)) {
            throw new Error("Invalid YEAR");
        }
        c = parseInt(c);
        if (isNaN(c)) {
            throw new Error("Invalid MONTH");
        }
        b = parseInt(b);
        if (isNaN(b)) {
            throw new Error("Invalid DATE");
        }
        return [a, c, b];
    },
    DateToTicks: function () {
        var b = this.GetDateFromArguments.apply(null, arguments);
        var a = b[0];
        var d = b[1];
        var c = b[2];
        return (this.GetAbsoluteDate(a, d, c) * this.TicksPerDay);
    },
    TicksToDate: function (c) {
        var b = this.GetDatePart(c, 0);
        var a = this.GetDatePart(c, 2);
        var e = this.GetDatePart(c, 3);
        return [b, a, e];
    },
    DaysUpToPersianYear: function (PersianYear) {
        var num2 = this.GetInt((PersianYear - 1) / 33);
        var year = this.GetInt((PersianYear - 1) % 33);
        var num = this.GetInt((num2 * 12053)) + 226894;
        while (year > 0) {
            num += 365;
            if (this.IsLeapYear(year, 0)) {
                num += 1;
            }
            year--;
        }
        return num;
    },
    GetAbsoluteDate: function (year, month, day) {
        if (year < 1 || year > this.MaxYear + 1) {
            throw new Error("Year is out of range [1..9999].");
        }
        if (month < 1 || month > 12) {
            throw new Error("Month is out of range [1..12].");
        }

        //var e = ((f % 4 == 0) && ((f % 100 != 0) || (f % 400 == 0)));
        //var b = e ? this.DaysToMonth366 : this.DaysToMonth365;
        //var c = b[d] - b[d - 1];
        //if (h < 1 || h > c) {
        //    throw new Error("Day is out of range for the current month.");
        //}
        //var g = f - 1;
        //var a = g * this.DaysPerYear + this.GetInt(g / 4) - this.GetInt(g / 100) + this.GetInt(g / 400) + b[d - 1] + h - 1;
        //return a;

        return (((this.DaysUpToPersianYear(year) + this.DaysToMonth365[month - 1]) + day) - 1);
    },
    GetAbsoluteDate2: function (f, d, h) {
        if (f < 1 || f > this.MaxYear + 1) {
            throw new Error("Year is out of range [1..9999].");
        }
        if (d < 1 || d > 12) {
            throw new Error("Month is out of range [1..12].");
        }
        var e = ((f % 4 == 0) && ((f % 100 != 0) || (f % 400 == 0)));
        var b = e ? this.DaysToMonth366 : this.DaysToMonth365;
        var c = b[d] - b[d - 1];
        if (h < 1 || h > c) {
            throw new Error("Day is out of range for the current month.");
        }
        var g = f - 1;
        var a = g * this.DaysPerYear + this.GetInt(g / 4) - this.GetInt(g / 100) + this.GetInt(g / 400) + b[d - 1] + h - 1;
        return a;
    },
    GetDatePart: function (ticks, part) {
        //var i = this.GetInt(ticks / this.TicksPerDay);
        //var a = this.GetInt(i / this.DaysPer400Years);
        //i -= this.GetInt(a * this.DaysPer400Years);
        //var d = this.GetInt(i / this.DaysPer100Years);
        ////if (d == 4) {
        ////    d = 3;
        ////}
        //i -= this.GetInt(d * this.DaysPer100Years);
        //var j = this.GetInt(i / this.DaysPer4Years);
        //i -= this.GetInt(j * this.DaysPer4Years);
        //var b = this.GetInt(i / this.DaysPerYear);
        //if (b == 4) {
        //    b = 3;
        //}
        //if (e == 0) {
        //    return (((((a * 400) + (d * 100)) + (j * 4)) + b) + 1);
        //}
        //i -= this.GetInt(b * 365);
        //if (e == 1) {
        //    return (i + 1);
        //}
        //var f = (b == 3) && ((j != 24) || (d == 3));
        //var g = f ? this.DaysToMonth366 : this.DaysToMonth365;
        //var h = i >> 6;
        //while (i >= g[h]) {
        //    h++;
        //}
        //if (e == 2) {
        //    return h;
        //}
        //return ((i - g[h - 1]) + 1);


        // mydnn begin persian date

        var num4 = this.GetInt(ticks / 864000000000) + 1;
        var persianYear = (this.GetInt((((num4 - 226894) * 33) / 12053))) + 1;
        var num5 = this.DaysUpToPersianYear(persianYear);
        var daysInYear = this.GetDaysInYear(persianYear);
        if (num4 < num5) {
            num5 -= daysInYear;
            persianYear--;
        }
        else if (num4 == num5) {
            persianYear--;
            num5 -= this.GetDaysInYear(persianYear, 0);
        }
        else if (num4 > (num5 + daysInYear)) {
            num5 += daysInYear;
            persianYear++;
        }
        if (part == 0) {
            return persianYear;
        }
        num4 -= num5;
        if (part == 1) {
            return this.GetInt(num4);
        }
        var index = 0;
        while ((index < 12) && (num4 > this.DaysToMonth365[index])) {
            index++;
        }
        if (part == 2) {
            return index;
        }
        var num3 = this.GetInt(num4) - this.DaysToMonth365[index - 1];
        if (part != 3) {
            //throw new InvalidOperationException(Environment.GetResourceString("InvalidOperation_DateTimeParsing"));
        }
        return num3;

    },
    GetDayOfMonth: function (a) {
        //return (this.GetDatePart(this.DateToTicks(a), 3) + 1);

        //mydnn
        return (this.GetDatePart(this.DateToTicks(a), 3));
    },
    GetDayOfWeek: function (a) {
        var b = this.DateToTicks(a);
        var c = (b / 864000000000) + 1;
        return this.GetInt(c % 7);
    },
    AddMonths: function (time, months) {
        //var f = this.DateToTicks(h);
        //var d = this.GetInt(this.GetDatePart(f, 0));
        //var a = this.GetInt(this.GetDatePart(f, 2));
        //var i = this.GetInt(this.GetDatePart(f, 3));
        //var j = this.GetInt((a - 1) + c);
        //if (j >= 0) {
        //    a = this.GetInt((j % 12) + 1);
        //    d += this.GetInt((j / 12));
        //} else {
        //    a = this.GetInt(12 + ((j + 1) % 12));
        //    d += this.GetInt((j - 11) / 12);
        //}
        //var e = (((d % 4) == 0) && (((d % 100) != 0) || ((d % 400) == 0))) ? this.DaysToMonth366 : this.DaysToMonth365;
        //var b = e[a] - e[a - 1];
        //if (i > b) {
        //    i = b;
        //}
        //var g = this.GetInt(this.DateToTicks(d, a, i) + (f % 864000000000));
        //return ([this.GetDatePart(g, 0), this.GetDatePart(g, 2), this.GetDatePart(g, 3)]);

        //mydnn
        if ((months < -120000) || (months > 120000)) {
            //throw new ArgumentOutOfRangeException("months", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("ArgumentOutOfRange_Range"), new object[] { -120000, 0x1d4c0 }));
        }
        var datePart = this.GetInt(this.GetDatePart((this.GetAbsoluteDate(time[0], time[1], time[2]) * this.TicksPerDay), 0));
        var month = this.GetInt(this.GetDatePart((this.GetAbsoluteDate(time[0], time[1], time[2]) * this.TicksPerDay), 2));
        var day = this.GetInt(this.GetDatePart((this.GetAbsoluteDate(time[0], time[1], time[2]) * this.TicksPerDay), 3));
        var num4 = (month - 1) + months;
        if (num4 >= 0) {
            month = this.GetInt((num4 % 12)) + 1;
            datePart += this.GetInt(num4 / 12);
        }
        else {
            month = 12 + this.GetInt(((num4 + 1) % 12));
            datePart += this.GetInt((num4 - 11) / 12);
        }
        var daysInMonth = this.GetDaysInMonth(datePart, month);
        if (day > daysInMonth) {
            day = daysInMonth;
        }
        var ticks = (this.GetAbsoluteDate(datePart, month, day) * 864000000000) + ((this.GetAbsoluteDate(time[0], time[1], time[2]) * this.TicksPerDay) % 864000000000);
        return ([this.GetDatePart(ticks, 0), this.GetDatePart(ticks, 2), this.GetDatePart(ticks, 3)]);

    },
    AddYears: function (b, a) {
        return this.AddMonths(b, a * 12);
    },
    AddDays: function (b, a) {
        return this.Add(b, a, this.MillisPerDay);
    },
    Add: function (e, d, b) {
        var c = this.DateToTicks(e);
        var a = this.GetInt(d * b * this.TicksPerMillisecond);
        var f = this.GetInt(c + a);
        if (f < 0) {
            f = 0;
        }
        return this.TicksToDate(f);
    },
    GetWeekOfYear: function (b, a, c) {
        switch (a) {
            case Telerik.Web.UI.Calendar.Utils.FIRST_DAY:
                return this.GetInt(this.GetFirstDayWeekOfYear(b, c));
            case Telerik.Web.UI.Calendar.Utils.FIRST_FULL_WEEK:
                return this.GetInt(this.InternalGetWeekOfYearFullDays(b, c, 7, 365));
            case Telerik.Web.UI.Calendar.Utils.FIRST_FOUR_DAY_WEEK:
                return this.GetInt(this.InternalGetWeekOfYearFullDays(b, c, 4, 365));
        }
    },
    InternalGetWeekOfYearFullDays: function (a, e, f, g) {
        var b = this.GetDayOfYear(a) - 1;
        var d = ((this.GetDayOfWeek(a)) - (b % 7));
        var i = ((e - d) + 14) % 7;
        if ((i != 0) && (i >= f)) {
            i -= 7;
        }
        var h = b - i;
        if (h >= 0) {
            return ((h / 7) + 1);
        }
        var c = this.GetYear(a);
        b = this.GetDaysInYear(c - 1);
        d -= (b % 7);
        i = ((e - d) + 14) % 7;
        if ((i != 0) && (i >= f)) {
            i -= 7;
        }
        h = b - i;
        return ((h / 7) + 1);
    },
    GetFirstDayWeekOfYear: function (a, e) {
        var b = this.GetDayOfYear(a) - 1;
        var d = (this.GetDayOfWeek(a)) - (b % 7);
        var c = ((d - e) + 14) % 7;
        return (((b + c) / 7) + 1);
    },
    GetLeapMonth: function (a) {
        var a = this.GetGregorianYear(a);
        return 0;
    },
    GetMonth: function (a) {
        return this.GetDatePart(this.DateToTicks(a), 2);
    },
    GetMonthsInYear: function (a) {
        var a = this.GetGregorianYear(a);
        return 12;
    },
    GetDaysInMonth: function (year, month) {
        //var a = this.GetGregorianYear(a);
        //var b = (((a % 4) == 0) && (((a % 100) != 0) || ((a % 400) == 0))) ? this.DaysToMonth366 : this.DaysToMonth365;
        //return (b[c] - b[c - 1]);

        //mydnn
        if ((month == 10) && (year == 9378)) {
            return 10;
        }
        if (month == 12) {
            if (!this.IsLeapYear(year, 0)) {
                return 29;
            }
            return 30;
        }
        if (month <= 6) {
            return 31;
        }
        return 30;
    },
    GetDaysInYear: function (year) {
        //var a = this.GetGregorianYear(a);
        //if (((a % 4) == 0) && (((a % 100) != 0) || ((a % 400) == 0))) {
        //    return 366;
        //}
        //return 365;

        //mydnn
        if (year == 9378) {
            return (this.DaysToMonth365[9] + 10);
        }
        if (!this.IsLeapYear(year, 0)) {
            return 365;
        }
        return 366;
    },
    GetDayOfYear: function (a) {
        return this.GetInt(this.GetDatePart(this.DateToTicks(a), 1));
    },
    GetGregorianYear: function (a) {
        return a;
    },
    GetYear: function (a) {
        var b = this.DateToTicks(a);
        var c = this.GetDatePart(b, 0);
        return (c);
    },
    CheckYearRange: function (year) {
        if ((year < 1) || (year > 9378)) {
            return true;
        }
        return false;
    },
    CheckYearMonthRange: function (year, month) {
        this.CheckYearRange(year);
        if ((year == 9378) && (month > 10)) {
            return true;
        }
        if ((month < 1) || (month > 12)) {
            return true;
        }
        return false;
    },
    IsLeapDay: function (b) {
        //var a = b.getFullYear();
        //var d = b.getMonth();
        //var c = b.getDate();
        //if (this.IsLeapYear(b) && ((d == 2) && (c == 29))) {
        //    return true;
        //}
        //return false;

        //mydnn
        var year = b.getFullYear();
        var month = b.getMonth();
        var day = b.getDate();

        var num = this.GetDaysInMonth(year, month);
        if ((day < 1) || (day > num)) {
            return true;
        }
        return ((this.IsLeapYear(year) && (month == 12)) && (day == 30));

    },
    IsLeapMonth: function (b) {
        //var a = b.getFullYear();
        //var c = b.getMonth();
        //if (this.IsLeapYear(b)) {
        //    if (c == 2) {
        //        return true;
        //    }
        //}
        //return false;

        //mydnn
        var year = b.getFullYear();
        var month = b.getMonth();
        if (this.CheckYearMonthRange(year, month))
            return true;
        return false;

    },
    IsLeapYear: function (b) {
        //var a = b.getFullYear();
        //if ((a % 4) != 0) {
        //    return false;
        //}
        //if ((a % 100) == 0) {
        //    return ((a % 400) == 0);
        //}
        //return true;

        //mydnn
        var year = b;
        if (this.CheckYearRange(year))
            return true;
        return (this.LeapYears33[year % 33] == 1);
    },
    GetInt: function (a) {
        if (a > 0) {
            return Math.floor(a);
        } else {
            return Math.ceil(a);
        }
    }
};
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.DateCollection = function () {
    this.Initialize();
    this._lastInsertedKey = null;
};
Telerik.Web.UI.Calendar.DateCollection.prototype = {
    Initialize: function () {
        this.Container = {};
    },
    GetStringKey: function (a) {
        return a.join("-");
    },
    Add: function (a, c) {
        if (!a || !c) {
            return;
        }
        var b = this.GetStringKey(a);
        this.Container[b] = c;
        this._lastInsertedKey = a;
    },
    Remove: function (b) {
        if (!b) {
            return;
        }
        var a = this.GetStringKey(b);
        if (this.Container[a] != null) {
            this.Container[a] = null;
            delete this.Container[a];
        }
    },
    Clear: function () {
        this.Initialize();
    },
    Get: function (b) {
        if (!b) {
            return;
        }
        var a = this.GetStringKey(b);
        if (this.Container[a] != null) {
            return this.Container[a];
        } else {
            return null;
        }
    },
    GetValues: function () {
        var b = [];
        for (var a in this.Container) {
            if (a.indexOf("-") == -1) {
                continue;
            }
            b[b.length] = this.Container[a];
        }
        return b;
    },
    Count: function () {
        return this.GetValues().length;
    }
};
Telerik.Web.UI.Calendar.DateCollection.registerClass("Telerik.Web.UI.Calendar.DateCollection");
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.CalendarView = function (h, X, a, L, z, q, C, e, f, B) {
    this._onClickDelegate = null;
    this._onMouseOverDelegate = null;
    this._onMouseOutDelegate = null;
    this._onKeyDownDelegate = null;
    this._onKeyPressDelegate = null;
    this._SingleViewMatrix = X;
    this._ViewInMonthDate = B;
    this.MonthsInView = 1;
    this._MonthStartDate = null;
    this._MonthDays = null;
    this._MonthEndDate = null;
    this._ViewStartDate = null;
    this._ContentRows = z;
    this._ContentColumns = L;
    this._TitleContent = null;
    this.RadCalendar = h;
    this.DateTimeFormatInfo = h ? h.DateTimeFormatInfo : null;
    this.Calendar = this.DateTimeFormatInfo ? this.DateTimeFormatInfo.Calendar : null;
    if (!q) {
        this.SetViewDateRange();
    }
    this.DomTable = X;
    this.ID = a;
    this.Cols = L;
    this.Rows = z;
    this.IsMultiView = q;
    if (q) {
        return;
    }
    if (!this.RadCalendar.get_enabled()) {
        return;
    }
    var o = false;
    var H = false;
    var m = false;
    var b = false;
    this.UseRowHeadersAsSelectors = C;
    this.UseColumnHeadersAsSelectors = e;
    var R = 0;
    var F = X.rows[R].cells[0].id;
    if (F.indexOf("_hd") > -1) {
        o = true;
        F = X.rows[++R].cells[0].id;
    }
    if (F.indexOf("_vs") > -1) {
        m = true;
    }
    var g = X.rows[R].cells.length - this.Cols;
    if (X.rows[R].cells[g] && X.rows[R].cells[g].id.indexOf("_cs") > -1) {
        H = true;
    }
    var n = X.rows.length - this.Rows;
    if (X.rows[R + n] && X.rows[R + n].cells[0].id.indexOf("_rs") > -1) {
        b = true;
    }
    var y = 0;
    var c = 0;
    if (o) {
        y++;
    }
    if (H || m) {
        y++;
    }
    if (b || m) {
        c++;
    }
    this.StartRowIndex = y;
    this.StartColumnIndex = c;
    var O = [];
    if (f == Telerik.Web.UI.Calendar.Utils.RENDERINROWS) {
        O = this.ComputeHeaders(z, L);
    }
    if (f == Telerik.Web.UI.Calendar.Utils.RENDERINCOLUMNS) {
        O = this.ComputeHeaders(L, z);
    }
    if (!q) {
        this.RenderDays = new Telerik.Web.UI.Calendar.DateCollection();
        for (var G = y;
        G < X.rows.length;
        G++) {
            var P = X.rows[G];
            for (var E = c;
            E < P.cells.length;
            E++) {
                var K = P.cells[E];
                if (typeof (K.DayId) == "undefined") {
                    K.DayId = "";
                }
                var I = this.GetDate(G - y, E - c, L, z, this._ViewStartDate);
                var U = !this.RadCalendar.RangeValidation.IsDateValid(I);
                var T = !((this.RadCalendar.RangeValidation.CompareDates(I, this._MonthStartDate) >= 0) && (this.RadCalendar.RangeValidation.CompareDates(this._MonthEndDate, I) >= 0));
                if (U || (T && !this.RadCalendar.get_showOtherMonthsDays())) {
                    continue;
                }
                if (isNaN(I[0]) || isNaN(I[1]) || isNaN(I[2])) {
                    continue;
                }
                var Y = K.DayId;
                if (!Y) {
                    K.DayId = this.RadCalendar.get_id() + "_" + I.join("_");
                    Y = K.DayId;
                }
                if (!Y) {
                    continue;
                }
                var w = this.RadCalendar.SpecialDays.Get(I);
                var s = this.Calendar.GetDayOfWeek(I);
                var J = (0 == s || 6 == s);
                var Q = (w && w.Repeatable == Telerik.Web.UI.Calendar.Utils.RECURRING_TODAY);
                var S = w ? Boolean(w.IsDisabled) : false;
                var W;
                if (S) {
                    W = false;
                } else {
                    W = w ? Boolean(w.IsSelectable) : true;
                }
                var r;
                if (!W) {
                    r = false;
                } else {
                    r = (w && Boolean(w.IsSelected)) || (null != this.RadCalendar.Selection._selectedDates.Get(I));
                }
                var u = w ? w.Repeatable : null;
                var N = w ? w.ToolTip : null;
                var V = (I[1] == this._MonthStartDate[1]);
                var t = null;
                if (w) {
                    var v = "SpecialDayStyle_" + w.get_date().join("_");
                    t = w.ItemStyle[v];
                }
                var x = w ? w.ItemStyle : this.RadCalendar._getItemStyle(!V, U, J, r, S, t);
                var l = [null, I, W, r, S, Q, u, J, N, x, K, this.RadCalendar, Y, this, G - y, E - c];
                var k = new Telerik.Web.UI.Calendar.RenderDay(l);
                this.RenderDays.Add(k.get_date(), k);
            }
        }
        var A = Math.max(y - 1, 0);
        if (f == Telerik.Web.UI.Calendar.Utils.RENDERINCOLUMNS && H) {
            for (var G = 0;
            G < this.Cols;
            G++) {
                var d = X.rows[A].cells[c + G];
                if (this.isNumber(d.innerHTML)) {
                    d.innerHTML = O[G];
                } else {
                    break;
                }
            }
        }
        if (f == Telerik.Web.UI.Calendar.Utils.RENDERINROWS && b) {
            for (var G = 0;
            G < this.Rows;
            G++) {
                var d = X.rows[y + G].cells[0];
                if (this.isNumber(d.innerHTML)) {
                    d.innerHTML = O[G];
                } else {
                    break;
                }
            }
        }
        if (this.RadCalendar.get_presentationType() == 2) {
            return;
        }
        this._onClickDelegate = Function.createDelegate(this, this._onClickHandler);
        this._onMouseOverDelegate = Function.createDelegate(this, this._onMouseOverHandler);
        this._onMouseOutDelegate = Function.createDelegate(this, this._onMouseOutHandler);
        this._onKeyDownDelegate = Function.createDelegate(this, this._onKeyDownHandler);
        this._onKeyPressDelegate = Function.createDelegate(this, this._onKeyPressHandler);
        $addHandler(this.DomTable, "click", this._onClickDelegate);
        $addHandler(this.DomTable, "mouseover", this._onMouseOverDelegate);
        $addHandler(this.DomTable, "mouseout", this._onMouseOutDelegate);
        $addHandler(this.DomTable, "keydown", this._onKeyDownDelegate);
        $addHandler(this.DomTable, "keypress", this._onKeyPressDelegate);
    }
    this.ColumnHeaders = [];
    if (H && this.UseColumnHeadersAsSelectors) {
        for (G = 0;
        G < this.Cols;
        G++) {
            var d = X.rows[A].cells[c + G];
            var D = new Telerik.Web.UI.Calendar.Selector(Telerik.Web.UI.Calendar.Utils.COLUMN_HEADER, y, c + G, this.RadCalendar, this, d);
            this.ColumnHeaders[G] = D;
        }
    }
    this.RowHeaders = [];
    if (b && this.UseRowHeadersAsSelectors) {
        for (G = 0;
        G < this.Rows;
        G++) {
            var d = X.rows[y + G].cells[0];
            var M = new Telerik.Web.UI.Calendar.Selector(Telerik.Web.UI.Calendar.Utils.ROW_HEADER, y + G, 1, this.RadCalendar, this, d);
            this.RowHeaders[G] = M;
        }
    }
    this.ViewSelector = null;
    if (m) {
        var p = new Telerik.Web.UI.Calendar.Selector(Telerik.Web.UI.Calendar.Utils.VIEW_HEADER, A + 1, 1, this.RadCalendar, this, X.rows[A].cells[0]);
        this.ViewSelector = p;
    }
};
Telerik.Web.UI.Calendar.CalendarView.prototype = {
    _onKeyDownHandler: function (a) {
        if (!$telerik.isOpera) {
            this._raiseKeyPressInternal(a);
        }
    },
    _onKeyPressHandler: function (a) {
        if ($telerik.isOpera) {
            this._raiseKeyPressInternal(a);
        }
    },
    _raiseKeyPressInternal: function (a) {
        if ((this.RadCalendar._enableKeyboardNavigation) && (!this.RadCalendar._enableMultiSelect)) {
            var c = a.keyCode ? a.keyCode : a.charCode;
            var d = this._performSelectionOnFirstDateOfMonth(c);
            if (!d) {
                var b = this._navigateToDate(c);
            }
            if (b || d || c == 13 || c == 32) {
                if (a.preventDefault) {
                    a.preventDefault();
                }
                a.returnValue = false;
                return false;
            }
        }
    },
    _onMouseOverHandler: function (a) {
        this._onGenericHandler(a, "MouseOver");
    },
    _onMouseOutHandler: function (a) {
        this._onGenericHandler(a, "MouseOut");
    },
    _onClickHandler: function (a) {
        if ((this.RadCalendar._enableKeyboardNavigation) && (!this.RadCalendar._enableMultiSelect)) {
            this.DomTable.tabIndex = 100;
            this.DomTable.focus();
            this.RadCalendar._nextFocusedCell = null;
            this.RadCalendar._hoveredDate = null;
            this._removeHoverStyles(this.DomTable);
        }
        this._onGenericHandler(a, "Click");
    },
    _onGenericHandler: function (c, g) {
        if (this.RadCalendar == null) {
            return;
        }
        var h = Telerik.Web.UI.Calendar.Utils.FindTarget(c, this.RadCalendar.get_id());
        if (h == null) {
            return;
        }
        if (h.DayId) {
            var b = Telerik.Web.UI.Calendar.Utils.GetRenderDay(this, h.DayId);
            if (b != null) {
                if (g == "Click") {
                    b[g].apply(b, [c]);
                } else {
                    b[g].apply(b);
                }
            }
        } else {
            if (h.id != null && h.id != "") {
                if (h.id.indexOf("_cs") > -1) {
                    for (var f = 0;
                    f < this.ColumnHeaders.length;
                    f++) {
                        var a = this.ColumnHeaders[f];
                        if (a.DomElement.id == h.id) {
                            a[g].apply(a);
                        }
                    }
                } else {
                    if (h.id.indexOf("_rs") > -1) {
                        for (var f = 0;
                        f < this.RowHeaders.length;
                        f++) {
                            var d = this.RowHeaders[f];
                            if (d.DomElement.id == h.id) {
                                d[g].apply(d);
                            }
                        }
                    } else {
                        if (h.id.indexOf("_vs") > -1) {
                            this.ViewSelector[g].apply(this.ViewSelector);
                        }
                    }
                }
            }
        }
    },
    isNumber: function (b) {
        if (isNaN(parseInt(b))) {
            return false;
        } else {
            return true;
        }
    },
    ComputeHeaders: function (c, a) {
        var b = [];
        var f = this._ViewStartDate;
        for (var e = 0;
        e < c;
        e++) {
            if (a <= 7) {
                var d = this.Calendar.AddDays(f, a - 1);
                if (d[2] < f[2]) {
                    var g = [d[0], d[1], 1];
                    b[b.length] = this.GetWeekOfYear(g);
                } else {
                    b[b.length] = this.GetWeekOfYear(f);
                }
                f = this.Calendar.AddDays(d, 1);
            } else {
                var d = this.Calendar.AddDays(f, 6);
                if (d[2] < f[2]) {
                    var g = [d[0], d[1], 1];
                    b[b.length] = this.GetWeekOfYear(g);
                } else {
                    b[b.length] = this.GetWeekOfYear(f);
                }
                f = this.Calendar.AddDays(d, a - 6);
            }
        }
        return b;
    },
    GetDate: function (e, g, a, d, c) {
        var f;
        if (this.RadCalendar.get_orientation() == Telerik.Web.UI.Calendar.Utils.RENDERINROWS) {
            f = (a * e) + g;
        } else {
            if (this.RadCalendar.get_orientation() == Telerik.Web.UI.Calendar.Utils.RENDERINCOLUMNS) {
                f = (d * g) + e;
            }
        }
        var b = this.Calendar.AddDays(c, f);
        return b;
    },
    dispose: function () {
        if (this.disposed) {
            return;
        }
        this.disposed = true;
        if (this.RenderDays != null) {
            var a = this.RenderDays.GetValues();
            for (var b = 0;
            b < a.length;
            b++) {
                a[b].dispose();
            }
            this.RenderDays.Clear();
        }
        if (this.ColumnHeaders != null) {
            for (var b = 0;
            b < this.ColumnHeaders.length;
            b++) {
                this.ColumnHeaders[b].Dispose();
            }
        }
        this.ColumnHeaders = null;
        if (this.RowHeaders != null) {
            for (var b = 0;
            b < this.RowHeaders.length;
            b++) {
                this.RowHeaders[b].Dispose();
            }
        }
        $clearHandlers(this.DomTable);
        this.genericHandler = null;
        this.RowHeaders = null;
        if (this.ViewSelector != null) {
            this.ViewSelector.Dispose();
        }
        this.ViewSelector = null;
        this._SingleViewMatrix = null;
        this._ContentRows = null;
        this._ContentColumns = null;
        this.RadCalendar.RecurringDays.Clear();
        this.RadCalendar = null;
        this.Calendar = null;
        this.DomTable = null;
        this.Cols = null;
        this.Rows = null;
    },
    GetWeekOfYear: function (a) {
        return this.Calendar.GetWeekOfYear(a, this.DateTimeFormatInfo.CalendarWeekRule, this.NumericFirstDayOfWeek());
    },
    NumericFirstDayOfWeek: function () {
        if (this.RadCalendar._firstDayOfWeek != Telerik.Web.UI.Calendar.Utils.DEFAULT) {
            return this.RadCalendar._firstDayOfWeek;
        }
        return this.DateTimeFormatInfo.FirstDayOfWeek;
    },
    EffectiveVisibleDate: function () {
        var a = this._ViewInMonthDate || this.RadCalendar.FocusedDate;
        return [a[0], a[1], 1];
    },
    FirstCalendarDay: function (a) {
        var c = a;
        var b = (this.Calendar.GetDayOfWeek(c)) - this.NumericFirstDayOfWeek();
        if (b <= 0) {
            b += 7;
        }
        return this.Calendar.AddDays(c, -b);
    },
    SetViewDateRange: function () {
        var a = (this.RadCalendar._viewIDs.length > 1);
        if (!a) {
            this._MonthStartDate = this.EffectiveVisibleDate();
        } else {
            this._MonthStartDate = this.RadCalendar.get__ViewsHash()[this._SingleViewMatrix.id][0];
        }
        this._MonthDays = this.Calendar.GetDaysInMonth(this._MonthStartDate[0], this._MonthStartDate[1]);
        this._MonthEndDate = this.Calendar.AddDays(this._MonthStartDate, this._MonthDays - 1);
        this._ViewStartDate = this.FirstCalendarDay(this._MonthStartDate);
        this._ViewEndDate = this.Calendar.AddDays(this._ViewStartDate, (this._ContentRows * this._ContentColumns - 1));
        this.GetTitleContentAsString();
        this.SetWeekTitle();
    },
    SetWeekTitle: function () {
        $('.rcMainTable th').each(function () { $(this).text($(this).attr('abbr')); });
    },
    GetTitleContentAsString: function () {
        if (!this.IsMultiView) {
            this._TitleContent = this.DateTimeFormatInfo.FormatDate(this.EffectiveVisibleDate(), this.RadCalendar.get_titleFormat());
        } else {
            this._TitleContent = this.DateTimeFormatInfo.FormatDate(this._ViewStartDate, this.RadCalendar.get_titleFormat()) + this.RadCalendar.get_dateRangeSeparator() + this.DateTimeFormatInfo.FormatDate(this._ViewEndDate, this.RadCalendar.get_titleFormat());
        }
        return this._TitleContent;
    },
    RenderDaysSingleView: function () {
        this.SetViewDateRange();
        var b = this.EffectiveVisibleDate();
        var a = this.FirstCalendarDay(b);
        var c = this._SingleViewMatrix;
        this.RenderViewDays(c, a, b, this.RadCalendar.get_orientation(), this.StartRowIndex, this.StartColumnIndex);
        this.ApplyViewTable(c, this.ScrollDir || 0);
        var d = $get(this.RadCalendar._titleID);
        if (d) {
            d.innerHTML = this._TitleContent;
        }
        return c;
    },
    RenderViewDays: function (d, h, f, g, b, e) {
        var m = h;
        var n, k;
        if (g == Telerik.Web.UI.Calendar.Utils.RENDERINROWS) {
            for (var l = b;
            l < d.rows.length;
            l++) {
                var n = d.rows[l];
                for (var a = e;
                a < n.cells.length;
                a++) {
                    k = n.cells[a];
                    this.SetCalendarCell(k, m, l, a);
                    m = this.Calendar.AddDays(m, 1);
                }
            }
        } else {
            if (g == Telerik.Web.UI.Calendar.Utils.RENDERINCOLUMNS) {
                var c = d.rows[0].cells.length;
                for (var l = e;
                l < c;
                l++) {
                    for (var a = b;
                    a < d.rows.length;
                    a++) {
                        k = d.rows[a].cells[l];
                        this.SetCalendarCell(k, m, a, l);
                        m = this.Calendar.AddDays(m, 1);
                    }
                }
            }
        }
    },
    SetCalendarCell: function (g, b, d, F) {
        var q = !this.RadCalendar.RangeValidation.IsDateValid(b);
        var E = (b[1] == this._MonthStartDate[1]);
        var y = this.DateTimeFormatInfo.FormatDate(b, this.RadCalendar.get_cellDayFormat());
        var c = this.RadCalendar.SpecialDays.Get(b);
        if (this.RadCalendar.get_enableRepeatableDaysOnClient() && c == null) {
            var m = Telerik.Web.UI.Calendar.Utils.RECURRING_NONE;
            var x = this.RadCalendar.SpecialDays.GetValues();
            for (var t = 0;
            t < x.length;
            t++) {
                m = x[t].IsRecurring(b, this);
                if (m != Telerik.Web.UI.Calendar.Utils.RECURRING_NONE) {
                    c = x[t];
                    this.RadCalendar.RecurringDays.Add(b, c);
                    break;
                }
            }
        }
        var j = this.RadCalendar.Selection._selectedDates.Get(b) != null;
        if (E || (!E && this.RadCalendar.get_showOtherMonthsDays())) {
            if (!q) {
                y = "<a href='#' onclick='return false;'>" + y + "</a>";
            } else {
                y = "<span>" + y + "</span>";
            }
        } else {
            y = "&#160;";
        }
        var s = this.Calendar.GetDayOfWeek(b);
        var u = (0 == s || 6 == s);
        var C = c ? c.IsDisabled : false;
        var B = (c && c.Repeatable == Telerik.Web.UI.Calendar.Utils.RECURRING_TODAY);
        g.innerHTML = y;
        if ($telerik.isIE) {
            var p = g.getElementsByTagName("a");
            if (p.length > 0) {
                p[0].href = "#";
            }
        }
        var l = null;
        if (c) {
            var n = "SpecialDayStyle_" + c.get_date().join("_");
            l = c.ItemStyle[n];
        }
        var z = this.RadCalendar._getItemStyle(!E, q, u, j, C, l);
        if (z) {
            var h = this.RadCalendar.get__DayRenderChangedDays()[b.join("_")];
            if (h != null && (E || (!E && this.RadCalendar.get_showOtherMonthsDays()))) {
                g.style.cssText = Telerik.Web.UI.Calendar.Utils.MergeStyles(h[0], z[0]);
                g.className = Telerik.Web.UI.Calendar.Utils.MergeClassName(h[1], z[1]);
            } else {
                g.style.cssText = z[0];
                g.className = z[1];
            }
        }
        var D = this.RadCalendar._getRenderDayID(b);
        g.DayId = (!E && !this.RadCalendar.get_showOtherMonthsDays()) ? "" : D;
        var e = null;
        if (!q) {
            var f = [null, b, true, j, null, B, null, u, null, z, g, this.RadCalendar, D, this, d, F];
            e = new Telerik.Web.UI.Calendar.RenderDay(f);
            this.RenderDays.Add(e.get_date(), e);
        } else {
            if (g.RenderDay != null) {
                if (g.RenderDay.disposed == null) {
                    g.RenderDay.Dispose();
                }
                g.RenderDay = null;
                this.RenderDays.Remove(b);
            }
        }
        var k = "";
        var o = this.RadCalendar.SpecialDays.Get(b);
        if (o != null && o.ToolTip != null) {
            k = o.ToolTip;
        } else {
            if (typeof (this.RadCalendar.get_dayCellToolTipFormat()) != "undefined") {
                k = this.DateTimeFormatInfo.FormatDate(b, this.RadCalendar.get_dayCellToolTipFormat());
            }
        }
        if (!this.RadCalendar.get_showOtherMonthsDays() && g.DayId == "") {
            g.title = "";
        } else {
            if (this.RadCalendar._showDayCellToolTips) {
                g.title = k;
            }
        }
        var a = g.style.cssText;
        var v = g.className;
        var r = new Telerik.Web.UI.CalendarDayRenderEventArgs(g, b, e);
        this.RadCalendar.raise_dayRender(r);
        var A = g.style.cssText;
        var w = g.className;
        if (a != A || v != w) {
            if (this.RadCalendar.get__DayRenderChangedDays()[b.join("_")] == null) {
                this.RadCalendar.get__DayRenderChangedDays()[b.join("_")] = ["", "", "", ""];
            }
            this.RadCalendar.get__DayRenderChangedDays()[b.join("_")][2] = A;
            this.RadCalendar.get__DayRenderChangedDays()[b.join("_")][3] = w;
        }
    },
    ApplyViewTable: function (h, j) {
        this.RadCalendar._enableNavigation(false);
        this.RadCalendar.EnableDateSelect = false;
        var g = this._SingleViewMatrix;
        var n = g.parentNode;
        var a = n.scrollWidth;
        var k = n.scrollHeight;
        var m = document.createElement("div");
        m.style.overflow = "hidden";
        m.style.width = a + "px";
        m.style.height = k + "px";
        m.style.border = "0px solid red";
        var f = document.createElement("div");
        f.style.width = 2 * a + "px";
        f.style.height = k + "px";
        f.style.border = "0px solid blue";
        m.appendChild(f);
        if (g.parentNode) {
            g.parentNode.removeChild(g);
        }
        if (h.parentNode) {
            h.parentNode.removeChild(h);
        }
        if (!document.all) {
            g.style.setProperty("float", "left", "");
            h.style.setProperty("float", "left", "");
        }
        var d = 0;
        if (j > 0) {
            d = 1;
            f.appendChild(g);
            h.parentNode.removeChild(h);
            f.appendChild(h);
        } else {
            if (j < 0) {
                d = -1;
                f.appendChild(h);
                g.parentNode.removeChild(g);
                f.appendChild(g);
            }
        }
        n.appendChild(m);
        if (j < 0 && this.RadCalendar.get_enableNavigationAnimation() == true) {
            m.scrollLeft = n.offsetWidth + 10;
        }
        var c = this;
        var i = 10;
        var b = function () {
            if (m.parentNode) {
                m.parentNode.removeChild(m);
            }
            if (f.parentNode) {
                f.parentNode.removeChild(f);
            }
            if (g.parentNode) {
                g.parentNode.removeChild(g);
            }
            n.appendChild(h);
            c.RadCalendar._enableNavigation(true);
            c.RadCalendar.EnableDateSelect = true;
        };
        var l = function () {
            if ((d > 0 && (m.scrollLeft + m.offsetWidth) < m.scrollWidth) || (d < 0 && m.scrollLeft > 0)) {
                m.scrollLeft += d * i;
                window.setTimeout(l, 10);
            } else {
                b();
            }
        };
        var e = function () {
            window.setTimeout(l, 100);
        };
        if (!this.RadCalendar._isRtl() && this.RadCalendar.get_enableNavigationAnimation() == true) {
            e();
        } else {
            b();
        }
    },
    _performSelectionOnFirstDateOfMonth: function (d) {
        this._selectFocusedDate(d);
        var c = this.RadCalendar.get_selectedDates()[0];
        var b = this.RadCalendar._hoveredDateTriplet;
        if (d >= 37 && d <= 40) {
            if ((c == null) && (this.RadCalendar._nextFocusedCell == null)) {
                var a = this._selectFirstDateOfTheCalendarView();
                this.RadCalendar._hoveredDateTriplet = a;
                this.RadCalendar._hoveredDate = new Date(a[0], a[1] - 1, a[2]);
                return true;
            }
            if (c != null) {
                this.RadCalendar._hoveredDateTriplet = c;
                b = c;
            }
            if (!this.RadCalendar._hoveredDate) {
                if (b == null) {
                    this.RadCalendar._hoveredDateTriplet = this._selectFirstDateOfTheCalendarView();
                    return true;
                }
                this.RadCalendar._hoveredDate = new Date(b[0], b[1] - 1, b[2]);
            }
        }
        return false;
    },
    _selectFocusedDate: function (c) {
        if (c == 13 || c == 32) {
            if (this.RadCalendar._nextFocusedCell != null) {
                var a = new Array();
                var b = this.RadCalendar._hoveredDate;
                a.push(b.getFullYear());
                a.push(b.getMonth() + 1);
                a.push(b.getDate());
                this.RadCalendar.selectDate(a, false);
            }
        }
    },
    _navigateToDate: function (a) {
        var b = false;
        switch (a) {
            case 37:
                this._moveLeft(this.RadCalendar._hoveredDate, a);
                b = true;
                break;
            case 38:
                this._moveTop(this.RadCalendar._hoveredDate, a);
                b = true;
                break;
            case 39:
                this._moveRight(this.RadCalendar._hoveredDate, a);
                b = true;
                break;
            case 40:
                this._moveBottom(this.RadCalendar._hoveredDate, a);
                b = true;
                break;
            default:
                break;
        }
        return b;
    },
    _addClassAndGetFocus: function (c, a) {
        if (c.className.indexOf("rcHover") < 0) {
            c.className = "rcHover " + c.className;
        }
        if (this.RadCalendar && this.RadCalendar.get_enableAriaSupport()) {
            var b = c.getElementsByTagName("a")[0];
            if (b) {
                b.tabIndex = 0;
            }
        }
        a.tabIndex = 100;
        if (a.offsetWidth) {
            a.focus();
        }
    },
    _selectFirstDateOfTheCalendarView: function () {
        var a = this.RadCalendar.CurrentViews[0];
        var b = this._getAllCells(a.DomTable);
        var g = a._MonthStartDate[2].toString();
        var d = a._MonthStartDate;
        for (var e = 0;
        e < b.length;
        e++) {
            if (b[e].tagName.toUpperCase() == "TD" && b[e].DayId != "") {
                var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(b[e].DayId)[2];
                if (f == g) {
                    this.RadCalendar._nextFocusedCell = b[e];
                    var c = this.DomTable;
                    this._addClassAndGetFocus(this.RadCalendar._nextFocusedCell, c);
                    return d;
                }
            }
        }
    },
    _getNewSelectedDate: function (c, b, a) {
        b = this._addDays(this.RadCalendar._hoveredDate, a);
        this.RadCalendar._hoveredDate = b;
        if (c) {
            this._navigateToNextMonthView();
        } else {
            this._navigateToPreviousMonthView();
        }
        return b;
    },
    _getPreviousSibling: function (b) {
        var a = b.previousSibling;
        if (a && a.nodeType == 3) {
            return null;
        } else {
            return a;
        }
    },
    _getNextSibling: function (b) {
        var a = b.nextSibling;
        if (a && a.nodeType == 3) {
            return null;
        } else {
            return a;
        }
    },
    _getFirstChild: function (b) {
        var a = b.firstChild;
        if (b.nodeType == 3) {
            return null;
        }
        if (a && a.nodeType == 3) {
            return a.nextSibling;
        } else {
            return a;
        }
    },
    _getLastChild: function (b) {
        var a = b.lastChild;
        if (a && a.nodeType == 3) {
            return a.previousSibling;
        } else {
            return a;
        }
    },
    _moveLeft: function (g, e) {
        var b = null;
        var j = this.DomTable;
        var k = false;
        var f = this.RadCalendar;
        var i = f.RangeMinDate;
        var c = new Date(i[0], i[1] - 1, i[2]);
        var a = null;
        if (g <= c) {
            return;
        }
        if (!f._nextFocusedCell) {
            var h = $telerik.getElementByClassName(j, "rcSelected", "td");
            if (this._getPreviousSibling(h.parentNode) == null) {
                b = this._getNewSelectedDate(false, b, -1);
                k = true;
                e = 38;
                f._nextFocusedCell = this._hoverLastDateOfMonth(f, e, b);
            } else {
                if (h.previousSibling && h.previousSibling.className && h.previousSibling.className.indexOf("rcOtherMonth") > -1) {
                    b = this._getNewSelectedDate(true, b, -1);
                    k = true;
                    e = 40;
                    f._nextFocusedCell = this._hoverFirstDateOfMonth(f, e, b);
                } else {
                    a = h;
                    f._nextFocusedCell = h.previousSibling;
                }
            }
        } else {
            this._removeHoverStyles(j);
            a = f._nextFocusedCell;
            f._nextFocusedCell = f._nextFocusedCell.previousSibling;
        }
        var d = f._nextFocusedCell;
        if (!d) {
            f._nextFocusedCell = this._getLastChild(a.parentNode.previousSibling);
        }
        if (d && d.tagName && d.tagName.toUpperCase() == "TH" || (d && !d.tagName && !f._showRowHeaders)) {
            f._nextFocusedCell = this._getLastChild(d.parentNode.previousSibling);
        }
        this._addClassAndGetFocus(f._nextFocusedCell, j);
        if (!k) {
            b = this._addDays(g, -1);
            f._hoveredDate = b;
            f._nextFocusedCell = this._moveCurentViewToNextPrev(g, b, e);
            this._addClassAndGetFocus(f._nextFocusedCell, j);
        }
    },
    _moveRight: function (g, c) {
        var a = null;
        var i = this.DomTable;
        var e = this.RadCalendar;
        var j = false;
        var f = e.RangeMaxDate;
        var d = new Date(f[0], f[1] - 1, f[2]);
        if (g >= d) {
            return;
        }
        if (!e._nextFocusedCell) {
            var h = $telerik.getElementByClassName(i, "rcSelected", "td");
            if (h.parentNode.nextSibling == null) {
                a = this._getNewSelectedDate(true, a, 1);
                c = 40;
                e._nextFocusedCell = this._hoverFirstDateOfMonth(e, c, a);
                j = true;
            } else {
                if (this._getNextSibling(h) == null) {
                    e._nextFocusedCell = this._getFirstChild(h.parentNode.nextSibling);
                    if (e._nextFocusedCell == null) {
                        a = this._getNewSelectedDate(true, a, 1);
                        c = 40;
                        e._nextFocusedCell = this._hoverFirstDateOfMonth(e, c, a);
                        j = true;
                    }
                } else {
                    if ((h.nextSibling.className.indexOf("rcOtherMonth") > -1) && (this._getPreviousSibling(h.parentNode) != null)) {
                        a = this._getNewSelectedDate(true, a, 1);
                        c = 40;
                        e._nextFocusedCell = this._hoverFirstDateOfMonth(e, c, a);
                        j = true;
                    } else {
                        if (h.nextSibling.className.indexOf("rcOtherMonth") > -1) {
                            a = this._getNewSelectedDate(false, a, 1);
                            c = 38;
                            e._nextFocusedCell = this._hoverLastDateOfMonth(e, c, a);
                            j = true;
                        } else {
                            e._nextFocusedCell = h.nextSibling;
                        }
                    }
                }
            }
        } else {
            this._removeHoverStyles(i);
            if (this._getNextSibling(e._nextFocusedCell) != null) {
                e._nextFocusedCell = e._nextFocusedCell.nextSibling;
            } else {
                e._nextFocusedCell = this._getFirstChild(e._nextFocusedCell.parentNode.nextSibling);
            }
        }
        var b = e._nextFocusedCell;
        if (b.tagName.toUpperCase() == "TH") {
            e._nextFocusedCell = b.nextSibling;
        }
        this._addClassAndGetFocus(e._nextFocusedCell, i);
        if (!j) {
            a = this._addDays(g, 1);
            e._hoveredDate = a;
            e._nextFocusedCell = this._moveCurentViewToNextPrev(g, a, c);
            this._addClassAndGetFocus(e._nextFocusedCell, i);
        }
    },
    _moveBottom: function (g, c) {
        var b = null;
        var k = this.DomTable;
        var e = this.RadCalendar;
        var l = false;
        var f = e.RangeMaxDate;
        var d = new Date(f[0], f[1] - 1, f[2]);
        var a = this._addDays(g, 6);
        if (a >= d) {
            return;
        }
        if (!e._nextFocusedCell) {
            var h = $telerik.getElementByClassName(k, "rcSelected", "td");
            var j = h.cellIndex;
            if (h.parentNode.firstChild.nodeType == 3) {
                j = j + 1;
            }
            if (this._getNextSibling(h.parentNode) == null) {
                if (!this._getFirstChild(this._getLastChild(k)).cells[j]) {
                    e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j - 1].parentNode.nextSibling.childNodes[j];
                } else {
                    e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j].parentNode.nextSibling.childNodes[j];
                }
                b = this._getNewSelectedDate(true, b, 7);
                l = true;
                var i = Telerik.Web.UI.Calendar.Utils.GetDateFromId(e._nextFocusedCell.DayId)[2];
                if (i.toString() != b.getDate().toString()) {
                    e._nextFocusedCell = e._nextFocusedCell.parentNode.nextSibling.childNodes[j];
                }
            } else {
                e._nextFocusedCell = h.parentNode.nextSibling.childNodes[j];
                if (e._nextFocusedCell.className.indexOf("rcOtherMonth") > -1) {
                    b = this._getNewSelectedDate(true, b, 7);
                    l = true;
                    if (!this._getFirstChild(this._getLastChild(k)).cells[j]) {
                        e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j - 1].parentNode.nextSibling.childNodes[j];
                    } else {
                        e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j].parentNode.nextSibling.childNodes[j];
                        var i = Telerik.Web.UI.Calendar.Utils.GetDateFromId(e._nextFocusedCell.DayId)[2];
                        if (i.toString() != b.getDate().toString()) {
                            e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j];
                        }
                    }
                }
            }
        } else {
            this._removeHoverStyles(k);
            var j = e._nextFocusedCell.cellIndex;
            if (e._nextFocusedCell.parentNode.firstChild.nodeType == 3) {
                j = j + 1;
            }
            if (this._getNextSibling(e._nextFocusedCell.parentNode) == null) {
                if (!this._getFirstChild(this._getLastChild(k)).cells[j]) {
                    e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j - 1].parentNode.nextSibling.childNodes[j];
                } else {
                    e._nextFocusedCell = this._getFirstChild(this._getLastChild(k)).cells[j].parentNode.nextSibling.childNodes[j];
                }
                l = true;
                b = this._getNewSelectedDate(true, b, 7);
                var i = Telerik.Web.UI.Calendar.Utils.GetDateFromId(e._nextFocusedCell.DayId)[2];
                if (i.toString() != b.getDate().toString()) {
                    e._nextFocusedCell = e._nextFocusedCell.parentNode.nextSibling.childNodes[j];
                }
            } else {
                e._nextFocusedCell = e._nextFocusedCell.parentNode.nextSibling.childNodes[j];
            }
        }
        this._addClassAndGetFocus(e._nextFocusedCell, k);
        if (!l) {
            b = this._addDays(g, 7);
            e._hoveredDate = b;
            if ((b.getMonth() + 1).toString() != this.RadCalendar.CurrentViews[0]._MonthStartDate[1].toString()) {
                e._nextFocusedCell = this._moveCurentViewToNextPrev(g, b, c);
                this._addClassAndGetFocus(e._nextFocusedCell, k);
            }
        }
    },
    _moveTop: function (g, m) {
        var e = null;
        var h = this.DomTable;
        var f = this.RadCalendar;
        var i = false;
        var d = f.RangeMinDate;
        var k = new Date(d[0], d[1] - 1, d[2]);
        var l = this._addDays(g, -6);
        var a = f._nextFocusedCell;
        if (l <= k) {
            return;
        }
        if (!a) {
            var c = $telerik.getElementByClassName(h, "rcSelected", "td");
            var b = c.cellIndex;
            if (c.parentNode.firstChild.nodeType == 3) {
                b = b + 1;
            }
            if (this._getPreviousSibling(c.parentNode) == null) {
                if (!this._getLastChild(this._getLastChild(h)).cells[b]) {
                    f._nextFocusedCell = this._getLastChild(this._getLastChild(h)).cells[b - 1].parentNode.previousSibling.childNodes[b];
                } else {
                    f._nextFocusedCell = this._getLastChild(this._getLastChild(h)).cells[b].parentNode.previousSibling.childNodes[b];
                }
                i = true;
                e = this._getNewSelectedDate(false, e, -7);
                var j = Telerik.Web.UI.Calendar.Utils.GetDateFromId(f._nextFocusedCell.DayId)[2];
                if (j.toString() != e.getDate().toString()) {
                    f._nextFocusedCell = f._nextFocusedCell.parentNode.previousSibling.childNodes[b];
                }
            } else {
                if (c.parentNode.previousSibling.childNodes[b].className.indexOf("rcOtherMonth") > -1) {
                    if (!this._getLastChild(this._getLastChild(h)).cells[b]) {
                        f._nextFocusedCell = this._getLastChild(this._getLastChild(h)).cells[b - 1].parentNode.previousSibling.childNodes[b];
                    } else {
                        f._nextFocusedCell = this._getLastChild(this._getLastChild(h)).cells[b].parentNode.previousSibling.childNodes[b];
                    }
                    i = true;
                    e = this._getNewSelectedDate(false, e, -7);
                    m = 40;
                    i = true;
                } else {
                    f._nextFocusedCell = c.parentNode.previousSibling.childNodes[b];
                }
            }
        } else {
            this._removeHoverStyles(h);
            var b = f._nextFocusedCell.cellIndex;
            if (f._nextFocusedCell.parentNode.firstChild.nodeType == 3) {
                b = b + 1;
            }
            if (this._getPreviousSibling(f._nextFocusedCell.parentNode) == null) {
                if (!this._getLastChild(this._getLastChild(h)).cells[b]) {
                    f._nextFocusedCell = this._getLastChild(this._getLastChild(h)).cells[b - 1].parentNode.previousSibling.childNodes[b];
                } else {
                    f._nextFocusedCell = this._getLastChild(this._getLastChild(h)).cells[b].parentNode.previousSibling.childNodes[b];
                }
                i = true;
                e = this._getNewSelectedDate(false, e, -7);
                if (f._nextFocusedCell.DayId == "") {
                    f._nextFocusedCell = f._nextFocusedCell.parentNode.previousSibling.childNodes[b];
                } else {
                    var j = Telerik.Web.UI.Calendar.Utils.GetDateFromId(f._nextFocusedCell.DayId)[2];
                    if (j.toString() != e.getDate().toString()) {
                        f._nextFocusedCell = f._nextFocusedCell.parentNode.previousSibling.childNodes[b];
                    }
                }
            } else {
                f._nextFocusedCell = f._nextFocusedCell.parentNode.previousSibling.childNodes[b];
            }
        }
        this._addClassAndGetFocus(f._nextFocusedCell, h);
        if (!i) {
            e = this._addDays(g, -7);
            f._hoveredDate = e;
            if (a && f._nextFocusedCell.className.indexOf("rcOtherMonth") > -1) {
                f._nextFocusedCell = this._moveCurentViewToNextPrev(g, e, m);
            }
            this._addClassAndGetFocus(f._nextFocusedCell, h);
        }
    },
    _navigateToNextMonthView: function () {
        var a = this.RadCalendar;
        a._navigateFromLinksButtons = false;
        a._navigateNext();
        a._navigateFromLinksButtons = true;
    },
    _navigateToPreviousMonthView: function () {
        var a = this.RadCalendar;
        a._navigateFromLinksButtons = false;
        a._navigatePrev();
        a._navigateFromLinksButtons = true;
    },
    _moveCurentViewToNextPrev: function (d, b, c) {
        var a = this.RadCalendar;
        if (d.getFullYear() == b.getFullYear()) {
            if (d.getMonth() < b.getMonth()) {
                this._navigateToNextMonthView();
                a._nextFocusedCell = this._hoverFirstDateOfMonth(a, c, b);
            } else {
                if (d.getMonth() > b.getMonth()) {
                    this._navigateToPreviousMonthView();
                    a._nextFocusedCell = this._hoverLastDateOfMonth(a, c, b);
                }
            }
        } else {
            if (d.getMonth() < b.getMonth() && d.getFullYear() > b.getFullYear()) {
                this._navigateToPreviousMonthView();
                a._nextFocusedCell = this._hoverLastDateOfMonth(a, c, b);
            } else {
                if (d.getMonth() > b.getMonth() && d.getFullYear() < b.getFullYear()) {
                    this._navigateToNextMonthView();
                    a._nextFocusedCell = this._hoverFirstDateOfMonth(a, c, b);
                }
            }
        }
        return a._nextFocusedCell;
    },
    _getAllCells: function (c) {
        if (c.cells) {
            return c.cells;
        } else {
            var a = new Array();
            for (var d = 0;
            d < c.rows.length;
            d++) {
                for (var b = 0;
                b < c.rows[d].cells.length;
                b++) {
                    a.push(c.rows[d].cells[b]);
                }
            }
            return a;
        }
    },
    _hoverLastDateOfMonth: function (d, c, e) {
        var a = this._getAllCells(d.CurrentViews[0].DomTable);
        var b;
        var h = d.CurrentViews[0]._MonthEndDate[2].toString();
        if (c == 38) {
            h = e.getDate().toString();
        }
        for (var f = 0;
        f < a.length;
        f++) {
            if (a[f].tagName.toUpperCase() == "TD" && a[f].DayId != "") {
                var g = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a[f].DayId)[2];
                if (g == h) {
                    b = a[f];
                }
            }
        }
        return b;
    },
    _hoverFirstDateOfMonth: function (c, b, d) {
        var a = this._getAllCells(c.CurrentViews[0].DomTable);
        var g = c.CurrentViews[0]._MonthStartDate[2].toString();
        if (b == 40) {
            g = d.getDate().toString();
        }
        for (var e = 0;
        e < a.length;
        e++) {
            if (a[e].tagName.toUpperCase() == "TD" && a[e].DayId != "") {
                var f = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a[e].DayId)[2];
                if (f == g) {
                    c._nextFocusedCell = a[e];
                    break;
                }
            }
        }
        return c._nextFocusedCell;
    },
    _addDays: function (b, a) {
        var c = new Date(b.getFullYear(), b.getMonth(), b.getDate());
        return new Date(c.setDate(c.getDate() + a));
    },
    _removeHoverStyles: function (b) {
        var c = this._getElementsByClassName(b, "rcHover", "td");
        for (var d = 0;
        d < c.length;
        d++) {
            c[d].className = c[d].className.replace("rcHover", "").replace(/^\s+/, "").replace(/\s+$/, "");
            if (this.RadCalendar && this.RadCalendar.get_enableAriaSupport()) {
                var a = c[d].getElementsByTagName("a")[0];
                if (a) {
                    a.tabIndex = -1;
                }
            }
        }
    },
    _getElementsByClassName: function (d, f, c) {
        var h = null;
        var b = [];
        if (c) {
            h = d.getElementsByTagName(c);
        }
        for (var g = 0, e = h.length;
        g < e;
        g++) {
            var a = h[g];
            if (Sys.UI.DomElement.containsCssClass(a, f)) {
                b.push(a);
            }
        }
        return b;
    }
};
Telerik.Web.UI.Calendar.CalendarView.registerClass("Telerik.Web.UI.Calendar.CalendarView", null, Sys.IDisposable);
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.RenderDay = function (b) {
    if (typeof (b) != "undefined") {
        var a = 0;
        this.TemplateID = b[a++];
        this._date = b[a++];
        this.IsSelectable = b[a++];
        this.IsSelected = b[a++];
        this.IsDisabled = b[a++];
        this.IsToday = b[a++];
        this.Repeatable = b[a++];
        this.IsWeekend = b[a++];
        this.ToolTip = b[a++];
        this.ItemStyle = b[a++];
        this.DomElement = b[a++];
        this.RadCalendar = b[a++];
        this.ID = b[a++];
        this.RadCalendarView = b[a++];
        this.DayRow = b[a++];
        this.DayColumn = b[a++];
    }
};
Telerik.Web.UI.Calendar.RenderDay.prototype = {
    dispose: function () {
        this.disposed = true;
        if (this.DomElement) {
            this.DomElement.DayId = "";
            this.DomElement.RenderDay = null;
        }
        this.DomElement = null;
        this.RadCalendar = null;
        this.RadCalendarView = null;
        this.DayRow = null;
        this.DayColumn = null;
    },
    MouseOver: function () {
        if (!this.ApplyHoverBehavior()) {
            return;
        }
        var a = this.RadCalendar.get_stylesHash()["DayOverStyle"];
        this.DomElement.className = a[1];
        this.DomElement.style.cssText = a[0];
    },
    MouseOut: function () {
        if (!this.ApplyHoverBehavior()) {
            return;
        }
        var a = this.GetDefaultItemStyle();
        this.DomElement.className = a[1];
        this.DomElement.style.cssText = a[0];
    },
    Click: function (a) {
        var c = new Telerik.Web.UI.CalendarDateClickEventArgs(a, this);
        var b = this.RadCalendar;
        if (b._rangeSelectionMode != Telerik.Web.UI.Calendar.RangeSelectionMode.None) {
            b._dateClick(c);
        }
        this.RadCalendar.raise_dateClick(c);
        if (c.get_cancel()) {
            return;
        }
        this.Select(!this.IsSelected);
    },
    Select: function (g, d) {
        if (!this.RadCalendar.Selection.CanSelect(this.get_date())) {
            return;
        }
        if (null == g) {
            g = true;
        }
        if (this.RadCalendar.get_enableMultiSelect()) {
            this.PerformSelect(g);
        } else {
            var b = false;
            if (g) {
                var a = this.RadCalendar._findRenderDay(this.RadCalendar._lastSelectedDate);
                if (a && a != this) {
                    b = (false == a.Select(false));
                }
                var e = this.RadCalendar.Selection._selectedDates.GetValues();
                for (var f = 0;
                f < e.length;
                f++) {
                    if (e[f]) {
                        var a = this.RadCalendar._findRenderDay(e[f]);
                        if (a && a != this) {
                            b = (false == a.Select(false, true));
                        }
                    }
                }
            }
            var h = false;
            if (!b) {
                var c = this.PerformSelect(g);
                if (typeof (c) != "undefined") {
                    h = !c;
                }
                if (this.RadCalendar) {
                    this.RadCalendar._lastSelectedDate = (this.IsSelected ? this.get_date() : null);
                } else {
                    return;
                }
            }
        }
        if (this.RadCalendar) {
            this.RadCalendar._serializeSelectedDates();
            if (!d && !h) {
                this.RadCalendar._submit("d");
            }
        }
    },
    PerformSelect: function (a) {
        if (null == a) {
            a = true;
        }
        if (this.IsSelected != a) {
            var c = new Telerik.Web.UI.CalendarDateSelectingEventArgs(a, this);
            this.RadCalendar.raise_dateSelecting(c);
            if (c.get_cancel()) {
                return false;
            }
            this.IsSelected = a;
            var b = this.GetDefaultItemStyle();
            if (b) {
                this.DomElement.className = b[1];
                this.DomElement.style.cssText = b[0];
            }
            if (a) {
                //if (this.RadCalendar._culture == "fa-IR")
                //    this._date = ShamsiToMiladi(this._date[0], this._date[1], this._date[2]);
                this.RadCalendar.Selection.Add(this.get_date());
            }
            else {
                //if (this.RadCalendar._culture == "fa-IR")
                //    this._date = ShamsiToMiladi(this._date[0], this._date[1], this._date[2]);
                this.RadCalendar.Selection.Remove(this.get_date());
            }
            this.RadCalendar.raise_dateSelected(new Telerik.Web.UI.CalendarDateSelectedEventArgs(this));
        }
    },
    GetDefaultItemStyle: function () {
        var a = (this.get_date()[1] == this.RadCalendarView._MonthStartDate[1]);
        var g = this.RadCalendar.SpecialDays.Get(this.get_date());
        if (g == null && this.RadCalendar.RecurringDays.Get(this.get_date()) != null) {
            g = this.RadCalendar.RecurringDays.Get(this.get_date());
        }
        var f = null;
        if (this.IsSelected && (a || this.RadCalendar.get_showOtherMonthsDays())) {
            return this.RadCalendar.get_stylesHash()["SelectedDayStyle"];
        } else {
            if (g) {
                var d = "SpecialDayStyle_" + g.get_date().join("_");
                f = g.ItemStyle[d];
                var b = null;
                if (!a) {
                    b = this.RadCalendar.get_stylesHash()["OtherMonthDayStyle"];
                } else {
                    if (this.IsWeekend) {
                        b = this.RadCalendar.get_stylesHash()["WeekendDayStyle"];
                    } else {
                        b = this.RadCalendar.get_stylesHash()["DayStyle"];
                    }
                }
                f[0] = Telerik.Web.UI.Calendar.Utils.MergeStyles(b[0], f[0]);
                f[1] = Telerik.Web.UI.Calendar.Utils.MergeClassName(b[1], f[1]);
            } else {
                if (!a) {
                    f = this.RadCalendar.get_stylesHash()["OtherMonthDayStyle"];
                } else {
                    if (this.IsWeekend) {
                        f = this.RadCalendar.get_stylesHash()["WeekendDayStyle"];
                    } else {
                        f = this.RadCalendar.get_stylesHash()["DayStyle"];
                    }
                }
            }
        }
        var e = this.RadCalendar.get__DayRenderChangedDays()[this.get_date().join("_")];
        var c = [];
        if (e != null) {
            c[0] = Telerik.Web.UI.Calendar.Utils.MergeStyles(e[0], f[0]);
            c[1] = Telerik.Web.UI.Calendar.Utils.MergeClassName(e[1], f[1]);
            c[0] = Telerik.Web.UI.Calendar.Utils.MergeStyles(e[2] || "", c[0]);
            c[1] = Telerik.Web.UI.Calendar.Utils.MergeClassName(e[3] || "", c[1]);
            return c;
        }
        return f;
    },
    ApplyHoverBehavior: function () {
        var a = this.RadCalendar.SpecialDays.Get(this.get_date());
        if (a && !a.IsSelectable) {
            return false;
        }
        if (this.RadCalendar.get_enableRepeatableDaysOnClient()) {
            var b = Telerik.Web.UI.Calendar.Utils.RECURRING_NONE;
            var d = this.RadCalendar.SpecialDays.GetValues();
            for (var c = 0;
            c < d.length;
            c++) {
                b = d[c].IsRecurring(this.get_date(), this.RadCalendarView);
                if (b != Telerik.Web.UI.Calendar.Utils.RECURRING_NONE) {
                    a = d[c];
                    if (!a.IsSelectable) {
                        return false;
                    }
                }
            }
        }
        return true;
    },
    IsRecurring: function (e, c) {
        if (this.Repeatable != Telerik.Web.UI.Calendar.Utils.RECURRING_NONE) {
            switch (this.Repeatable) {
                case Telerik.Web.UI.Calendar.Utils.RECURRING_DAYINMONTH:
                    if (e[2] == this.get_date()[2]) {
                        return this.Repeatable;
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.RECURRING_TODAY:
                    var a = new Date();
                    if ((e[0] == a.getFullYear()) && (e[1] == (a.getMonth() + 1)) && (e[2] == a.getDate())) {
                        return this.Repeatable;
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.RECURRING_DAYANDMONTH:
                    if ((e[1] == this.get_date()[1]) && (e[2] == this.get_date()[2])) {
                        return this.Repeatable;
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.RECURRING_WEEKANDMONTH:
                    var d = new Date();
                    d.setFullYear(e[0], (e[1] - 1), e[2]);
                    var f = new Date();
                    f.setFullYear(this.get_date()[0], (this.get_date()[1] - 1), this.get_date()[2]);
                    if ((d.getDay() == f.getDay()) && (e[1] == this.get_date()[1])) {
                        return this.Repeatable;
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.RECURRING_WEEK:
                    var d = new Date();
                    d.setFullYear(e[0], (e[1] - 1), e[2]);
                    var f = new Date();
                    f.setFullYear(this.get_date()[0], (this.get_date()[1] - 1), this.get_date()[2]);
                    if (d.getDay() == f.getDay()) {
                        return this.Repeatable;
                    }
                    break;
                case Telerik.Web.UI.Calendar.Utils.RECURRING_WEEKDAYWEEKNUMBERANDMONTH:
                    var d = new Date();
                    d.setFullYear(e[0], (e[1] - 1), e[2]);
                    var f = new Date();
                    f.setFullYear(this.get_date()[0], (this.get_date()[1] - 1), this.get_date()[2]);
                    var g = this._getNumberOfWeekDayInMonth(d, c);
                    var b = this._getNumberOfWeekDayInMonth(f, c);
                    if ((e[1] == this.get_date()[1]) && (d.getDay() == f.getDay()) && (g == b)) {
                        return this.Repeatable;
                    }
                    break;
                default:
                    break;
            }
        }
        return Telerik.Web.UI.Calendar.Utils.RECURRING_NONE;
    },
    _getNumberOfWeekDayInMonth: function (g, b) {
        var f = b.DateTimeFormatInfo.CalendarWeekRule;
        var d = b.RadCalendar._firstDayOfWeek;
        var h = b.Calendar.GetWeekOfYear(g, f, d);
        var a = new Date();
        a.setFullYear(g.getFullYear(), g.getMonth(), 1);
        var e = b.Calendar.GetDayOfWeek(g);
        while (e != b.Calendar.GetDayOfWeek(a)) {
            a.setDate(a.getDate() + 1);
        }
        var c = b.Calendar.GetWeekOfYear(a, f, d);
        return h - c;
    },
    get_date: function () {
        return this._date;
    },
    set_date: function (a) {
        if (this._date !== a) {
            this._date = a;
            this.raisePropertyChanged("date");
        }
    },
    get_isSelectable: function () {
        return this.IsSelectable;
    },
    get_isSelected: function () {
        return this.IsSelected;
    },
    get_isToday: function () {
        return this.IsToday;
    },
    get_isWeekend: function () {
        return this.IsWeekend;
    }
};
Telerik.Web.UI.Calendar.RenderDay.registerClass("Telerik.Web.UI.Calendar.RenderDay", null, Sys.IDisposable);

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
