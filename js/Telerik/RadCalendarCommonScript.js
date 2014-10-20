Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.CalendarClickEventArgs = function (a, b) {
    Telerik.Web.UI.CalendarClickEventArgs.initializeBase(this);
    this._domElement = a;
    this._index = b;
};
Telerik.Web.UI.CalendarClickEventArgs.prototype = {
    get_domElement: function () {
        return this._domElement;
    },
    get_index: function () {
        return this._index;
    }
};
Telerik.Web.UI.CalendarClickEventArgs.registerClass("Telerik.Web.UI.CalendarClickEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.CalendarDayRenderEventArgs = function (c, b, a) {
    Telerik.Web.UI.CalendarDayRenderEventArgs.initializeBase(this);
    this._cell = c;
    this._date = b;
    this._renderDay = a;
};
Telerik.Web.UI.CalendarDayRenderEventArgs.prototype = {
    get_cell: function () {
        return this._cell;
    },
    get_date: function () {
        return this._date;
    },
    get_renderDay: function () {
        return this._renderDay;
    }
};
Telerik.Web.UI.CalendarDayRenderEventArgs.registerClass("Telerik.Web.UI.CalendarDayRenderEventArgs", Sys.EventArgs);
Telerik.Web.UI.CalendarDateClickEventArgs = function (b, a) {
    Telerik.Web.UI.CalendarDateClickEventArgs.initializeBase(this);
    this._domEvent = b;
    this._renderDay = a;
};
Telerik.Web.UI.CalendarDateClickEventArgs.prototype = {
    get_domEvent: function () {
        return this._domEvent;
    },
    get_renderDay: function () {
        return this._renderDay;
    }
};
Telerik.Web.UI.CalendarDateClickEventArgs.registerClass("Telerik.Web.UI.CalendarDateClickEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.CalendarDateSelectingEventArgs = function (a, b) {
    Telerik.Web.UI.CalendarDateSelectingEventArgs.initializeBase(this);
    this._isSelecting = a;
    this._renderDay = b;
};
Telerik.Web.UI.CalendarDateSelectingEventArgs.prototype = {
    get_isSelecting: function () {
        return this._isSelecting;
    },
    get_renderDay: function () {
        return this._renderDay;
    }
};
Telerik.Web.UI.CalendarDateSelectingEventArgs.registerClass("Telerik.Web.UI.CalendarDateSelectingEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.CalendarDateSelectedEventArgs = function (a) {
    Telerik.Web.UI.CalendarDateSelectedEventArgs.initializeBase(this);
    this._renderDay = a;
};
Telerik.Web.UI.CalendarDateSelectedEventArgs.prototype = {
    get_renderDay: function () {
        return this._renderDay;
    }
};
Telerik.Web.UI.CalendarDateSelectedEventArgs.registerClass("Telerik.Web.UI.CalendarDateSelectedEventArgs", Sys.EventArgs);
Telerik.Web.UI.CalendarViewChangingEventArgs = function (a) {
    Telerik.Web.UI.CalendarViewChangingEventArgs.initializeBase(this);
    this._step = a;
};
Telerik.Web.UI.CalendarViewChangingEventArgs.prototype = {
    get_step: function () {
        return this._step;
    }
};
Telerik.Web.UI.CalendarViewChangingEventArgs.registerClass("Telerik.Web.UI.CalendarViewChangingEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.CalendarViewChangedEventArgs = function (a) {
    Telerik.Web.UI.CalendarViewChangedEventArgs.initializeBase(this);
    this._step = a;
};
Telerik.Web.UI.CalendarViewChangedEventArgs.prototype = {
    get_step: function () {
        return this._step;
    }
};
Telerik.Web.UI.CalendarViewChangedEventArgs.registerClass("Telerik.Web.UI.CalendarViewChangedEventArgs", Sys.EventArgs);
Telerik.Web.UI.DatePickerPopupOpeningEventArgs = function (a, b) {
    Telerik.Web.UI.DatePickerPopupOpeningEventArgs.initializeBase(this);
    this._popupControl = a;
    this._cancelCalendarSynchronization = b;
};
Telerik.Web.UI.DatePickerPopupOpeningEventArgs.prototype = {
    get_popupControl: function () {
        return this._popupControl;
    },
    get_cancelCalendarSynchronization: function () {
        return this._cancelCalendarSynchronization;
    },
    set_cancelCalendarSynchronization: function (a) {
        if (this._cancelCalendarSynchronization !== a) {
            this._cancelCalendarSynchronization = a;
        }
    }
};
Telerik.Web.UI.DatePickerPopupOpeningEventArgs.registerClass("Telerik.Web.UI.DatePickerPopupOpeningEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.DatePickerPopupClosingEventArgs = function (a) {
    Telerik.Web.UI.DatePickerPopupClosingEventArgs.initializeBase(this);
    this._popupControl = a;
};
Telerik.Web.UI.DatePickerPopupClosingEventArgs.prototype = {
    get_popupControl: function () {
        return this._popupControl;
    }
};
Telerik.Web.UI.DatePickerPopupClosingEventArgs.registerClass("Telerik.Web.UI.DatePickerPopupClosingEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.TimeViewSelectedEventArgs = function (a, b) {
    Telerik.Web.UI.TimeViewSelectedEventArgs.initializeBase(this);
    this._newTime = a;
    this._oldTime = b;
};
Telerik.Web.UI.TimeViewSelectedEventArgs.prototype = {
    get_newTime: function () {
        return this._newTime;
    },
    get_oldTime: function () {
        return this._oldTime;
    }
};
Telerik.Web.UI.TimeViewSelectedEventArgs.registerClass("Telerik.Web.UI.TimeViewSelectedEventArgs", Sys.EventArgs);
Telerik.Web.UI.TimeViewSelectingEventArgs = function (a, b) {
    Telerik.Web.UI.TimeViewSelectingEventArgs.initializeBase(this);
    this._newTime = a;
    this._oldTime = b;
};
Telerik.Web.UI.TimeViewSelectingEventArgs.prototype = {
    get_newTime: function () {
        return this._newTime;
    },
    get_oldTime: function () {
        return this._oldTime;
    }
};
Telerik.Web.UI.TimeViewSelectingEventArgs.registerClass("Telerik.Web.UI.TimeViewSelectingEventArgs", Sys.CancelEventArgs);
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.PresentationType = function () { };
Telerik.Web.UI.Calendar.PresentationType.prototype = {
    Interactive: 1,
    Preview: 2
};
Telerik.Web.UI.Calendar.PresentationType.registerEnum("Telerik.Web.UI.Calendar.PresentationType", false);
Telerik.Web.UI.Calendar.FirstDayOfWeek = function () { };
Telerik.Web.UI.Calendar.FirstDayOfWeek.prototype = {
    Monday: 1,
    Tuesday: 2,
    Wednesday: 3,
    Thursday: 4,
    Friday: 5,
    Saturday: 6,
    Sunday: 7
};
Telerik.Web.UI.Calendar.FirstDayOfWeek.registerEnum("Telerik.Web.UI.Calendar.FirstDayOfWeek", false);
Telerik.Web.UI.Calendar.Orientation = function () { };
Telerik.Web.UI.Calendar.Orientation.prototype = {
    RenderInRows: 1,
    RenderInColumns: 2
};
Telerik.Web.UI.Calendar.Orientation.registerEnum("Telerik.Web.UI.Calendar.Orientation", false);
Telerik.Web.UI.Calendar.AutoPostBackControl = function () { };
Telerik.Web.UI.Calendar.AutoPostBackControl.prototype = {
    None: 0,
    Both: 1,
    TimeView: 2,
    Calendar: 3
};
Telerik.Web.UI.Calendar.AutoPostBackControl.registerEnum("Telerik.Web.UI.Calendar.AutoPostBackControl", false);
Telerik.Web.UI.Calendar.RangeSelectionMode = function () { };
Telerik.Web.UI.Calendar.RangeSelectionMode.prototype = {
    None: 0,
    OnKeyHold: 1,
    ConsecutiveClicks: 2
};
Telerik.Web.UI.Calendar.RangeSelectionMode.registerEnum("Telerik.Web.UI.Calendar.RangeSelectionMode", false);
if (typeof (window.RadCalendarNamespace) == "undefined") {
    window.RadCalendarNamespace = {};
}
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.CalendarAnimationType = function () {
    throw Error.invalidOperation();
};
Telerik.Web.UI.CalendarAnimationType.prototype = {
    Fade: 1,
    Slide: 2
};
Telerik.Web.UI.CalendarAnimationType.registerEnum("Telerik.Web.UI.CalendarAnimationType");
Telerik.Web.UI.Calendar.Popup = function () {
    this.DomElement = null;
    this.ExcludeFromHiding = [];
    this.zIndex = null;
    this.ShowAnimationDuration = 300;
    this.ShowAnimationType = Telerik.Web.UI.CalendarAnimationType.Fade;
    this.HideAnimationDuration = 300;
    this.HideAnimationType = Telerik.Web.UI.CalendarAnimationType.Fade;
    this.EnableShadows = true;
    if ($telerik.quirksMode || $telerik.isIE6) {
        this.EnableShadows = false;
    }
};
Telerik.Web.UI.Calendar.Popup.zIndex = 5000;
Telerik.Web.UI.Calendar.Popup.cssClass = "RadCalendarPopup";
Telerik.Web.UI.Calendar.Popup.secondaryCssClass = "RadCalendarFastNavPopup";
Telerik.Web.UI.Calendar.Popup.shadowCssClass = "RadCalendarPopupShadows";
Telerik.Web.UI.Calendar.Popup.prototype = {
    CreateContainer: function (a) {
        var b = document.createElement("div");
        if (a == "table") {
            b.className = Telerik.Web.UI.Calendar.Popup.secondaryCssClass;
        } else {
            b.className = Telerik.Web.UI.Calendar.Popup.cssClass;
        }
        if (this.EnableShadows) {
            b.className += " " + Telerik.Web.UI.Calendar.Popup.shadowCssClass;
        }
        var c = RadHelperUtils.GetStyleObj(b);
        c.position = "absolute";
        if (navigator.userAgent.match(/Safari/)) {
            c.visibility = "hidden";
            c.left = "-1000px";
        } else {
            c.display = "none";
        }
        c.border = "0";
        if (this.zIndex) {
            c.zIndex = this.zIndex;
        } else {
            c.zIndex = Telerik.Web.UI.Calendar.Popup.zIndex;
            Telerik.Web.UI.Calendar.Popup.zIndex += 2;
        }
        b.onclick = function (d) {
            if (!d) {
                d = window.event;
            }
            d.returnValue = false;
            d.cancelBubble = true;
            if (d.stopPropagation) {
                d.stopPropagation();
            }
            return false;
        };
        if (this.EnableShadows) {
            b.innerHTML = '<div class="rcShadTR"></div><div class="rcShadBL"></div><div class="rcShadBR"></div>';
        }
        document.body.insertBefore(b, document.body.firstChild);
        return b;
    },
    RemoveScriptsOnOpera: function (b) {
        if (window.opera) {
            var d = b.getElementsByTagName("*");
            for (var c = 0;
            c < d.length;
            c++) {
                var a = d[c];
                if (a.tagName != null && a.tagName.toLowerCase() == "script") {
                    a.parentNode.removeChild(a);
                }
            }
        }
    },
    Show: function (r, j, c, i) {
        if (this.IsVisible()) {
            this.Hide();
        }
        this.ExitFunc = ("function" == typeof (i) ? i : null);
        var e = this.DomElement;
        if (!e) {
            e = this.CreateContainer(c.tagName.toLowerCase());
            this.DomElement = e;
        } else {
            $telerik.$(e).stop(true, true);
        }
        if ($telerik.isIE && this.EnableShadows && e.className.indexOf("rcIE") == -1) {
            Sys.UI.DomElement.addCssClass(e, "rcIE");
        }
        if (c) {
            if (this.EnableShadows) {
                e.innerHTML = '<div class="rcShadTR"></div><div class="rcShadBL"></div><div class="rcShadBR"></div>';
            } else {
                e.innerHTML = "";
            }
            if (c.nextSibling) {
                this.Sibling = c.nextSibling;
            }
            this.Parent = c.parentNode;
            this.RemoveScriptsOnOpera(c);
            e.appendChild(c);
            if (navigator.userAgent.match(/Safari/) && c.style.visibility == "hidden") {
                c.style.visibility = "visible";
                c.style.position = "";
                c.style.left = "";
            } else {
                if (c.style.display == "none") {
                    c.style.display = "";
                }
            }
        }
        var h = $telerik.getViewPortSize();
        var g = Telerik.Web.UI.Calendar.Utils.GetElementDimensions(e);
        if (this.EnableShadows) {
            var f = $telerik.getChildByClassName(e, "rcShadTR");
            var n = $telerik.getChildByClassName(e, "rcShadBL");
            if (f && n) {
                f.style.height = g.height - parseInt($telerik.getCurrentStyle(e, "paddingBottom"), 10) + "px";
                n.style.width = g.width - parseInt($telerik.getCurrentStyle(e, "paddingRight"), 10) + "px";
            }
        }
        if ((typeof (r) == "undefined" || typeof (j) == "undefined") && this.Opener) {
            var b = this.Opener.get_textBox();
            var q;
            var l;
            if (b && b.offsetWidth > 0) {
                l = b;
            } else {
                if (c && c.id.indexOf("_timeView_wrapper") != -1) {
                    q = this.Opener.get__timePopupImage();
                } else {
                    q = this.Opener.get__popupImage();
                }
            }
            if (q && q.offsetWidth > 0) {
                l = q;
            } else {
                if (!b || b.offsetWidth == 0) {
                    l = this.Opener.get_element();
                }
            }
            var k = $telerik.$(l).offset();
            var m = {
                x: k.left,
                y: k.top
            };
            var o = parseInt(this.Opener.get_popupDirection(), 10);
            switch (o) {
                case Telerik.Web.RadDatePickerPopupDirection.TopRight:
                    r = m.x;
                    j = m.y - g.height;
                    if (this.Opener.get_enableScreenBoundaryDetection()) {
                        if (this.OverFlowsRight(h, g.width, m.x) && m.x - (g.width - l.offsetWidth) >= 0) {
                            r = m.x - (g.width - l.offsetWidth);
                        }
                        if (j < 0) {
                            j = m.y + l.offsetHeight;
                        }
                    }
                    break;
                case Telerik.Web.RadDatePickerPopupDirection.BottomLeft:
                    r = m.x - (g.width - l.offsetWidth);
                    j = m.y + l.offsetHeight;
                    if (this.Opener.get_enableScreenBoundaryDetection()) {
                        if (r < 0) {
                            r = m.x;
                        }
                        if (this.OverFlowsBottom(h, g.height, j) && m.y - g.height >= 0) {
                            j = m.y - g.height;
                        }
                    }
                    break;
                case Telerik.Web.RadDatePickerPopupDirection.TopLeft:
                    r = m.x - (g.width - l.offsetWidth);
                    j = m.y - g.height;
                    if (this.Opener.get_enableScreenBoundaryDetection()) {
                        if (r < 0) {
                            r = m.x;
                        }
                        if (j < 0) {
                            j = m.y + l.offsetHeight;
                        }
                    }
                    break;
                default:
                    r = m.x;
                    j = m.y + l.offsetHeight;
                    if (this.Opener.get_enableScreenBoundaryDetection()) {
                        if (this.OverFlowsRight(h, g.width, m.x) && m.x - (g.width - l.offsetWidth) >= 0) {
                            r = m.x - (g.width - l.offsetWidth);
                        }
                        if (this.OverFlowsBottom(h, g.height, j) && m.y - g.height >= 0) {
                            j = m.y - g.height;
                        }
                    }
                    break;
            }
        } else {
            if ((c.id.indexOf("FastNavPopup") != -1 || c.id.indexOf("MonthYearTableViewID") != -1) && this.EnableScreenBoundaryDetection) {
                if (r + g.width > h.width && r - g.width >= 0) {
                    r = r - g.width;
                }
            }
        }
        var a = RadHelperUtils.GetStyleObj(e);
        a.left = parseInt(r, 10) + "px";
        a.top = parseInt(j, 10) + "px";
        if (typeof (this.ShowAnimationDuration) == "number" && this.ShowAnimationDuration > 0) {
            if (navigator.userAgent.match(/Safari/)) {
                a.visibility = "visible";
            }
            var d = this;
            removeFilterStyleinIE = function () {
                d.RemoveFilterStyle();
            };
            this._animate(true, removeFilterStyleinIE);
        } else {
            if (navigator.userAgent.match(/Safari/)) {
                a.visibility = "visible";
            } else {
                a.display = "";
            }
        }
        RadHelperUtils.ProcessIframe(e, true);
        this.OnClickFunc = Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnClick, this);
        this.OnKeyPressFunc = Telerik.Web.UI.Calendar.Utils.AttachMethod(this.OnKeyPress, this);
        var p = this;
        window.setTimeout(function () {
            RadHelperUtils.AttachEventListener(document, "click", p.OnClickFunc);
            RadHelperUtils.AttachEventListener(document, "keypress", p.OnKeyPressFunc);
        }, 300);
    },
    Hide: function (a) {
        var b = this.Opener;
        if (b) {
            var f;
            var e = b.constructor.__typeName;
            if (e == "Telerik.Web.UI.RadDateTimePicker" || e == "Telerik.Web.UI.RadDatePicker") {
                if (b.get__TimePopup) {
                    var g = b.get__TimePopup();
                    if (g && g.IsVisible()) {
                        f = new Telerik.Web.UI.DatePickerPopupClosingEventArgs(b.get_timeView());
                    }
                }
                if (b.get_calendar && b.get_calendar() && b.get__popup) {
                    var g = b.get__popup();
                    if (g && g.IsVisible()) {
                        f = new Telerik.Web.UI.DatePickerPopupClosingEventArgs(b._calendar);
                    }
                }
            }
            if (e == "Telerik.Web.UI.RadMonthYearPicker") {
                var g = b.Popup;
                if (g && g.IsVisible()) {
                    f = new Telerik.Web.UI.MonthYearPickerPopupClosingEventArgs(b);
                }
            }
            if (f) {
                b.raise_popupClosing(f);
                if (f.get_cancel()) {
                    return false;
                }
            }
            this.Opener = null;
        }
        var c = this.DomElement;
        var d = RadHelperUtils.GetStyleObj(c);
        if (c) {
            $telerik.$(c).stop(true, true);
            if ($telerik.isIE && this.EnableShadows && c.className.indexOf("rcIE") == -1) {
                Sys.UI.DomElement.addCssClass(c, "rcIE");
            }
        }
        var h = this;
        removeDiv = function () {
            if (c) {
                if (h.EnableShadows) {
                    var k = $telerik.getChildByClassName(c, "rcShadTR");
                    if (k) {
                        c.removeChild(k);
                    }
                    var i = $telerik.getChildByClassName(c, "rcShadBL");
                    if (i) {
                        c.removeChild(i);
                    }
                    var j = $telerik.getChildByClassName(c, "rcShadBR");
                    if (j) {
                        c.removeChild(j);
                    }
                }
                if (navigator.userAgent.match(/Safari/)) {
                    d.visibility = "hidden";
                    d.position = "absolute";
                    d.left = "-1000px";
                } else {
                    d.display = "none";
                }
                d = null;
                if (c.childNodes.length != 0) {
                    if (navigator.userAgent.match(/Safari/)) {
                        c.childNodes[0].style.visibility = "hidden";
                        c.childNodes[0].style.position = "absolute";
                        c.childNodes[0].style.left = "-1000px";
                    } else {
                        c.childNodes[0].style.display = "none";
                    }
                }
                var l = c.childNodes[0];
                if (l != null) {
                    c.removeChild(l);
                    if (h.Parent != null) {
                        h.Parent.appendChild(l);
                    } else {
                        if (h.Sibling != null) {
                            var m = h.Sibling.parentNode;
                            if (m != null) {
                                m.insertBefore(l, h.Sibling);
                            }
                        }
                    }
                    if (navigator.userAgent.match(/Safari/)) {
                        RadHelperUtils.GetStyleObj(l).visibility = "hidden";
                        RadHelperUtils.GetStyleObj(l).position = "absolute";
                        RadHelperUtils.GetStyleObj(l).left = "-1000px";
                    } else {
                        RadHelperUtils.GetStyleObj(l).display = "none";
                    }
                }
                RadHelperUtils.ProcessIframe(c, false);
            }
        };
        if (c && typeof (this.HideAnimationDuration) == "number" && this.HideAnimationDuration > 0) {
            this._animate(false, removeDiv);
        } else {
            removeDiv();
        }
        if (this.OnClickFunc != null) {
            RadHelperUtils.DetachEventListener(document, "click", this.OnClickFunc);
            this.OnClickFunc = null;
        }
        if (this.OnKeyPressFunc != null) {
            RadHelperUtils.DetachEventListener(document, "keydown", this.OnKeyPressFunc);
            this.OnKeyPressFunc = null;
        }
        if (a && this.ExitFunc) {
            this.ExitFunc();
        }
        return true;
    },
    _animate: function (b, c) {
        if (!this.DomElement) {
            return;
        }
        var a = Telerik.Web.UI.CalendarAnimationType;
        if (b) {
            switch (this.ShowAnimationType) {
                case a.Slide:
                    $telerik.$(this.DomElement).slideDown(this.ShowAnimationDuration, c);
                    return;
                case a.Fade:
                default:
                    $telerik.$(this.DomElement).fadeIn(this.ShowAnimationDuration, c);
                    return;
            }
        } else {
            switch (this.HideAnimationType) {
                case a.Slide:
                    $telerik.$(this.DomElement).slideUp(this.HideAnimationDuration, c);
                    return;
                case a.Fade:
                default:
                    $telerik.$(this.DomElement).fadeOut(this.HideAnimationDuration, c);
                    return;
            }
        }
    },
    RemoveFilterStyle: function () {
        if ($telerik.isIE && this.DomElement) {
            this.DomElement.style.removeAttribute("filter");
            if (this.EnableShadows) {
                Sys.UI.DomElement.removeCssClass(this.DomElement, "rcIE");
            }
        }
    },
    OverFlowsBottom: function (a, c, d) {
        var b = d + c;
        return b > a.height;
    },
    OverFlowsRight: function (a, b, d) {
        var c = d + b;
        return c > a.width;
    },
    IsVisible: function () {
        var a = this.DomElement;
        var b = RadHelperUtils.GetStyleObj(a);
        if (a) {
            if (navigator.userAgent.match(/Safari/)) {
                return (b.visibility != "hidden");
            }
            return (b.display != "none");
        }
        return false;
    },
    IsChildOf: function (a, b) {
        while (a.parentNode) {
            if (a.parentNode == b) {
                return true;
            }
            a = a.parentNode;
        }
        return false;
    },
    ShouldHide: function (a) {
        var b = a.target;
        if (b == null) {
            b = a.srcElement;
        }
        for (var c = 0;
        c < this.ExcludeFromHiding.length;
        c++) {
            if (this.ExcludeFromHiding[c] == b) {
                return false;
            }
            if (this.IsChildOf(b, this.ExcludeFromHiding[c])) {
                return false;
            }
        }
        return true;
    },
    OnKeyPress: function (a) {
        if (!a) {
            a = window.event;
        }
        if (a.keyCode == 27) {
            this.Hide();
        }
    },
    OnClick: function (a) {
        if (!a) {
            a = window.event;
        }
        if (this.ShouldHide(a)) {
            this.Hide();
        }
    }
};
Telerik.Web.UI.Calendar.Popup.registerClass("Telerik.Web.UI.Calendar.Popup");
if (typeof (RadHelperUtils) == "undefined") {
    var RadHelperUtils = {
        IsDefined: function (a) {
            if ((typeof (a) != "undefined") && (a != null)) {
                return true;
            }
            return false;
        },
        StringStartsWith: function (b, a) {
            if (typeof (a) != "string") {
                return false;
            }
            return (0 == b.indexOf(a));
        },
        AttachEventListener: function (c, a, d) {
            if (d == null) {
                return;
            }
            var b = RadHelperUtils.CompatibleEventName(a);
            if (typeof (c.addEventListener) != "undefined") {
                c.addEventListener(b, d, false);
            } else {
                if (c.attachEvent) {
                    c.attachEvent(b, d);
                } else {
                    c["on" + a] = d;
                }
            }
        },
        DetachEventListener: function (c, a, d) {
            var b = RadHelperUtils.CompatibleEventName(a);
            if (typeof (c.removeEventListener) != "undefined") {
                c.removeEventListener(b, d, false);
            } else {
                if (c.detachEvent) {
                    c.detachEvent(b, d);
                } else {
                    c["on" + a] = null;
                }
            }
        },
        CompatibleEventName: function (a) {
            a = a.toLowerCase();
            if (document.addEventListener) {
                if (RadHelperUtils.StringStartsWith(a, "on")) {
                    return a.substr(2);
                } else {
                    return a;
                }
            } else {
                if (document.attachEvent && !RadHelperUtils.StringStartsWith(a, "on")) {
                    return "on" + a;
                } else {
                    return a;
                }
            }
        },
        MouseEventX: function (a) {
            if (a.pageX) {
                return a.pageX;
            } else {
                if (a.clientX) {
                    if (RadBrowserUtils.StandardMode) {
                        return (a.clientX + document.documentElement.scrollLeft);
                    }
                    return (a.clientX + document.body.scrollLeft);
                }
            }
        },
        MouseEventY: function (a) {
            if (a.pageY) {
                return a.pageY;
            } else {
                if (a.clientY) {
                    if (RadBrowserUtils.StandardMode) {
                        return (a.clientY + document.documentElement.scrollTop);
                    }
                    return (a.clientY + document.body.scrollTop);
                }
            }
        },
        IframePlaceholder: function (b, c) {
            var a = document.createElement("iframe");
            a.src = "javascript:false;";
            if (RadHelperUtils.IsDefined(c)) {
                switch (c) {
                    case 0:
                        a.src = "javascript:void(0);";
                        break;
                    case 1:
                        a.src = "about:blank";
                        break;
                    case 2:
                        a.src = "blank.htm";
                        break;
                }
            }
            a.frameBorder = 0;
            a.style.position = "absolute";
            a.style.display = "none";
            a.style.left = "-500px";
            a.style.top = "-2000px";
            a.style.height = RadHelperUtils.ElementHeight(b) + "px";
            var d = 0;
            d = RadHelperUtils.ElementWidth(b);
            a.style.width = d + "px";
            a.style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)";
            a.allowTransparency = false;
            b.parentNode.insertBefore(a, b);
            return a;
        },
        ProcessIframe: function (b, d, a, c) {
            if (document.readyState == "complete" && (RadBrowserUtils.IsIE55Win || $telerik.isIE6)) {
                if (!(RadHelperUtils.IsDefined(b))) {
                    return;
                }
                if (!RadHelperUtils.IsDefined(b.iframeShim)) {
                    b.iframeShim = RadHelperUtils.IframePlaceholder(b);
                }
                b.iframeShim.style.top = (RadHelperUtils.IsDefined(c)) ? (c + "px") : b.style.top;
                b.iframeShim.style.left = (RadHelperUtils.IsDefined(a)) ? (a + "px") : b.style.left;
                b.iframeShim.style.zIndex = (b.style.zIndex - 1);
                RadHelperUtils.ChangeDisplay(b.iframeShim, d);
            }
        },
        ChangeDisplay: function (a, c) {
            var b = RadHelperUtils.GetStyleObj(a);
            if (c != null && c == true) {
                b.display = "";
            } else {
                if (c != null && c == false) {
                    b.display = "none";
                }
            }
            return b.display;
        },
        GetStyleObj: function (a) {
            if (!RadHelperUtils.IsDefined(a)) {
                return null;
            }
            if (a.style) {
                return a.style;
            } else {
                return a;
            }
        },
        ElementWidth: function (a) {
            if (!a) {
                return 0;
            }
            if (RadHelperUtils.IsDefined(a.style)) {
                if (RadBrowserUtils.StandardMode && (RadBrowserUtils.IsIE55Win || $telerik.isIE6)) {
                    if (RadHelperUtils.IsDefined(a.offsetWidth) && a.offsetWidth != 0) {
                        return a.offsetWidth;
                    }
                }
                if (RadHelperUtils.IsDefined(a.style.pixelWidth) && a.style.pixelWidth != 0) {
                    var b = a.style.pixelWidth;
                    if (RadHelperUtils.IsDefined(a.offsetWidth) && a.offsetWidth != 0) {
                        b = (b < a.offsetWidth) ? a.offsetWidth : b;
                    }
                    return b;
                }
            }
            if (RadHelperUtils.IsDefined(a.offsetWidth)) {
                return a.offsetWidth;
            }
            return 0;
        },
        ElementHeight: function (a) {
            if (!a) {
                return 0;
            }
            if (RadHelperUtils.IsDefined(a.style)) {
                if (RadHelperUtils.IsDefined(a.style.pixelHeight) && a.style.pixelHeight != 0) {
                    return a.style.pixelHeight;
                }
            }
            if (a.offsetHeight) {
                return a.offsetHeight;
            }
            return 0;
        }
    };
    RadHelperUtils.GetElementByID = function (a, d) {
        var b = null;
        for (var c = 0;
        c < a.childNodes.length;
        c++) {
            if (!a.childNodes[c].id) {
                continue;
            }
            if (a.childNodes[c].id == d) {
                b = a.childNodes[c];
            }
        }
        return b;
    };
}
if (typeof (RadBrowserUtils) == "undefined") {
    var RadBrowserUtils = {
        Version: "1.0.0",
        IsInitialized: false,
        IsOsWindows: false,
        IsOsLinux: false,
        IsOsUnix: false,
        IsOsMac: false,
        IsUnknownOS: false,
        IsNetscape4: false,
        IsNetscape6: false,
        IsNetscape6Plus: false,
        IsNetscape7: false,
        IsNetscape8: false,
        IsMozilla: false,
        IsFirefox: false,
        IsSafari: false,
        IsIE: false,
        IsIEMac: false,
        IsIE5Mac: false,
        IsIE4Mac: false,
        IsIE5Win: false,
        IsIE55Win: false,
        IsIE6Win: false,
        IsIE4Win: false,
        IsOpera: false,
        IsOpera4: false,
        IsOpera5: false,
        IsOpera6: false,
        IsOpera7: false,
        IsOpera8: false,
        IsKonqueror: false,
        IsOmniWeb: false,
        IsCamino: false,
        IsUnknownBrowser: false,
        UpLevelDom: false,
        AllCollection: false,
        Layers: false,
        Focus: false,
        StandardMode: false,
        HasImagesArray: false,
        HasAnchorsArray: false,
        DocumentClear: false,
        AppendChild: false,
        InnerWidth: false,
        HasComputedStyle: false,
        HasCurrentStyle: false,
        HasFilters: false,
        HasStatus: false,
        Name: "",
        Codename: "",
        BrowserVersion: "",
        Platform: "",
        JavaEnabled: false,
        AgentString: "",
        Init: function () {
            if (window.navigator) {
                this.AgentString = navigator.userAgent.toLowerCase();
                this.Name = navigator.appName;
                this.Codename = navigator.appCodeName;
                this.BrowserVersion = navigator.appVersion.substring(0, 4);
                this.Platform = navigator.platform;
                this.JavaEnabled = navigator.javaEnabled();
            }
            this.InitOs();
            this.InitFeatures();
            this.InitBrowser();
            this.IsInitialized = true;
        },
        CancelIe: function () {
            this.IsIE = this.IsIE6Win = this.IsIE55Win = this.IsIE5Win = this.IsIE4Win = this.IsIEMac = this.IsIE5Mac = this.IsIE4Mac = false;
        },
        CancelOpera: function () {
            this.IsOpera4 = this.IsOpera5 = this.IsOpera6 = this.IsOpera7 = false;
        },
        CancelMozilla: function () {
            this.IsFirefox = this.IsMozilla = this.IsNetscape7 = this.IsNetscape6Plus = this.IsNetscape6 = this.IsNetscape4 = false;
        },
        InitOs: function () {
            if ((this.AgentString.indexOf("win") != -1)) {
                this.IsOsWindows = true;
            } else {
                if ((this.AgentString.indexOf("mac") != -1) || (navigator.appVersion.indexOf("mac") != -1)) {
                    this.IsOsMac = true;
                } else {
                    if ((this.AgentString.indexOf("linux") != -1)) {
                        this.IsOsLinux = true;
                    } else {
                        if ((this.AgentString.indexOf("x11") != -1)) {
                            this.IsOsUnix = true;
                        } else {
                            this.IsUnknownBrowser = true;
                        }
                    }
                }
            }
        },
        InitFeatures: function () {
            if ((document.getElementById && document.createElement)) {
                this.UpLevelDom = true;
            }
            if (document.all) {
                this.AllCollection = true;
            }
            if (document.layers) {
                this.Layers = true;
            }
            if (window.focus) {
                this.Focus = true;
            }
            if (document.compatMode && document.compatMode == "CSS1Compat") {
                this.StandardMode = true;
            }
            if (document.images) {
                this.HasImagesArray = true;
            }
            if (document.anchors) {
                this.HasAnchorsArray = true;
            }
            if (document.clear) {
                this.DocumentClear = true;
            }
            if (document.appendChild) {
                this.AppendChild = true;
            }
            if (window.innerWidth) {
                this.InnerWidth = true;
            }
            if (window.getComputedStyle) {
                this.HasComputedStyle = true;
            }
            if (document.documentElement && document.documentElement.currentStyle) {
                this.HasCurrentStyle = true;
            } else {
                if (document.body && document.body.currentStyle) {
                    this.HasCurrentStyle = true;
                }
            }
            try {
                if (document.body && document.body.filters) {
                    this.HasFilters = true;
                }
            } catch (a) { }
            if (typeof (window.status) != "undefined") {
                this.HasStatus = true;
            }
        },
        InitBrowser: function () {
            if (this.AllCollection || (navigator.appName == "Microsoft Internet Explorer")) {
                this.IsIE = true;
                if (this.IsOsWindows) {
                    if (this.UpLevelDom) {
                        if ((navigator.appVersion.indexOf("MSIE 6") > 0) || (document.getElementById && document.compatMode)) {
                            this.IsIE6Win = true;
                        } else {
                            if ((navigator.appVersion.indexOf("MSIE 5.5") > 0) && document.getElementById && !document.compatMode) {
                                this.IsIE55Win = true;
                                this.IsIE6Win = true;
                            } else {
                                if (document.getElementById && !document.compatMode && typeof (window.opera) == "undefined") {
                                    this.IsIE5Win = true;
                                }
                            }
                        }
                    } else {
                        this.IsIE4Win = true;
                    }
                } else {
                    if (this.IsOsMac) {
                        this.IsIEMac = true;
                        if (this.UpLevelDom) {
                            this.IsIE5Mac = true;
                        } else {
                            this.IsIE4Mac = true;
                        }
                    }
                }
            }
            if (this.AgentString.indexOf("opera") != -1 && typeof (window.opera) == "undefined") {
                this.IsOpera4 = true;
                this.IsOpera = true;
                this.CancelIe();
            } else {
                if (typeof (window.opera) != "undefined" && !typeof (window.print) == "undefined") {
                    this.IsOpera5 = true;
                    this.IsOpera = true;
                    this.CancelIe();
                } else {
                    if (typeof (window.opera) != "undefined" && typeof (window.print) != "undefined" && typeof (document.childNodes) == "undefined") {
                        this.IsOpera6 = true;
                        this.IsOpera = true;
                        this.CancelIe();
                    } else {
                        if (typeof (window.opera) != "undefined" && typeof (document.childNodes) != "undefined") {
                            this.IsOpera7 = true;
                            this.IsOpera = true;
                            this.CancelIe();
                        }
                    }
                }
            }
            if (this.IsOpera7 && (this.AgentString.indexOf("8.") != -1)) {
                this.CancelIe();
                this.CancelOpera();
                this.IsOpera8 = true;
                this.IsOpera = true;
            }
            if (this.AgentString.indexOf("firefox/") != -1) {
                this.CancelIe();
                this.CancelOpera();
                this.IsMozilla = true;
                this.IsFirefox = true;
            } else {
                if (navigator.product == "Gecko" && window.find) {
                    this.CancelIe();
                    this.CancelOpera();
                    this.IsMozilla = true;
                }
            }
            if (navigator.vendor && navigator.vendor.indexOf("Netscape") != -1 && navigator.product == "Gecko" && window.find) {
                this.CancelIe();
                this.CancelOpera();
                this.IsNetscape6Plus = true;
                this.IsMozilla = true;
            }
            if (navigator.product == "Gecko" && !window.find) {
                this.CancelIe();
                this.CancelOpera();
                this.IsNetscape6 = true;
            }
            if ((navigator.vendor && navigator.vendor.indexOf("Netscape") != -1 && navigator.product == "Gecko" && window.find) || (this.AgentString.indexOf("netscape/7") != -1 || this.AgentString.indexOf("netscape7") != -1)) {
                this.CancelIe();
                this.CancelOpera();
                this.CancelMozilla();
                this.IsMozilla = true;
                this.IsNetscape7 = true;
            }
            if ((navigator.vendor && navigator.vendor.indexOf("Netscape") != -1 && navigator.product == "Gecko" && window.find) || (this.AgentString.indexOf("netscape/8") != -1 || this.AgentString.indexOf("netscape8") != -1)) {
                this.CancelIe();
                this.CancelOpera();
                this.CancelMozilla();
                this.IsMozilla = true;
                this.IsNetscape8 = true;
            }
            if (navigator.vendor && navigator.vendor == "Camino") {
                this.CancelIe();
                this.CancelOpera();
                this.IsCamino = true;
                this.IsMozilla = true;
            }
            if (((navigator.vendor && navigator.vendor == "KDE") || (document.childNodes) && (!document.all) && (!navigator.taintEnabled))) {
                this.CancelIe();
                this.CancelOpera();
                this.IsKonqueror = true;
            }
            if ((document.childNodes) && (!document.all) && (!navigator.taintEnabled) && (navigator.accentColorName)) {
                this.CancelIe();
                this.CancelOpera();
                this.IsOmniWeb = true;
            } else {
                if (document.layers && navigator.mimeTypes["*"]) {
                    this.CancelIe();
                    this.CancelOpera();
                    this.IsNetscape4 = true;
                }
            }
            if ((document.childNodes) && (!document.all) && (!navigator.taintEnabled) && (!navigator.accentColorName)) {
                this.CancelIe();
                this.CancelOpera();
                this.IsSafari = true;
            } else {
                IsUnknownBrowser = true;
            }
        },
        DebugBrowser: function () {
            var a = "IsNetscape4 " + this.IsNetscape4 + "\n";
            a += "IsNetscape6 " + this.IsNetscape6 + "\n";
            a += "IsNetscape6Plus " + this.IsNetscape6Plus + "\n";
            a += "IsNetscape7 " + this.IsNetscape7 + "\n";
            a += "IsNetscape8 " + this.IsNetscape8 + "\n";
            a += "IsMozilla " + this.IsMozilla + "\n";
            a += "IsFirefox " + this.IsFirefox + "\n";
            a += "IsSafari " + this.IsSafari + "\n";
            a += "IsIE " + this.IsIE + "\n";
            a += "IsIEMac " + this.IsIEMac + "\n";
            a += "IsIE5Mac " + this.IsIE5Mac + "\n";
            a += "IsIE4Mac " + this.IsIE4Mac + "\n";
            a += "IsIE5Win " + this.IsIE5Win + "\n";
            a += "IsIE55Win " + this.IsIE55Win + "\n";
            a += "IsIE6Win " + this.IsIE6Win + "\n";
            a += "IsIE4Win " + this.IsIE4Win + "\n";
            a += "IsOpera " + this.IsOpera + "\n";
            a += "IsOpera4 " + this.IsOpera4 + "\n";
            a += "IsOpera5 " + this.IsOpera5 + "\n";
            a += "IsOpera6 " + this.IsOpera6 + "\n";
            a += "IsOpera7 " + this.IsOpera7 + "\n";
            a += "IsOpera8 " + this.IsOpera8 + "\n";
            a += "IsKonqueror " + this.IsKonqueror + "\n";
            a += "IsOmniWeb " + this.IsOmniWeb + "\n";
            a += "IsCamino " + this.IsCamino + "\n";
            a += "IsUnknownBrowser " + this.IsUnknownBrowser + "\n";
            alert(a);
        },
        DebugOS: function () {
            var a = "IsOsWindows " + this.IsOsWindows + "\n";
            a += "IsOsLinux " + this.IsOsLinux + "\n";
            a += "IsOsUnix " + this.IsOsUnix + "\n";
            a += "IsOsMac " + this.IsOsMac + "\n";
            a += "IsUnknownOS " + this.IsUnknownOS + "\n";
            alert(a);
        },
        DebugFeatures: function () {
            var a = "UpLevelDom " + this.UpLevelDom + "\n";
            a += "AllCollection " + this.AllCollection + "\n";
            a += "Layers " + this.Layers + "\n";
            a += "Focus " + this.Focus + "\n";
            a += "StandardMode " + this.StandardMode + "\n";
            a += "HasImagesArray " + this.HasImagesArray + "\n";
            a += "HasAnchorsArray " + this.HasAnchorsArray + "\n";
            a += "DocumentClear " + this.DocumentClear + "\n";
            a += "AppendChild " + this.AppendChild + "\n";
            a += "InnerWidth " + this.InnerWidth + "\n";
            a += "HasComputedStyle " + this.HasComputedStyle + "\n";
            a += "HasCurrentStyle " + this.HasCurrentStyle + "\n";
            a += "HasFilters " + this.HasFilters + "\n";
            a += "HasStatus " + this.HasStatus + "\n";
            alert(a);
        }
    };
    RadBrowserUtils.Init();
}
Type.registerNamespace("Telerik.Web.UI.Calendar");
Telerik.Web.UI.Calendar.Utils = {
    COLUMN_HEADER: 1,
    VIEW_HEADER: 2,
    ROW_HEADER: 3,
    FIRST_DAY: 0,
    FIRST_FOUR_DAY_WEEK: 2,
    FIRST_FULL_WEEK: 1,
    DEFAULT: 7,
    FRIDAY: 5,
    MONDAY: 1,
    SATURDAY: 6,
    SUNDAY: 0,
    THURSDAY: 4,
    TUESDAY: 2,
    WEDNESDAY: 3,
    RENDERINROWS: 1,
    RENDERINCOLUMNS: 2,
    NONE: 4,
    RECURRING_DAYINMONTH: 1,
    RECURRING_DAYANDMONTH: 2,
    RECURRING_WEEK: 4,
    RECURRING_WEEKANDMONTH: 8,
    RECURRING_TODAY: 16,
    RECURRING_WEEKDAYWEEKNUMBERANDMONTH: 32,
    RECURRING_NONE: 64,
    AttachMethod: function (a, b) {
        return function () {
            return a.apply(b, arguments);
        };
    },
    GetDateFromId: function (c) {
        var a = c.split("_");
        if (a.length < 2) {
            return null;
        }
        var b = [parseInt(a[a.length - 3]), parseInt(a[a.length - 2]), parseInt(a[a.length - 1])];
        return b;
    },
    GetRenderDay: function (d, a) {
        var c = Telerik.Web.UI.Calendar.Utils.GetDateFromId(a);
        var b = d.RenderDays.Get(c);
        return b;
    },
    FindTarget: function (b, a) {
        var c;
        if (b && b.target) {
            c = b.target;
        } else {
            if (window.event && window.event.srcElement) {
                c = window.event.srcElement;
            }
        }
        if (!c) {
            return null;
        }
        if (c.tagName == null && c.nodeType == 3 && (navigator.userAgent.match(/Safari/))) {
            c = c.parentNode;
        }
        while (c != null && c.tagName.toLowerCase() != "body") {
            if ((c.tagName.toLowerCase() == "th" || c.tagName.toLowerCase() == "td") && Telerik.Web.UI.Calendar.Utils.FindTableElement(c) != null && Telerik.Web.UI.Calendar.Utils.FindTableElement(c).id.indexOf(a) != -1) {
                break;
            }
            c = c.parentNode;
        }
        if (c.tagName == null || (c.tagName.toLowerCase() != "td" && c.tagName.toLowerCase() != "th")) {
            return null;
        }
        return c;
    },
    FindTableElement: function (a) {
        while (a != null && a.tagName.toLowerCase() != "table") {
            a = a.parentNode;
        }
        return a;
    },
    GetElementPosition: function (a) {
        return $telerik.getLocation(a);
    },
    MergeStyles: function (a, e) {
        if (a.lastIndexOf(";", a.length) != a.length - 1) {
            a += ";";
        }
        var c = e.split(";");
        var b = a;
        for (var d = 0;
        d < c.length - 1;
        d++) {
            var f = c[d].split(":");
            if (a.indexOf(f[0]) == -1) {
                b += c[d] + ";";
            }
        }
        return b;
    },
    MergeClassName: function (a, c) {
        var b = c.split(" ");
        if (b.length == 1 && b[0] == "") {
            b = [];
        }
        var e = b.length;
        for (var d = 0;
        d < e;
        d++) {
            if (b[d] == a) {
                return c;
            }
        }
        b[b.length] = a;
        return b.join(" ");
    },
    GetElementDimensions: function (a) {
        var d = a.style.left;
        var e = a.style.display;
        var b = a.style.position;
        a.style.left = "-6000px";
        a.style.display = "";
        a.style.position = "absolute";
        var c = $telerik.getBounds(a);
        a.style.left = d;
        a.style.display = e;
        a.style.position = b;
        return {
            width: c.width,
            height: c.height
        };
    }
};