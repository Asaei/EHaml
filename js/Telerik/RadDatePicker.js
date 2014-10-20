Type.registerNamespace("Telerik.Web.UI");
$telerik.findDatePicker = $find;
$telerik.toDatePicker = function (a) {
    return a;
};
Telerik.Web.UI.RadDatePicker = function (a) {
    Telerik.Web.UI.RadDatePicker.initializeBase(this, [a]);
    this._calendar = null;
    this._dateInput = null;
    this._popupButton = null;
    this._validationInput = null;
    this._popupDirection = Telerik.Web.RadDatePickerPopupDirection.BottomRight;
    this._enableScreenBoundaryDetection = true;
    this._zIndex = null;
    this._enableShadows = true;
    this._animationSettings = {};
    this._popupControlID = null;
    this._popupButtonSettings = null;
    this._focusedDate = new Date(1980, 0, 1);
    this._minDate = new Date(1280, 0, 1);
    this._maxDate = new Date(2099, 11, 31);
    this._enabled = true;
    this._originalDisplay = null;
    this._showPopupOnFocus = false;
    this._enableAriaSupport = false;
    this._onPopupImageMouseOverDelegate = null;
    this._onPopupImageMouseOutDelegate = null;
    this._onPopupButtonClickDelegate = null;
    this._onPopupButtonKeyPressDelegate = null;
    this._onDateInputFocusDelegate = null;
};
Telerik.Web.UI.RadDatePicker.PopupInstances = {};
Telerik.Web.UI.RadDatePicker.prototype = {
    initialize: function () {
        Telerik.Web.UI.RadDatePicker.callBaseMethod(this, "initialize");
        this._initializeDateInput();
        this._initializeCalendar();
        var a = $get(this.get_id() + "_wrapper");
        if ($telerik.isIE7 || $telerik.quirksMode) {
            if (a.style.display == "inline-block") {
                a.style.display = "inline";
                a.style.zoom = 1;
            } else {
                if (document.documentMode && document.documentMode > 7 && a.style.display == "inline") {
                    a.style.display = "inline-block";
                    this.get_dateInput().repaint();
                }
            }
        }
        if ($telerik.getCurrentStyle(a, "direction") == "rtl") {
            var b = this.get_dateInput()._skin != "" ? String.format(" RadPickerRTL_{0}", this.get_dateInput()._skin) : "";
            a.className += String.format(" RadPickerRTL{0}", b);
        }
        this._refreshPopupShadowSetting();
        this.CalendarSelectionInProgress = false;
        this.InputSelectionInProgress = false;
        if (this.get_enableAriaSupport()) {
            this._initializeAriaSupport();
        }
    },
    dispose: function () {
        if (this._calendar != null) {
            this.hidePopup();
            this._calendar.dispose();
        }
        if (this._popupButton != null) {
            var a = this.get__popupImage();
            if (a != null) {
                if (this._onPopupImageMouseOverDelegate) {
                    try {
                        $removeHandler(a, "mouseover", this._onPopupImageMouseOverDelegate);
                    } catch (b) { }
                    this._onPopupImageMouseOverDelegate = null;
                }
                if (this._onPopupImageMouseOutDelegate) {
                    try {
                        $removeHandler(a, "mouseout", this._onPopupImageMouseOutDelegate);
                    } catch (b) { }
                    this._onPopupImageMouseOutDelegate = null;
                }
            }
            if (this._onPopupButtonClickDelegate) {
                try {
                    $removeHandler(this._popupButton, "click", this._onPopupButtonClickDelegate);
                } catch (b) { }
                this._onPopupButtonClickDelegate = null;
            }
            if (this._onPopupButtonKeyPressDelegate) {
                try {
                    $removeHandler(this._popupButton, "keypress", this._onPopupButtonKeyPressDelegate);
                } catch (b) { }
                this._onPopupButtonKeyPressDelegate = null;
            }
        }
        if (this._popupButton) {
            this._popupButton._events = null;
        }
        Telerik.Web.UI.RadDatePicker.callBaseMethod(this, "dispose");
    },
    clear: function () {
        if (this._dateInput) {
            this._dateInput.clear();
        }
        if (this._calendar) {
            this._calendar.unselectDates(this._calendar.get_selectedDates());
        }
    },
    _clearHovers: function () {
        var b = this.get_popupContainer().getElementsByTagName("td");
        for (var a = 0;
        a < b.length;
        a++) {
            if (b[a].className && b[a].className.indexOf("rcHover") != -1) {
                b[a].className = b[a].className.replace("rcHover", "");
            }
        }
    },
    togglePopup: function () {
        if (this.isPopupVisible()) {
            this.hidePopup();
        } else {
            this.showPopup();
        }
        return false;
    },
    isPopupVisible: function () {
        if (!this._calendar) {
            return false;
        }
        return this.get__popup().IsVisible() && (this.get__popup().Opener == this);
    },
    showPopup: function (h, j) {
        if (this.isPopupVisible() || !this._calendar) {
            return;
        }
        this._actionBeforeShowPopup();
        this.get__popup().ExcludeFromHiding = this.get__PopupVisibleControls();
        this.hidePopup();
        var c = true;
        var a = new Telerik.Web.UI.DatePickerPopupOpeningEventArgs(this._calendar, false);
        this.raise_popupOpening(a);
        if (a.get_cancel() == true) {
            return;
        }
        c = !a.get_cancelCalendarSynchronization();
        this._clearHovers();
        this.get__popup().Opener = this;
        this.get__popup().Show(h, j, this.get_popupContainer());
        if (c == true) {
            var g = this._dateInput.get_selectedDate();
            if (this.isEmpty() || (!g)) {
                this._focusCalendar();
            } else {
                this._setCalendarDate(g);
            }
        }
        if (this._calendar && !this._calendar._linksHandlersAdded) {
            var e = this._calendar.get_element().getElementsByTagName("a");
            for (var f = 0, d = e.length;
            f < d;
            f++) {
                var b = e[f];
                $addHandlers(b, {
                    click: Function.createDelegate(this, this._click)
                });
            }
            this._calendar._linksHandlersAdded = true;
        }
        if ((this._calendar._enableKeyboardNavigation) && (!this._calendar._enableMultiSelect)) {
            this._calendar.CurrentViews[0].DomTable.tabIndex = 100;
            this._calendar.CurrentViews[0].DomTable.focus();
        }
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
    isEmpty: function () {
        return this._dateInput.isEmpty();
    },
    hidePopup: function () {
        if (!this.get_calendar()) {
            return false;
        }
        this._hideFastNavigationPopup(this);
        if (this.get__popup().IsVisible()) {
            var a = this.get__popup().Hide();
            if (a == false) {
                return false;
            }
        }
        return true;
    },
    getElementDimensions: function (a) {
        return Telerik.Web.UI.Calendar.Utils.GetElementDimensions(a);
    },
    getElementPosition: function (a) {
        return $telerik.getLocation(a);
    },
    get_calendar: function () {
        return this._calendar;
    },
    set_calendar: function (a) {
        this._calendar = a;
    },
    get_popupButton: function () {
        return this._popupButton;
    },
    get_dateInput: function () {
        return this._dateInput;
    },
    set_dateInput: function (a) {
        this._dateInput = a;
    },
    get_textBox: function () {
        return this._dateInput._textBoxElement;
    },
    get_popupContainer: function () {
        if ((this._popupContainer == null)) {
            if (this._popupContainerID) {
                this._popupContainer = $get(this._popupContainerID);
            } else {
                this._popupContainer = null;
            }
        }
        return this._popupContainer;
    },
    get_enabled: function () {
        return this._enabled;
    },
    set_enabled: function (d) {
        if (this._enabled != d) {
            var c = this.get_popupButton();
            var b = this.get__popupImage();
            if (d) {
                this._enabled = true;
                if (this._dateInput) {
                    this._dateInput.enable();
                }
                if (this._calendar) {
                    this._calendar.set_enabled(true);
                }
                if (c) {
                    Sys.UI.DomElement.removeCssClass(c, "rcDisabled");
                    c.setAttribute("href", "#");
                }
                if (this._onPopupButtonClickDelegate) {
                    $addHandler(c, "click", this._onPopupButtonClickDelegate);
                } else {
                    if (c) {
                        this._onPopupButtonClickDelegate = Function.createDelegate(this, this._onPopupButtonClickHandler);
                        $addHandler(c, "click", this._onPopupButtonClickDelegate);
                    }
                }
                if (this._onPopupButtonKeyPressDelegate) {
                    $addHandler(c, "keypress", this._onPopupButtonKeyPressDelegate);
                }
                if (this._onPopupImageMouseOverDelegate) {
                    $addHandler(b, "mouseover", this._onPopupImageMouseOverDelegate);
                }
                if (this._onPopupImageMouseOutDelegate) {
                    $addHandler(b, "mouseout", this._onPopupImageMouseOutDelegate);
                }
                var a = $get(this.get_id() + "_wrapper");
                if (a.attributes.disabled) {
                    a.removeAttribute("disabled");
                }
            } else {
                this.hidePopup();
                this._enabled = false;
                if (this._dateInput) {
                    this._dateInput.disable();
                }
                if (this._onPopupButtonClickDelegate) {
                    $removeHandler(c, "click", this._onPopupButtonClickDelegate);
                }
                if (this._onPopupButtonKeyPressDelegate) {
                    $removeHandler(c, "keypress", this._onPopupButtonKeyPressDelegate);
                }
                if (this._onPopupImageMouseOverDelegate) {
                    $removeHandler(b, "mouseover", this._onPopupImageMouseOverDelegate);
                }
                if (this._onPopupImageMouseOutDelegate) {
                    $removeHandler(b, "mouseout", this._onPopupImageMouseOutDelegate);
                }
                if (c) {
                    Sys.UI.DomElement.addCssClass(c, "rcDisabled");
                    c.removeAttribute("href");
                }
            }
            this.raisePropertyChanged("enabled");
        }
    },
    get_visible: function () {
        var a = $get(this.get_id() + "_wrapper");
        if (a.style.display == "none") {
            return false;
        } else {
            return true;
        }
    },
    set_visible: function (b) {
        var a = $get(this.get_id() + "_wrapper");
        if (b == true && this._originalDisplay != null) {
            a.style.display = this._originalDisplay;
            this.repaint();
        } else {
            if (b == false && this.get_visible()) {
                this._originalDisplay = a.style.display;
                a.style.display = "none";
            }
        }
    },
    get_selectedDate: function () {
        return this._dateInput.get_selectedDate();
    },
    set_selectedDate: function (a) {
        this._dateInput.set_selectedDate(a);
    },
    get_minDate: function () {
        return this._minDate;
    },
    set_minDate: function (d) {
        var b = this._cloneDate(d);
        if (this._minDate.toString() != b.toString()) {
            if (!this._dateInput) {
                this._minDate = b;
            } else {
                var c = false;
                if (this.isEmpty()) {
                    c = true;
                }
                this._minDate = b;
                this._dateInput.set_minDate(b);
                if (this.get_focusedDate() < b) {
                    this.set_focusedDate(b);
                }
                var a = [b.getFullYear(), (b.getMonth() + 1), b.getDate()];
                if (this._calendar) {
                    this._calendar.set_rangeMinDate(a);
                }
            }
            this.updateClientState();
            this.raisePropertyChanged("minDate");
        }
    },
    get_minDateStr: function () {
        var a = this._minDate.getFullYear().toString();
        while (a.length < 4) {
            a = "0" + a;
        }
        return parseInt(this._minDate.getMonth() + 1) + "/" + this._minDate.getDate() + "/" + a + " " + this._minDate.getHours() + ":" + this._minDate.getMinutes() + ":" + this._minDate.getSeconds();
    },
    get_maxDate: function () {
        return this._maxDate;
    },
    set_maxDate: function (c) {
        var a = this._cloneDate(c);
        if (this._maxDate.toString() != a.toString()) {
            if (!this._dateInput) {
                this._maxDate = a;
            } else {
                this._maxDate = a;
                this._dateInput.set_maxDate(a);
                if (this.get_focusedDate() > a) {
                    this.set_focusedDate(a);
                }
                var b = [a.getFullYear(), (a.getMonth() + 1), a.getDate()];
                if (this._calendar) {
                    this._calendar.set_rangeMaxDate(b);
                }
            }
            this.updateClientState();
            this.raisePropertyChanged("maxDate");
        }
    },
    get_maxDateStr: function () {
        var a = this._maxDate.getFullYear().toString();
        while (a.length < 4) {
            a = "0" + a;
        }
        return parseInt(this._maxDate.getMonth() + 1) + "/" + this._maxDate.getDate() + "/" + a + " " + this._maxDate.getHours() + ":" + this._maxDate.getMinutes() + ":" + this._maxDate.getSeconds();
    },
    get_focusedDate: function () {
        return this._focusedDate;
    },
    set_focusedDate: function (a) {
        var b = this._cloneDate(a);
        if (this._focusedDate.toString() != b.toString()) {
            this._focusedDate = b;
            this.raisePropertyChanged("focusedDate");
        }
    },
    get_showPopupOnFocus: function () {

        return (this._calendar._culture == "fa-IR" ? true : this._showPopupOnFocus);
    },
    set_showPopupOnFocus: function (a) {
        this._showPopupOnFocus = a;
    },
    get_enableAriaSupport: function () {
        return this._enableAriaSupport;
    },
    set_enableAriaSupport: function (a) {
        if (this._enableAriaSupport != a) {
            this._enableAriaSupport = a;
        }
    },
    repaint: function () {
        this._updatePercentageHeight();
    },
    get_popupDirection: function () {
        return this._popupDirection;
    },
    set_popupDirection: function (a) {
        this._popupDirection = a;
    },
    get_enableScreenBoundaryDetection: function () {
        return this._enableScreenBoundaryDetection;
    },
    set_enableScreenBoundaryDetection: function (a) {
        this._enableScreenBoundaryDetection = a;
    },
    saveClientState: function (f) {
        var b = ["minDateStr", "maxDateStr"];
        if (f) {
            for (var e = 0, c = f.length;
            e < c;
            e++) {
                b[b.length] = f[e];
            }
        }
        var d = {};
        var a;
        for (var e = 0;
        e < b.length;
        e++) {
            a = b[e];
            switch (a) {
                case "minDateStr":
                    d[a] = this.get_minDate().format("yyyy-MM-dd-HH-mm-ss");
                    break;
                case "maxDateStr":
                    d[a] = this.get_maxDate().format("yyyy-MM-dd-HH-mm-ss");
                    break;
                default:
                    d[a] = this["get_" + a]();
                    break;
            }
        }
        return Sys.Serialization.JavaScriptSerializer.serialize(d);
    },
    _initializeDateInput: function () {
        if (this._dateInput != null && (!this._dateInput.get_owner)) {
            var a = this;
            this._dateInput.get_owner = function () {
                return a;
            };
            this._dateInput.Owner = this;
            this._setUpValidationInput();
            this._setUpDateInput();
            this._propagateRangeValues();
            this._initializePopupButton();
        }
        this._updatePercentageHeight();
    },
    _updatePercentageHeight: function () {
        var a = $get(this.get_id() + "_wrapper");
        if (a.style.height.indexOf("%") != -1 && a.offsetHeight > 0) {
            var b = 0;
            if (this.get_dateInput()._textBoxElement.currentStyle) {
                b = parseInt(this.get_dateInput()._textBoxElement.currentStyle.borderTopWidth) + parseInt(this.get_dateInput()._textBoxElement.currentStyle.borderBottomWidth) + parseInt(this.get_dateInput()._textBoxElement.currentStyle.paddingTop) + parseInt(this.get_dateInput()._textBoxElement.currentStyle.paddingBottom);
            } else {
                if (window.getComputedStyle) {
                    b = parseInt(window.getComputedStyle(this.get_dateInput()._textBoxElement, null).getPropertyValue("border-top-width")) + parseInt(window.getComputedStyle(this.get_dateInput()._textBoxElement, null).getPropertyValue("border-bottom-width")) + parseInt(window.getComputedStyle(this.get_dateInput()._textBoxElement, null).getPropertyValue("padding-top")) + parseInt(window.getComputedStyle(this.get_dateInput()._textBoxElement, null).getPropertyValue("padding-bottom"));
                }
            }
            this.get_dateInput()._textBoxElement.style.height = "1px";
            this.get_dateInput()._textBoxElement.style.cssText = this.get_dateInput()._textBoxElement.style.cssText;
            this.get_dateInput()._textBoxElement.style.height = a.offsetHeight - b + "px";
            if (this.get_dateInput()._originalTextBoxCssText.search(/(^|[^-])height/) != -1) {
                this.get_dateInput()._originalTextBoxCssText = this.get_dateInput()._originalTextBoxCssText.replace(/(^|[^-])height(\s*):(\s*)([^;]+);/i, "$1height:" + (a.offsetHeight - b) + "px;");
            } else {
                this.get_dateInput()._originalTextBoxCssText += "height:" + (a.offsetHeight - b) + "px;";
            }
        }
    },
    _initializeCalendar: function () {
        if (this._calendar != null) {
            this._setUpCalendar();
            this._calendar.set_enableMultiSelect(false);
            this._calendar.set_useColumnHeadersAsSelectors(false);
            this._calendar.set_useRowHeadersAsSelectors(false);
            if (this._zIndex) {
                this._calendar._zIndex = parseInt(this._zIndex, 10) + 2;
            }
            this._calendar._enableShadows = this._enableShadows;
            this._popupContainerID = this._calendar.get_id() + "_wrapper";
        }
    },
    _propagateRangeValues: function () {
        if (this.get_minDate().toString() != new Date(1280, 0, 1)) {
            this._dateInput._minDate = this.get_minDate();
        }
        if (this.get_maxDate().toString() != new Date(2099, 11, 31)) {
            this._dateInput._maxDate = this.get_maxDate();
        }
    },
    _triggerDomChangeEvent: function () {
        this._dateInput._triggerDomEvent("change", this._validationInput);
    },
    _initializeAriaSupport: function () {
        var a = document.getElementById(this.get_id() + "_wrapper");
        a.setAttribute("aria-atomic", "true");
        var b = document.getElementById(this.get_id() + "_popupButton");
        if (b) {
            b.setAttribute("aria-controls", this.get_calendar().get_id() + "_wrapper");
        }
    },
    _initializePopupButton: function () {
        this._popupButton = $get(this._popupControlID);
        if (this._popupButton != null) {
            this._attachPopupButtonEvents();
        }
    },
    _attachPopupButtonEvents: function () {
        var a = this.get__popupImage();
        var b = this;
        if (a != null) {
            if (!this._hasAttribute("onmouseover")) {
                this._onPopupImageMouseOverDelegate = Function.createDelegate(this, this._onPopupImageMouseOverHandler);
                $addHandler(a, "mouseover", this._onPopupImageMouseOverDelegate);
            }
            if (!this._hasAttribute("onmouseout")) {
                this._onPopupImageMouseOutDelegate = Function.createDelegate(this, this._onPopupImageMouseOutHandler);
                $addHandler(a, "mouseout", this._onPopupImageMouseOutDelegate);
            }
        }
        if (this._hasAttribute("href") != null && this._hasAttribute("href") != "" && this._hasAttribute("onclick") == null) {
            this._onPopupButtonClickDelegate = Function.createDelegate(this, this._onPopupButtonClickHandler);
            $addHandler(this._popupButton, "click", this._onPopupButtonClickDelegate);
        }
        if (this._popupButton) {
            this._onPopupButtonKeyPressDelegate = Function.createDelegate(this, this._onPopupButtonKeyPressHandler);
            $addHandler(this._popupButton, "keypress", this._onPopupButtonKeyPressDelegate);
        }
    },
    _onPopupImageMouseOverHandler: function (a) {
        this.get__popupImage().src = this._popupButtonSettings.ResolvedHoverImageUrl;
    },
    _onPopupImageMouseOutHandler: function (a) {
        this.get__popupImage().src = this._popupButtonSettings.ResolvedImageUrl;
    },
    _onPopupButtonClickHandler: function (a) {
        this.togglePopup();
        a.stopPropagation();
        a.preventDefault();
        return false;
    },
    _onPopupButtonKeyPressHandler: function (a) {
        if (a.charCode == 32) {
            this.togglePopup();
            a.stopPropagation();
            a.preventDefault();
            return false;
        }
    },
    _hasAttribute: function (a) {
        return this._popupButton.getAttribute(a);
    },
    _calendarDateSelected: function (a) {
        if (this.InputSelectionInProgress == true) {
            return;
        }
        if (a.IsSelected) {
            if (this.hidePopup() == false) {
                return;
            }
            var b = this._getJavaScriptDate(a.get_date());
            this.CalendarSelectionInProgress = true;
            this._setInputDate(b);
        }
    },
    _actionBeforeShowPopup: function () {
        for (var b in Telerik.Web.UI.RadDatePicker.PopupInstances) {
            if (Telerik.Web.UI.RadDatePicker.PopupInstances.hasOwnProperty(b)) {
                var a = Telerik.Web.UI.RadDatePicker.PopupInstances[b].Opener;
                this._hideFastNavigationPopup(a);
                Telerik.Web.UI.RadDatePicker.PopupInstances[b].Hide();
            }
        }
    },
    _hideFastNavigationPopup: function (a) {
        if (a) {
            var b = a.get_calendar()._getFastNavigation().Popup;
            if (b && b.IsVisible()) {
                b.Hide(true);
            }
        }
    },
    _setInputDate: function (a) {
        this._dateInput.set_selectedDate(a);
    },
    _getJavaScriptDate: function (a) {
        if (this._calendar._culture == "fa-IR") a = ShamsiToMiladi(a[0], a[1], a[2]);
        var b = new Date();
        b.setFullYear(a[0], a[1] - 1, a[2]);
        return b;
    },
    _onDateInputDateChanged: function (a, b) {
        this._setValidatorDate(b.get_newDate());
        this._triggerDomChangeEvent();
        if (!this.isPopupVisible()) {
            return;
        }
        if (this.isEmpty()) {
            this._focusCalendar();
        } else {
            if (!this.CalendarSelectionInProgress) {
                this._setCalendarDate(b.get_newDate());
            }
        }
    },
    _focusCalendar: function () {
        this._calendar.unselectDates(this._calendar.get_selectedDates());
        var a = [this.get_focusedDate().getFullYear(), this.get_focusedDate().getMonth() + 1, this.get_focusedDate().getDate()];
        this._calendar.navigateToDate(a);
    },
    _setValidatorDate: function (d) {
        var a = "";
        if (d != null) {
            var c = (d.getMonth() + 1).toString();
            if (c.length == 1) {
                c = "0" + c;
            }
            var b = d.getDate().toString();
            if (b.length == 1) {
                b = "0" + b;
            }
            a = d.getFullYear() + "-" + c + "-" + b;
        }
        this._validationInput.value = a;
    },
    _setCalendarDate: function (b) {
        var c = [b.getFullYear(), b.getMonth() + 1, b.getDate()];
        var a = (this._calendar.FocusedDate[1] != c[1]) || (this._calendar.FocusedDate[0] != c[0]);
        this.InputSelectionInProgress = true;
        this._calendar.unselectDates(this._calendar.get_selectedDates());
        this._calendar.selectDate(c, a);
        this.InputSelectionInProgress = false;
    },
    _cloneDate: function (c) {
        var b = null;
        if (!c) {
            return null;
        }
        if (typeof (c.setFullYear) == "function") {
            b = [];
            b[b.length] = c.getFullYear();
            b[b.length] = c.getMonth() + 1;
            b[b.length] = c.getDate();
            b[b.length] = c.getHours();
            b[b.length] = c.getMinutes();
            b[b.length] = c.getSeconds();
            b[b.length] = c.getMilliseconds();
        } else {
            if (typeof (c) == "string") {
                b = c.split(/-/);
            }
        }
        if (b != null) {
            var a = new Date();
            a.setDate(1);
            a.setFullYear(b[0]);
            a.setMonth(b[1] - 1);
            a.setDate(b[2]);
            a.setHours(b[3]);
            a.setMinutes(b[4]);
            a.setSeconds(b[5]);
            a.setMilliseconds(0);
            return a;
        }
        return null;
    },
    _setUpValidationInput: function () {
        this._validationInput = $get(this.get_id());
    },
    _setUpDateInput: function () {
        this._onDateInputValueChangedDelegate = Function.createDelegate(this, this._onDateInputValueChangedHandler);
        this._dateInput.add_valueChanged(this._onDateInputValueChangedDelegate);
        this._onDateInputBlurDelegate = Function.createDelegate(this, this._onDateInputBlurHandler);
        this._dateInput.add_blur(this._onDateInputBlurDelegate);
        this._onDateInputKeyPressDelegate = Function.createDelegate(this, this._onDateInputKeyPressHandler);
        this._dateInput.add_keyPress(this._onDateInputKeyPressDelegate);
        this._onDateInputFocusDelegate = Function.createDelegate(this, this._onDateInputFocusHandler);
        this._dateInput.add_focus(this._onDateInputFocusDelegate);
    },
    _onDateInputValueChangedHandler: function (a, b) {
        this._onDateInputDateChanged(a, b);
        this.raise_dateSelected(b);
        this.CalendarSelectionInProgress = false;
    },
    _onDateInputBlurHandler: function (a, b) {
        if (!a.get_selectedDate()) {
            this._validationInput.value = "";
        }
    },
    _onDateInputFocusHandler: function (a, b) {
        if (this._calendar && this.get_showPopupOnFocus()) {
            this.showPopup();
        }

        //mydnn
        //if (this._calendar) {
        //    if (this._calendar._culture == "fa-IR")
        //        if (a._value) {
        //            //$("#" + a._clientID).val(MiladiToShamsi(a._value.getFullYear(), a._value.getMonth()+1, a._value.getDay()));
        //        }
        //}
    },
    _triggerDomEvent: function (a, c) {
        if (!a || a == "" || !c) {
            return;
        }
        if (c.fireEvent && document.createEventObject) {
            var d = document.createEventObject();
            c.fireEvent(String.format("on{0}", a), d);
        } else {
            if (c.dispatchEvent) {
                var b = true;
                var d = document.createEvent("HTMLEvents");
                d.initEvent(a, b, true);
                c.dispatchEvent(d);
            }
        }
    },
    _onDateInputKeyPressHandler: function (a, b) {
        if (b.get_keyCode() == 13) {
            this._setValidatorDate(a.get_selectedDate());
        }
    },
    _setUpCalendar: function () {
        this._onCalendarDateSelectedDelegate = Function.createDelegate(this, this._onCalendarDateSelectedHandler);
        this._calendar.add_dateSelected(this._onCalendarDateSelectedDelegate);
    },
    _onCalendarDateSelectedHandler: function (a, b) {
        if (this.isPopupVisible()) {
            this._calendarDateSelected(b.get_renderDay());
        }
    },
    get__popupImage: function () {
        var a = null;
        if (this._popupButton != null) {
            var b = this._popupButton.getElementsByTagName("img");
            if (b.length > 0) {
                a = b[0];
            } else {
                a = this._popupButton;
            }
        }
        return a;
    },
    _refreshPopupShadowSetting: function () {
        if (!this.get_calendar()) {
            return;
        }
        var a = Telerik.Web.UI.RadDatePicker.PopupInstances[this.get_calendar().get_id()];
        if (a && !$telerik.quirksMode) {
            this.get__popup().EnableShadows = this._enableShadows;
        }
    },
    get__popup: function () {
        var a = Telerik.Web.UI.RadDatePicker.PopupInstances[this.get_calendar().get_id()];
        if (!a) {
            a = new Telerik.Web.UI.Calendar.Popup();
            if (this._zIndex) {
                a.zIndex = this._zIndex;
            }
            if (!this._enableShadows) {
                a.EnableShadows = false;
            }
            if (this._animationSettings) {
                a.ShowAnimationDuration = this._animationSettings.ShowAnimationDuration;
                a.ShowAnimationType = this._animationSettings.ShowAnimationType;
                a.HideAnimationDuration = this._animationSettings.HideAnimationDuration;
                a.HideAnimationType = this._animationSettings.HideAnimationType;
            }
            Telerik.Web.UI.RadDatePicker.PopupInstances[this._calendar.get_id()] = a;
        }
        return a;
    },
    get__PopupVisibleControls: function () {
        var a = [this.get_textBox(), this.get_popupContainer()];
        if (this._popupButton != null) {
            a[a.length] = this._popupButton;
        }
        return a;
    },
    get__PopupButtonSettings: function () {
        return this._popupButtonSettings;
    },
    set__PopupButtonSettings: function (a) {
        this._popupButtonSettings = a;
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
    add_popupOpening: function (a) {
        this.get_events().addHandler("popupOpening", a);
    },
    remove_popupOpening: function (a) {
        this.get_events().removeHandler("popupOpening", a);
    },
    raise_popupOpening: function (a) {
        this.raiseEvent("popupOpening", a);
    },
    add_popupClosing: function (a) {
        this.get_events().addHandler("popupClosing", a);
    },
    remove_popupClosing: function (a) {
        this.get_events().removeHandler("popupClosing", a);
    },
    raise_popupClosing: function (a) {
        this.raiseEvent("popupClosing", a);
    }
};
Telerik.Web.UI.RadDatePicker.registerClass("Telerik.Web.UI.RadDatePicker", Telerik.Web.UI.RadWebControl);

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
