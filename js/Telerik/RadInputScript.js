Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.PasswordStrengthChecker = function (a) {
    Telerik.Web.UI.PasswordStrengthChecker.initializeBase(this, [a]);
};
Telerik.Web.UI.PasswordStrengthChecker.prototype = {
    initialize: function () {
        Telerik.Web.UI.PasswordStrengthChecker.callBaseMethod(this, "initialize");
    },
    dispose: function () { },
    _getPasswordStrength: function (d, j) {
        var q = d;
        var l = "";
        var r = 0;
        var i = j.CalculationWeightings.split(";");
        var e = parseInt(i[0]);
        var s = parseInt(i[1]);
        var k = parseInt(i[2]);
        var h = parseInt(i[3]);
        var n = q.length / j.PreferredPasswordLength;
        if (n > 1) {
            n = 1;
        }
        var m = (n * e);
        r += m;
        if (n < 1) {
            l = String.format("Remaining characters", j.PreferredPasswordLength - q.length);
        }
        if (j.MinimumNumericCharacters > 0) {
            var b = new RegExp("[0-9]", "g");
            var p = this._getRegexCount(b, q);
            if (p >= j.MinimumNumericCharacters) {
                r += s;
            }
            if (p < j.MinimumNumericCharacters) {
                if (l != "") {
                    l += ", ";
                }
                l += String.format("Remaining numbers", j.MinimumNumericCharacters - p);
            }
        } else {
            r += (n * s);
        }
        if (j.RequiresUpperAndLowerCaseCharacters == true || (typeof (j.RequiresUpperAndLowerCaseCharacters) == "String" && Boolean.parse(j.RequiresUpperAndLowerCaseCharacters) == true)) {
            var c = new RegExp("[a-z]", "g");
            var g = new RegExp("[A-Z]", "g");
            var f = this._getRegexCount(c, q);
            var a = this._getRegexCount(g, q);
            if (f > 0 || a > 0) {
                if (f >= j.MinLowerCaseChars && a >= j.MinUpperCaseChars) {
                    r += k;
                } else {
                    if (j.MinLowerCaseChars > 0 && (j.MinLowerCaseChars - f) > 0) {
                        if (l != "") {
                            l += ", ";
                        }
                        l += String.format("Remaining lower case", j.MinLowerCaseChars - f);
                    }
                    if (j.MinUpperCaseChars > 0 && (j.MinUpperCaseChars - a) > 0) {
                        if (l != "") {
                            l += ", ";
                        }
                        l += String.format("Remaining upper case", j.MinUpperCaseChars - a);
                    }
                }
            } else {
                if (l != "") {
                    l += ", ";
                }
                l += "Mixed case characters";
            }
        } else {
            r += (n * k);
        }
        if (j.MinimumSymbolCharacters > 0) {
            var o = new RegExp("[^a-z,A-Z,0-9,\x20]", "g");
            var p = this._getRegexCount(o, q);
            if (p >= j.MinimumSymbolCharacters) {
                r += h;
            }
            if (p < j.MinimumSymbolCharacters) {
                if (l != "") {
                    l += ", ";
                }
                l += String.format("Remaining symbols", j.MinimumSymbolCharacters - p);
            }
        } else {
            r += (n * h);
        }
        return r;
    },
    showStrength: function (a, c, d) {
        var g = this._getPasswordStrength(c.value, d);
        var b = new Telerik.Web.UI.PasswordStrengthCalculatingEventArgs(c.value, g, "");
        a.raise_passwordStrengthCalculating(b);
        var f = null;
        if (b._strengthScore > 0 && b._strengthScore <= 100) {
            f = Math.floor(b._strengthScore / 25);
        }
        var h = "";
        if (b._indicatorText) {
            h = b._indicatorText;
        } else {
            if (d._IndicatorWords == undefined) {
                d._IndicatorWords = d.TextStrengthDescriptions.split(";");
                while (d._IndicatorWords.length < 5) {
                    d._IndicatorWords[d._IndicatorWords.length] = "";
                }
            }
            if (f != null) {
                h = d._IndicatorWords[f];
            }
        }
        if (d._IndicatorStyles == undefined) {
            d._IndicatorStyles = d.TextStrengthDescriptionStyles.split(";");
        }
        var e = null;
        if (d.IndicatorElementID == "") {
            if (a.get_element) {
                e = $get(a.get_element().id + "_passwordStrengthIndicator");
            } else {
                e = $get(c.id + "_passwordStrengthIndicator");
            }
        } else {
            e = $get(d.IndicatorElementID);
        }
        if (e) {
            e.innerHTML = h;
            if (f != null) {
                e.className = d.IndicatorElementBaseStyle + " " + d._IndicatorStyles[f + 1];
            } else {
                e.className = d.IndicatorElementBaseStyle + " " + d._IndicatorStyles[0];
            }
        }
    },
    _getRegexCount: function (c, d) {
        var a = 0;
        if (d != null && d != "") {
            var b = d.match(c);
            if (b != null) {
                a = b.length;
            }
        }
        return a;
    }
};
Telerik.Web.UI.PasswordStrengthChecker.registerClass("Telerik.Web.UI.PasswordStrengthChecker", Telerik.Web.UI.RadWebControl);
Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.RadInputControl = function (a) {
    Telerik.Web.UI.RadInputControl.initializeBase(this, [a]);
    this._autoPostBack = false;
    this._enabled = true;
    this._showButton = false;
    this._invalidStyleDuration = 100;
    this._selectionOnFocus = Telerik.Web.UI.SelectionOnFocus.None;
    this._postBackEventReferenceScript = "";
    this._styles = null;
    this._skin = null;
    this._enableAriaSupport = false;
    this._causesValidation = false;
    this._validationGroup = "";
    this._isEnterPressed = false;
    this._isDropped = false;
    this._enableOldBoxModel = false;
    this._shouldResetWidthInPixels = true;
    this._reducedPixelWidthFlag = false;
    this._originalTextBoxWidth = null;
    this._originalCellPadding = null;
    this._originalDisplay = null;
    this._onTextBoxKeyUpDelegate = null;
    this._onTextBoxKeyPressDelegate = null;
    this._onTextBoxBlurDelegate = null;
    this._onTextBoxFocusDelegate = null;
    this._onTextBoxDragEnterDelegate = null;
    this._onTextBoxDragLeaveDelegate = null;
    this._onTextBoxDragDropDelegate = null;
    this._onTextBoxMouseOutDelegate = null;
    this._onTextBoxMouseOverDelegate = null;
    this._onTextBoxKeyDownDelegate = null;
    this._onTextBoxMouseWheelDelegate = null;
    this._onFormResetDelegate = null;
    this._emptyMessage = "";
    this._initialValueAsText = null;
    this._originalInitialValueAsText = "";
    this._validationText = "";
    this._displayText = "";
    this._value = "";
    this._text = "";
    this._holdsValidValue = true;
    if ($telerik.isSafari) {
        this._onTextBoxMouseUpDelegate = null;
    }
    this._focused = false;
    this._allowApplySelection = true;
};
Telerik.Web.UI.RadInputControl.prototype = {
    initialize: function () {
        Telerik.Web.UI.RadInputControl.OverrideValidatorFunctions();
        Telerik.Web.UI.RadInputControl.callBaseMethod(this, "initialize");
        this._clientID = this.get_id();
        this._wrapperElementID = this.get_id() + "_wrapper";
        var e = (!$telerik.quirksMode && ($telerik.isIE6 || ($telerik.isIE7 && !document.documentMode) || (document.documentMode && document.documentMode < 8)));
        var b = this.get_wrapperElement().className.indexOf("riSingle") > -1;
        this._textBoxElement = $get(this._clientID);
        this._textBoxElement.RadInputValidationValue = this._validationText;
        if (this._initialValueAsText !== null) {
            this._value = this._constructValueFromInitialText(this._initialValueAsText);
            this._text = this._constructEditText(this._value);
            this._originalInitialValueAsText = this._initialValueAsText;
        }
        this._initialValueAsText = this._text;
        if (b && e) {
            this._textBoxElement.style.textIndent = "-100px";
            this._textBoxElement.style.width = "100%";
            var g = parseInt($telerik.getComputedStyle(this._textBoxElement, "borderLeftWidth", ""));
            g = g ? 2 : g;
            var c = parseInt($telerik.getComputedStyle(this._textBoxElement, "borderRightWidth", ""));
            c = c ? 2 : c;
            var a = this._textBoxElement.offsetWidth - 2 * (parseInt($telerik.getComputedStyle(this._textBoxElement, "paddingLeft", "")) + parseInt($telerik.getComputedStyle(this._textBoxElement, "paddingRight", "")) + g + c);
            var j = $telerik.getComputedStyle(this._textBoxElement, "height", "") == "auto" ? 0 : this._textBoxElement.offsetHeight - 2 * (parseInt($telerik.getComputedStyle(this._textBoxElement, "paddingTop", "")) + parseInt($telerik.getComputedStyle(this._textBoxElement, "paddingBottom", "")) + parseInt($telerik.getComputedStyle(this._textBoxElement, "borderTopWidth", "")) + parseInt($telerik.getComputedStyle(this._textBoxElement, "borderBottomWidth", "")));
            this._textBoxElement.style.textIndent = "";
            if (a > 0) {
                this._textBoxElement.style.width = a + "px";
                if (j > 0) {
                    this._textBoxElement.style.height = j + "px";
                }
            }
        }
        this._originalTextBoxCssText = this._textBoxElement.style.cssText;
        if (this._originalTextBoxCssText.lastIndexOf(";") != this._originalTextBoxCssText.length - 1) {
            this._originalTextBoxCssText += ";";
        }
        var d = this.get_wrapperElement();
        if (d.style.display == "none") {
            this._originalDisplay = "";
        } else {
            this._originalDisplay = d.style.display;
        }
        if ($telerik.isIE7 || $telerik.quirksMode) {
            if (this._originalDisplay == "inline-block") {
                this._originalDisplay = "inline";
                d.style.zoom = 1;
            } else {
                if (document.documentMode && document.documentMode > 7 && this._originalDisplay == "inline") {
                    this._originalDisplay = "inline-block";
                }
            }
        }
        if (d.style.display != "none") {
            d.style.display = this._originalDisplay;
        }
        if ($telerik.getCurrentStyle(d, "direction") == "rtl") {
            var h = this._skin != "" ? String.format(" RadInputRTL_{0}", this._skin) : "";
            d.className += String.format(" RadInputRTL{0}", h);
        }
        this.repaint();
        this._originalMaxLength = this._textBoxElement.maxLength;
        if (this._originalMaxLength == -1) {
            this._originalMaxLength = 2147483647;
        }
        this._selectionEnd = 0;
        this._selectionStart = 0;
        this._hovered = false;
        this._invalid = false;
        this._attachEventHandlers();
        if (this._focused) {
            this.updateDisplayValue();
            var f = this;
            setTimeout(function () {
                f._updateSelectionOnFocus();
            }, 0);
        } else {
            if (($telerik.isFirefox2 || $telerik.isSafari) && this.isEmpty() && this.get_emptyMessage().length > this._originalMaxLength) {
                this.updateDisplayValue();
            }
        }
        this.updateCssClass();
        this._initializeButtons();
        if (this.get_enableAriaSupport()) {
            this._initializeAriaSupport();
        }
        this.updateClientState();
        this.raise_load(Sys.EventArgs.Empty);
    },
    dispose: function () {
        Telerik.Web.UI.RadInputControl.callBaseMethod(this, "dispose");
        if (this.Button) {
            if (this._onButtonClickDelegate) {
                $removeHandler(this.Button, "click", this._onButtonClickDelegate);
                this._onButtonClickDelegate = null;
            }
        }
        if ($telerik.isIE) {
            if (this._onTextBoxPasteDelegate) {
                $removeHandler(this._textBoxElement, "paste", this._onTextBoxPasteDelegate);
                this._onTextBoxPasteDelegate = null;
            }
        } else {
            if (this._onTextBoxInputDelegate) {
                $removeHandler(this._textBoxElement, "input", this._onTextBoxInputDelegate);
                this._onTextBoxInputDelegate = null;
            }
        }
        if (this._onTextBoxKeyDownDelegate) {
            $removeHandler(this._textBoxElement, "keydown", this._onTextBoxKeyDownDelegate);
            this._onTextBoxKeyDownDelegate = null;
        }
        if (this._onTextBoxKeyPressDelegate) {
            $removeHandler(this._textBoxElement, "keypress", this._onTextBoxKeyPressDelegate);
            this._onTextBoxKeyPressDelegate = null;
        }
        if (this._onTextBoxKeyUpDelegate) {
            $removeHandler(this._textBoxElement, "keyup", this._onTextBoxKeyUpDelegate);
            this._onTextBoxKeyUpDelegate = null;
        }
        if (this._onTextBoxBlurDelegate) {
            $removeHandler(this._textBoxElement, "blur", this._onTextBoxBlurDelegate);
            this._onTextBoxBlurDelegate = null;
        }
        if (this._onTextBoxFocusDelegate) {
            $removeHandler(this._textBoxElement, "focus", this._onTextBoxFocusDelegate);
            this._onTextBoxFocusDelegate = null;
        }
        if (this._onTextBoxDragEnterDelegate) {
            $removeHandler(this._textBoxElement, "dragenter", this._onTextBoxDragEnterDelegate);
            this._onTextBoxDragEnterDelegate = null;
        }
        if (this._onTextBoxDragLeaveDelegate) {
            if ($telerik.isFirefox) {
                $removeHandler(this._textBoxElement, "dragexit", this._onTextBoxDragLeaveDelegate);
            } else {
                $removeHandler(this._textBoxElement, "dragleave", this._onTextBoxDragLeaveDelegate);
            }
            this._onTextBoxDragLeaveDelegate = null;
        }
        if (this._onTextBoxMouseOutDelegate) {
            $removeHandler(this._textBoxElement, "mouseout", this._onTextBoxMouseOutDelegate);
            this._onTextBoxMouseOutDelegate = null;
        }
        if (this._onTextBoxMouseOverDelegate) {
            $removeHandler(this._textBoxElement, "mouseover", this._onTextBoxMouseOverDelegate);
            this._onTextBoxMouseOverDelegate = null;
        }
        if (this._onTextBoxMouseUpDelegate) {
            $removeHandler(this._textBoxElement, "mouseup", this._onTextBoxMouseUpDelegate);
            this._onTextBoxMouseUpDelegate = null;
        }
        if (this._onFormResetDelegate) {
            if (this._textBoxElement.form) {
                $removeHandler(this._textBoxElement.form, "reset", this._onFormResetDelegate);
            }
            this._onFormResetDelegate = null;
        }
        if (!$telerik.isIE) {
            if (this._onTextBoxMouseWheelDelegate) {
                if ((!$telerik.isSafari2 && $telerik.isSafari) || $telerik.isOpera) {
                    $removeHandler(this._textBoxElement, "mousewheel", this._onTextBoxMouseWheelDelegate);
                } else {
                    $removeHandler(this._textBoxElement, "DOMMouseScroll", this._onTextBoxMouseWheelDelegate);
                }
                this._onTextBoxMouseWheelDelegate = null;
            }
        } else {
            if (this._onTextBoxMouseWheelDelegate) {
                $removeHandler(this._textBoxElement, "mousewheel", this._onTextBoxMouseWheelDelegate);
                this._onTextBoxMouseWheelDelegate = null;
            }
        }
        if (this._onTextBoxDragDropDelegate) {
            if ($telerik.isFirefox && Sys.Browser.version < 3.5) {
                $removeHandler(this._textBoxElement, "dragdrop", this._onTextBoxDragDropDelegate);
            } else {
                $removeHandler(this._textBoxElement, "drop", this._onTextBoxDragDropDelegate);
            }
            this._onTextBoxDragDropDelegate = null;
        }
        if (this._textBoxElement) {
            this._textBoxElement._events = null;
        }
    },
    clear: function () {
        this.set_value("");
    },
    disable: function () {
        this.set_enabled(false);
        this._textBoxElement.disabled = "disabled";
        this.updateCssClass();
        this.updateClientState();
        if ($telerik.isIE9) {
            this._textBoxElement.style.lineHeight = "10000px";
        }
        this.raise_disable(Sys.EventArgs.Empty);
    },
    enable: function () {
        this.set_enabled(true);
        this._textBoxElement.disabled = "";
        this.updateCssClass();
        this.updateClientState();
        this.raise_enable(Sys.EventArgs.Empty);
    },
    focus: function () {
        if (!this._textBoxElement.disabled) {
            this._textBoxElement.focus();
        }
    },
    blur: function () {
        this._textBoxElement.blur();
    },
    isEmpty: function () {
        return this._validationText == "";
    },
    isNegative: function () {
        return false;
    },
    isReadOnly: function () {
        return this._textBoxElement.readOnly || !this._enabled;
    },
    isMultiLine: function () {
        return this._textBoxElement && this._textBoxElement.tagName.toUpperCase() == "TEXTAREA";
    },
    updateDisplayValue: function () {
        if (this._focused) {
            this.set_textBoxValue(this.get_editValue());
        } else {
            if (this._isEmptyMessage()) {
                this.set_textBoxValue(this.get_emptyMessage());
            } else {
                this.set_textBoxValue(this.get_displayValue());
            }
        }
    },
    _isEmptyMessage: function () {
        return this.isEmpty() && this.get_emptyMessage();
    },
    repaint: function () {
        if (!this.canRepaint()) {
            this.add_parentShown(this.get_element());
            return;
        } else {
            this._clearParentShowHandlers();
        }
        this._updatePercentageHeight();
        if (this._shouldResetWidthInPixels) {
            this._resetWidthInPixels();
        }
        if (!this._reducedPixelWidthFlag && this._enableOldBoxModel) {
            this._reducePixelWidthByPaddings();
        }
    },
    updateCssClass: function (b) {
        if (!this._holdsValidValue && !b) {
            this._textBoxElement.style.cssText = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["InvalidStyle"][0]);
            this._textBoxElement.className = this.get_styles()["InvalidStyle"][1];
            return;
        }
        var a = "";
        var c = "";
        if (this._enabled && (!this._isEmptyMessage()) && (!this.isNegative())) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["EnabledStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["EnabledStyle"][1];
        }
        if (this._enabled && (!this._isEmptyMessage()) && this.isNegative()) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["NegativeStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["NegativeStyle"][1];
        }
        if (this._enabled && this._isEmptyMessage()) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["EmptyMessageStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["EmptyMessageStyle"][1];
        }
        if (this._hovered) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["HoveredStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["HoveredStyle"][1];
        }
        if (this._focused) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["FocusedStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["FocusedStyle"][1];
        }
        if (this._invalid) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["InvalidStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["InvalidStyle"][1];
        }
        if (this._textBoxElement.readOnly && this._isEmptyMessage()) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["EmptyMessageStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["EmptyMessageStyle"][1];
        } else {
            if (this._textBoxElement.readOnly) {
                c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["ReadOnlyStyle"][0]);
                if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                    this._textBoxElement.style.cssText = c;
                }
                a = this.get_styles()["ReadOnlyStyle"][1];
            }
        }
        if (!this._enabled) {
            c = this._originalTextBoxCssText + this.updateCssText(this.get_styles()["DisabledStyle"][0]);
            if (!this._compareStyles(this._textBoxElement.style.cssText, c)) {
                this._textBoxElement.style.cssText = c;
            }
            a = this.get_styles()["DisabledStyle"][1];
        }
        if (a != "" && !this._compareStyles(this._textBoxElement.className, a)) {
            this._textBoxElement.className = a;
        }
        if (a == "" && this._textBoxElement.className && this._textBoxElement.className == "") {
            this._textBoxElement.removeAttribute("class");
        }
    },
    _compareStyles: function () {
        if (arguments.length >= 2) {
            var a = arguments[0].replace(/ /g, "").replace(/;/g, "");
            var b = arguments[1].replace(/ /g, "").replace(/;/g, "");
            return a === b;
        }
        return false;
    },
    updateCssText: function (f) {
        var a = f.split(";");
        var c;
        var d = "";
        for (c = 0;
        c < a.length;
        c++) {
            var b = a[c].split(":");
            if (b.length == 2) {
                var e = "" + b[0].toLowerCase();
                if (e != "width" && e != "height") {
                    d += a[c] + ";";
                }
            }
        }
        return d;
    },
    selectText: function (b, a) {
        this._selectionStart = b;
        this._selectionEnd = a;
        this._applySelection();
    },
    selectAllText: function () {
        if (this._textBoxElement.value.length > 0) {
            this.selectText(0, this._textBoxElement.value.length);
            return true;
        }
        return false;
    },
    get_value: function () {
        return this._value;
    },
    get_valueAsString: function () {
        if (this._value) {
            return this._value.toString();
        } else {
            return "";
        }
    },
    _setNewValue: function (a) {
        this._holdsValidValue = this._setHiddenValue(a) || this._holdsValidValue;
        this._triggerDomEvent("change", this._textBoxElement);
        if (this._holdsValidValue) {
            this.set_displayValue(this._constructDisplayText(this._value));
            this.raise_valueChanged(this.get_editValue(), this._initialValueAsText);
            this.updateCssClass();
        }
        this._initialValueAsText = this.get_editValue();
    },
    set_value: function (b) {
        var a = new Telerik.Web.UI.InputValueChangingEventArgs(b, this._initialValueAsText);
        this.raise_valueChanging(a);
        if (a.get_cancel() == true) {
            this._SetValue(this._initialValueAsText);
            return false;
        }
        b = a.get_newValue();
        this._setNewValue(b);
    },
    get_displayValue: function () {
        return this._displayText;
    },
    set_displayValue: function (a) {
        this._displayText = a;
        this.updateDisplayValue();
    },
    get_editValue: function () {
        return this._text;
    },
    set_caretPosition: function (a) {
        if (this._textBoxElement.tagName.toLowerCase() == "textarea" && this._textBoxElement.value.length < a) {
            return;
        }
        this._selectionStart = a;
        this._selectionEnd = a;
        this._applySelection();
    },
    get_caretPosition: function () {
        this._calculateSelection();
        if (this._selectionStart != this._selectionEnd) {
            return new Array(this._selectionStart, this._selectionEnd);
        } else {
            if (this._textBoxElement.selectionStart) {
                return this._textBoxElement.selectionStart;
            } else {
                return this._selectionStart;
            }
        }
    },
    raisePostBackEvent: function () {
        eval(this._postBackEventReferenceScript);
    },
    get_wrapperElement: function () {
        return $get(this._wrapperElementID);
    },
    get_textBoxValue: function () {
        return this._textBoxElement.value;
    },
    set_textBoxValue: function (a) {
        if (this._textBoxElement.value != a) {
            this._textBoxElement.value = a;
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
    get_emptyMessage: function () {
        return this._emptyMessage;
    },
    set_emptyMessage: function (a) {
        if (this._emptyMessage !== a) {
            this._emptyMessage = a;
            if (this._textBoxElement) {
                this.updateDisplayValue();
                this.updateCssClass();
                this.updateClientState();
                this.raisePropertyChanged("emptyMessage");
            }
        }
    },
    get_selectionOnFocus: function () {
        return this._selectionOnFocus;
    },
    set_selectionOnFocus: function (a) {
        if (this._selectionOnFocus !== a) {
            this._selectionOnFocus = a;
            this.raisePropertyChanged("selectionOnFocus");
        }
    },
    get_showButton: function () {
        return this._showButton;
    },
    set_showButton: function (a) {
        if (this._showButton !== a) {
            this._showButton = a;
            this.raisePropertyChanged("showButton");
        }
    },
    get_invalidStyleDuration: function () {
        return this._invalidStyleDuration;
    },
    set_invalidStyleDuration: function (a) {
        if (this._invalidStyleDuration !== a) {
            this._invalidStyleDuration = a;
            this.raisePropertyChanged("invalidStyleDuration");
        }
    },
    get_enabled: function () {
        return this._enabled;
    },
    set_enabled: function (a) {
        if (this._enabled !== a) {
            this._enabled = a;
            this.updateClientState();
            if (this.get_enableAriaSupport()) {
                this._applyAriaStateChange("disabled", !a);
            }
            this.raisePropertyChanged("enabled");
        }
    },
    get_styles: function () {
        return this._styles;
    },
    set_styles: function (a) {
        if (this._styles !== a) {
            this._styles = a;
            this.raisePropertyChanged("styles");
        }
    },
    saveClientState: function (c) {
        var b = ["enabled", "emptyMessage", "validationText", "valueAsString"];
        if (c) {
            for (var d = 0, a = c.length;
            d < a;
            d++) {
                b[b.length] = c[d];
            }
        }
        var e = {};
        for (var d = 0;
        d < b.length;
        d++) {
            e[b[d]] = this["get_" + b[d]]();
        }
        this.saveCustomClientStateValues(e);
        return Sys.Serialization.JavaScriptSerializer.serialize(e);
    },
    saveCustomClientStateValues: function (a) { },
    get_visible: function () {
        if (this.get_wrapperElement().style.display == "none") {
            return false;
        } else {
            return true;
        }
    },
    set_visible: function (a) {
        if (a == true && this._originalDisplay != null) {
            this.get_wrapperElement().style.display = this._originalDisplay;
            this.repaint();
        } else {
            if (a == false && this.get_visible()) {
                this._originalDisplay = this.get_wrapperElement().style.display;
                this.get_wrapperElement().style.display = "none";
            }
        }
    },
    get_shouldResetWidthInPixels: function () {
        return this._shouldResetWidthInPixels;
    },
    set_shouldResetWidthInPixels: function (a) {
        this._shouldResetWidthInPixels = a;
    },
    get_enableOldBoxModel: function () {
        return this._enableOldBoxModel;
    },
    set_enableOldBoxModel: function (a) {
        this._enableOldBoxModel = a;
    },
    get_enableAriaSupport: function () {
        return this._enableAriaSupport;
    },
    set_enableAriaSupport: function (a) {
        if (this._enableAriaSupport != a) {
            this._enableAriaSupport = a;
        }
    },
    get_causesValidation: function () {
        return this._causesValidation;
    },
    get_validationGroup: function () {
        return this._validationGroup;
    },
    _reducePixelWidthByPaddings: function () {
        if (this._textBoxElement.offsetWidth > 0 && this._textBoxElement.parentNode.tagName.toLowerCase() == "span" && this._textBoxElement.parentNode.parentNode.className != "rcInputCell" && this._textBoxElement.style.width && this._textBoxElement.style.width.indexOf("%") == -1 && (!this._originalTextBoxWidth || this._originalTextBoxWidth.indexOf("%") == -1)) {
            var g = 0;
            if (document.defaultView && document.defaultView.getComputedStyle) {
                g = parseInt(document.defaultView.getComputedStyle(this._textBoxElement, null).getPropertyValue("border-left-width")) + parseInt(document.defaultView.getComputedStyle(this._textBoxElement, null).getPropertyValue("padding-left")) + parseInt(document.defaultView.getComputedStyle(this._textBoxElement, null).getPropertyValue("padding-right")) + parseInt(document.defaultView.getComputedStyle(this._textBoxElement, null).getPropertyValue("border-right-width"));
            } else {
                if (this._textBoxElement.currentStyle) {
                    if (!$telerik.isIE || (document.compatMode && document.compatMode != "BackCompat")) {
                        g = parseInt(this._textBoxElement.currentStyle.borderLeftWidth) + parseInt(this._textBoxElement.currentStyle.paddingLeft) + parseInt(this._textBoxElement.currentStyle.paddingRight) + parseInt(this._textBoxElement.currentStyle.borderRightWidth);
                    }
                }
            }
            var d = parseInt(this._textBoxElement.style.width) - g;
            if (g == 0 || d <= 0) {
                return;
            }
            this._textBoxElement.style.width = d + "px";
            var c = "";
            var b = this._originalTextBoxCssText.split(";");
            for (var e = 0;
            e < b.length;
            e++) {
                var a = b[e].split(":");
                if (a.length == 2) {
                    var f = "" + a[0].toLowerCase();
                    if (f != "width") {
                        c += b[e] + ";";
                    } else {
                        c += "width:" + d + "px;";
                        if (!this._originalTextBoxWidth) {
                            this._originalTextBoxWidth = b[e].split(":")[1].trim();
                        }
                    }
                }
            }
            this._originalTextBoxCssText = c;
            this._reducedPixelWidthFlag = true;
        }
    },
    _updatePercentageHeight: function () {
        var a = $get(this._wrapperElementID);
        if (a.style.height.indexOf("%") != -1 && a.offsetHeight > 0) {
            var b = 0;
            if (this._textBoxElement.currentStyle) {
                b = parseInt(this._textBoxElement.currentStyle.borderTopWidth) + parseInt(this._textBoxElement.currentStyle.borderBottomWidth) + parseInt(this._textBoxElement.currentStyle.paddingTop) + parseInt(this._textBoxElement.currentStyle.paddingBottom);
            } else {
                if (window.getComputedStyle) {
                    b = parseInt(window.getComputedStyle(this._textBoxElement, null).getPropertyValue("border-top-width")) + parseInt(window.getComputedStyle(this._textBoxElement, null).getPropertyValue("border-bottom-width")) + parseInt(window.getComputedStyle(this._textBoxElement, null).getPropertyValue("padding-top")) + parseInt(window.getComputedStyle(this._textBoxElement, null).getPropertyValue("padding-bottom"));
                }
            }
            this._textBoxElement.style.height = "1px";
            this._textBoxElement.style.cssText = this._textBoxElement.style.cssText;
            this._textBoxElement.style.height = a.offsetHeight - b + "px";
            if (this._originalTextBoxCssText.search(/(^|[^-])height/) != -1) {
                this._originalTextBoxCssText = this._originalTextBoxCssText.replace(/(^|[^-])height(\s*):(\s*)([^;]+);/i, "$1height:" + (a.offsetHeight - b) + "px;");
            } else {
                this._originalTextBoxCssText += "height:" + (a.offsetHeight - b) + "px;";
            }
        }
    },
    _resetWidthInPixels: function () {
        if (($telerik.isIE6 || ($telerik.isIE7 && !document.documentMode) || (document.documentMode && document.documentMode < 8)) && this._textBoxElement.offsetWidth > 0 && (this._textBoxElement.parentNode.tagName.toLowerCase() == "td" || (this._textBoxElement.parentNode.parentNode.tagName.toLowerCase() == "td" && this._textBoxElement.parentNode.parentNode.className == "rcInputCell") || (this._textBoxElement.parentNode.tagName.toLowerCase() == "span" && this._textBoxElement.parentNode.parentNode.className != "rcInputCell" && (this._textBoxElement.currentStyle.width.indexOf("%") != -1 || (this._originalTextBoxWidth && this._originalTextBoxWidth.indexOf("%") != -1))))) {
            var g = this._textBoxElement.value;
            var h;
            var d;
            var c = "";
            if (g != "") {
                this._textBoxElement.value = "";
            }
            if (this._originalCellPadding && this._textBoxElement.parentNode.tagName.toLowerCase() == "td") {
                this._textBoxElement.parentNode.style.paddingRight = this._originalCellPadding;
            } else {
                if (this._originalCellPadding && this._textBoxElement.parentNode.parentNode.tagName.toLowerCase() == "td" && this._textBoxElement.parentNode.parentNode.className == "rcInputCell") {
                    this._textBoxElement.parentNode.parentNode.style.paddingRight = this._originalCellPadding;
                }
            }
            if (this._originalTextBoxWidth) {
                this._textBoxElement.style.width = this._originalTextBoxWidth;
            } else {
                if (g != "") {
                    this._textBoxElement.style.cssText = this._textBoxElement.style.cssText;
                }
            }
            h = parseInt(this._textBoxElement.currentStyle.paddingLeft) + parseInt(this._textBoxElement.currentStyle.paddingRight);
            d = this._textBoxElement.clientWidth - h;
            if (d > 0) {
                this._textBoxElement.style.width = d + "px";
                if (this._textBoxElement.parentNode.tagName.toLowerCase() == "td") {
                    if (!this._originalCellPadding) {
                        this._originalCellPadding = this._textBoxElement.parentNode.currentStyle.paddingRight;
                    }
                    this._textBoxElement.parentNode.style.paddingRight = "0px";
                } else {
                    if (this._textBoxElement.parentNode.parentNode.tagName.toLowerCase() == "td" && this._textBoxElement.parentNode.parentNode.className == "rcInputCell") {
                        if (!this._originalCellPadding) {
                            this._originalCellPadding = this._textBoxElement.parentNode.parentNode.currentStyle.paddingRight;
                        }
                        this._textBoxElement.parentNode.parentNode.style.paddingRight = "0px";
                    }
                }
                var b = this._originalTextBoxCssText.split(";");
                for (var e = 0;
                e < b.length;
                e++) {
                    var a = b[e].split(":");
                    if (a.length == 2) {
                        var f = "" + a[0].toLowerCase();
                        if (f != "width") {
                            c += b[e] + ";";
                        } else {
                            c += "width:" + d + "px;";
                            if (!this._originalTextBoxWidth) {
                                this._originalTextBoxWidth = b[e].split(":")[1].trim();
                            }
                        }
                    }
                }
                this._originalTextBoxCssText = c;
            }
            if (g != "") {
                this._textBoxElement.value = g;
            }
        }
    },
    _initializeButtons: function () {
        this._onButtonClickDelegate = Function.createDelegate(this, this._onButtonClickHandler);
        this.Button = null;
        var a = $get(this._wrapperElementID);
        var b = a.getElementsByTagName("a");
        for (i = 0;
        i < b.length;
        i++) {
            if (b[i].className.indexOf("riButton") != (-1)) {
                this.Button = b[i];
                $addHandler(this.Button, "click", this._onButtonClickDelegate);
            }
        }
    },
    _initializeAriaSupport: function () {
        var a = this.get_wrapperElement();
        a.setAttribute("role", "textbox");
        a.setAttribute("aria-disabled", (!this.get_enabled()) + "");
        if (this.isMultiLine()) {
            a.setAttribute("aria-multiline", "true");
        }
        if (this.isReadOnly()) {
            a.setAttribute("aria-readonly", "true");
        }
        var b = this.get_element();
        b.setAttribute("aria-hidden", "true");
        if (this.Button) {
            this.Button.setAttribute("role", "button");
            this.Button.setAttribute("aria-label", "Go");
        }
    },
    _applyAriaStateChange: function (b, c) {
        var a = this.get_wrapperElement();
        if (a) {
            a.setAttribute("aria-" + b, c + "");
        }
    },
    _attachEventHandlers: function () {
        this._onTextBoxKeyUpDelegate = Function.createDelegate(this, this._onTextBoxKeyUpHandler);
        this._onTextBoxKeyPressDelegate = Function.createDelegate(this, this._onTextBoxKeyPressHandler);
        this._onTextBoxBlurDelegate = Function.createDelegate(this, this._onTextBoxBlurHandler);
        this._onTextBoxFocusDelegate = Function.createDelegate(this, this._onTextBoxFocusHandler);
        this._onTextBoxKeyDownDelegate = Function.createDelegate(this, this._onTextBoxKeyDownHandler);
        $addHandler(this._textBoxElement, "keydown", this._onTextBoxKeyDownDelegate);
        $addHandler(this._textBoxElement, "keypress", this._onTextBoxKeyPressDelegate);
        $addHandler(this._textBoxElement, "keyup", this._onTextBoxKeyUpDelegate);
        $addHandler(this._textBoxElement, "blur", this._onTextBoxBlurDelegate);
        $addHandler(this._textBoxElement, "focus", this._onTextBoxFocusDelegate);
        if ($telerik.isIE || $telerik.isSafari) {
            this._onTextBoxPasteDelegate = Function.createDelegate(this, this._onTextBoxPasteHandler);
            $addHandler(this._textBoxElement, "paste", this._onTextBoxPasteDelegate);
        } else {
            this._onTextBoxInputDelegate = Function.createDelegate(this, this._onTextBoxInputHandler);
            $addHandler(this._textBoxElement, "input", this._onTextBoxInputDelegate);
        }
        if (this._textBoxElement && this._textBoxElement.form) {
            this._onFormResetDelegate = Function.createDelegate(this, this._onFormResetHandler);
            $addHandler(this._textBoxElement.form, "reset", this._onFormResetDelegate);
        }
        this._attachMouseEventHandlers();
    },
    _onTextBoxPasteHandler: function (d) {
        if (this.isMultiLine() && this._maxLength > 0) {
            if ($telerik.isSafari) {
                var h = this;
                window.setTimeout(function () {
                    h._textBoxElement.value = h._textBoxElement.value.substr(0, h._maxLength);
                }, 1);
            } else {
                if (!d) {
                    var d = window.event;
                }
                var c = true;
                var a = "";
                try {
                    a = window.clipboardData.getData("Text");
                } catch (d) {
                    c = false;
                }
                if (c && a != "") {
                    if (d.preventDefault) {
                        d.preventDefault();
                    }
                    var g = this._textBoxElement.document.selection.createRange();
                    var f = this._maxLength - this._textBoxElement.value.length + g.text.length;
                    var b = this._escapeNewLineChars(window.clipboardData.getData("Text"), "%0A").substr(0, f);
                    g.text = b;
                } else {
                    var h = this;
                    window.setTimeout(function () {
                        h._textBoxElement.value = h._textBoxElement.value.substr(0, h._maxLength);
                    }, 1);
                }
            }
        }
    },
    _onTextBoxInputHandler: function (a) {
        if (this.isMultiLine() && this._maxLength > 0 && this._textBoxElement.value.length > this._maxLength) {
            this._textBoxElement.value = this._textBoxElement.value.substr(0, this._maxLength);
        }
    },
    _attachMouseEventHandlers: function () {
        if ($telerik.isSafari || $telerik.isFirefox) {
            this._onTextBoxMouseUpDelegate = Function.createDelegate(this, this._onTextBoxMouseUpHandler);
            $addHandler(this._textBoxElement, "mouseup", this._onTextBoxMouseUpDelegate);
        }
        this._onTextBoxMouseOutDelegate = Function.createDelegate(this, this._onTextBoxMouseOutHandler);
        this._onTextBoxMouseOverDelegate = Function.createDelegate(this, this._onTextBoxMouseOverHandler);
        this._onTextBoxMouseWheelDelegate = Function.createDelegate(this, this._onTextBoxMouseWheelHandler);
        this._onTextBoxDragEnterDelegate = Function.createDelegate(this, this._onTextBoxDragEnterHandler);
        this._onTextBoxDragLeaveDelegate = Function.createDelegate(this, this._onTextBoxDragLeaveHandler);
        this._onTextBoxDragDropDelegate = Function.createDelegate(this, this._onTextBoxDragDropHandler);
        $addHandler(this._textBoxElement, "mouseout", this._onTextBoxMouseOutDelegate);
        $addHandler(this._textBoxElement, "mouseover", this._onTextBoxMouseOverDelegate);
        $addHandler(this._textBoxElement, "dragenter", this._onTextBoxDragEnterDelegate);
        if ($telerik.isFirefox) {
            $addHandler(this._textBoxElement, "dragexit", this._onTextBoxDragLeaveDelegate);
        } else {
            $addHandler(this._textBoxElement, "dragleave", this._onTextBoxDragLeaveDelegate);
        }
        if ($telerik.isFirefox && Sys.Browser.version < 3.5) {
            $addHandler(this._textBoxElement, "dragdrop", this._onTextBoxDragDropDelegate);
        } else {
            $addHandler(this._textBoxElement, "drop", this._onTextBoxDragDropDelegate);
        }
        if (!$telerik.isIE) {
            if ((!$telerik.isSafari2 && $telerik.isSafari) || $telerik.isOpera) {
                $addHandler(this._textBoxElement, "mousewheel", this._onTextBoxMouseWheelDelegate);
            } else {
                $addHandler(this._textBoxElement, "DOMMouseScroll", this._onTextBoxMouseWheelDelegate);
            }
        } else {
            $addHandler(this._textBoxElement, "mousewheel", this._onTextBoxMouseWheelDelegate);
        }
    },
    _onTextBoxMouseUpHandler: function (a) {
        if (($telerik.isSafari || $telerik.isFirefox) && this._allowApplySelection) {
            this._allowApplySelection = false;
            this._updateSelectionOnFocus();
            if (this.get_inputType && this.get_inputType() != Telerik.Web.UI.InputType.Text) {
                return;
            }
            a.preventDefault();
            a.stopPropagation();
        }
    },
    _cancelKeyPressEventIfMaxLengthReached: function (b) {
        var f = this._escapeNewLineChars(this._textBoxElement.value, " ");
        var d = this._maxLength;
        if (d > 0 && f.length >= d && this._isNormalChar(b)) {
            var a = false;
            if (document.selection) {
                if (document.selection.createRange().text) {
                    a = true;
                }
            } else {
                var c = this.get_caretPosition();
                if (c[0] || c[1]) {
                    a = true;
                }
            }
            if (!a) {
                b.stopPropagation();
                b.preventDefault();
                return false;
            }
        }
    },
    _onTextBoxKeyPressHandler: function (a) {
        this._isEnterPressed = false;
        var c = new Telerik.Web.UI.InputKeyPressEventArgs(a, a.charCode, String.fromCharCode(a.charCode));
        this.raise_keyPress(c);
        if (c.get_cancel()) {
            a.stopPropagation();
            a.preventDefault();
            return false;
        }
        if ((a.charCode == 13) && !this.isMultiLine()) {
            var b = this._textBoxElement.value;
            this._isEnterPressed = true;
            this.set_value(b);
            this._isEnterPressed = false;
            if (this.get_autoPostBack()) {
                a.stopPropagation();
                a.preventDefault();
                return false;
            }
            return true;
        }
        if (this.isMultiLine()) {
            return (this._cancelKeyPressEventIfMaxLengthReached(a));
        }
    },
    _onTextBoxKeyUpHandler: function (a) { },
    _onTextBoxBlurHandler: function (a) {
        this._focused = false;
        var b = this._textBoxElement.value;
        if (this._initialValueAsText + "" !== b) {
            this.set_value(b);
        } else {
            this.updateDisplayValue();
            this.updateCssClass();
        }
        this.raise_blur(Sys.EventArgs.Empty);
    },
    _onTextBoxFocusHandler: function (a) {
        if (!this.isReadOnly()) {
            this._allowApplySelection = true;
            this._updateStateOnFocus();
        }
        if (($telerik.isSafari || $telerik.isFirefox) && this.get_selectionOnFocus() != Telerik.Web.UI.SelectionOnFocus.None && this.get_selectionOnFocus() != Telerik.Web.UI.SelectionOnFocus.SelectAll) {
            var b = this;
            window.setTimeout(function () {
                b._triggerDomEvent("mouseup", b._textBoxElement);
            }, 1);
        }
    },
    _onTextBoxDragEnterHandler: function (a) {
        if (this.isEmpty() && this.get_emptyMessage() != "") {
            this.set_textBoxValue("");
        }
    },
    _onTextBoxDragLeaveHandler: function (a) {
        if (this.isEmpty() && this.get_emptyMessage() != "" && !$telerik.isMouseOverElement(this._textBoxElement, a)) {
            this.set_textBoxValue(this.get_emptyMessage());
        }
    },
    _updateStateOnFocus: function () {
        if (this._isDropped) {
            this._updateHiddenValue();
            this._isDropped = false;
        }
        this._focused = true;
        this.updateDisplayValue();
        this.updateCssClass();
        this._updateSelectionOnFocus();
        this.raise_focus(Sys.EventArgs.Empty);
    },
    _onTextBoxMouseOutHandler: function (a) {
        this._hovered = false;
        this.updateCssClass();
        this.raise_mouseOut(Sys.EventArgs.Empty);
    },
    _onTextBoxMouseOverHandler: function (a) {
        this._hovered = true;
        this.updateCssClass();
        this.raise_mouseOver(Sys.EventArgs.Empty);
    },
    _onTextBoxKeyDownHandler: function (a) {
        if (a.keyCode == 27 && !$telerik.isIE) {
            var b = this;
            window.setTimeout(function () {
                b.set_textBoxValue(b.get_editValue());
            }, 0);
        }
    },
    _onTextBoxMouseWheelHandler: function (a) {
        var b;
        if (this._focused) {
            if (a.rawEvent.wheelDelta) {
                b = a.rawEvent.wheelDelta / 120;
                if (window.opera) {
                    b = -b;
                }
            } else {
                if (a.detail) {
                    b = -a.rawEvent.detail / 3;
                } else {
                    if (a.rawEvent && a.rawEvent.detail) {
                        b = -a.rawEvent.detail / 3;
                    }
                }
            }
            if (b > 0) {
                this._handleWheel(false);
            } else {
                this._handleWheel(true);
            }
            a.stopPropagation();
            a.preventDefault();
        }
    },
    _onButtonClickHandler: function (a) {
        var b = new Telerik.Web.UI.InputButtonClickEventArgs(Telerik.Web.UI.InputButtonType.Button);
        this.raise_buttonClick(b);
    },
    _onTextBoxDragDropHandler: function (a) {
        this._isDropped = true;
        if ($telerik.isFirefox) {
            var b = this;
            window.setTimeout(function () {
                b._textBoxElement.focus();
            }, 1);
        }
    },
    _onFormResetHandler: function (a) {
        var b = this._constructValueFromInitialText(this._originalInitialValueAsText);
        this._setHiddenValue(b);
        this._initialValueAsText = this._text;
        this.set_displayValue(this._constructDisplayText(this._value));
        this.updateCssClass();
    },
    _calculateSelection: function () {
        if ((Sys.Browser.agent == Sys.Browser.Opera) || !document.selection) {
            this._selectionEnd = this._textBoxElement.selectionEnd;
            this._selectionStart = this._textBoxElement.selectionStart;
            return;
        }
        var b = end = 0;
        try {
            b = Math.abs(document.selection.createRange().moveStart("character", -10000000));
            if (b > 0) {
                b = this._calculateSelectionInternal(b);
            }
            end = Math.abs(document.selection.createRange().moveEnd("character", -10000000));
            if (end > 0) {
                end = this._calculateSelectionInternal(end);
            }
        } catch (a) { }
        this._selectionEnd = end;
        this._selectionStart = b;
    },
    _calculateSelectionInternal: function (e) {
        if (!this.isMultiLine()) {
            return e;
        }
        var a = Math.abs(this._textBoxElement.createTextRange().moveEnd("character", -10000000));
        var d = document.body.createTextRange();
        d.moveToElementText(this._textBoxElement);
        var b = Math.abs(d.moveStart("character", -10000000));
        var c = Math.abs(d.moveEnd("character", -10000000));
        if (c - a == b) {
            e -= b;
        }
        return e;
    },
    _SetValue: function (b) {
        var a = this._setHiddenValue(b);
        if (typeof (a) == "undefined" || a == true) {
            this.set_textBoxValue(this.get_editValue());
        }
    },
    _triggerDomEvent: function (a, c) {
        if (!a || a == "" || !c) {
            return;
        }
        if (a == "change") {
            this._textBoxElement.RadInputChangeFired = true;
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
        if (a == "change") {
            this._textBoxElement.RadInputChangeFired = false;
        }
    },
    _updateSelectionOnFocus: function () {
        if (!this._textBoxElement.value) {
            this.set_caretPosition(0);
        }
        switch (this.get_selectionOnFocus()) {
            case Telerik.Web.UI.SelectionOnFocus.None:
                break;
            case Telerik.Web.UI.SelectionOnFocus.CaretToBeginning:
                this.set_caretPosition(0);
                break;
            case Telerik.Web.UI.SelectionOnFocus.CaretToEnd:
                if (this._textBoxElement.value.length > 0) {
                    if ($telerik.isIE) {
                        var a = this._textBoxElement.value.replace(/\r/g, "").length;
                        if (a != this.get_caretPosition()) {
                            this.set_caretPosition(a);
                        }
                    } else {
                        this.set_caretPosition(this._textBoxElement.value.length);
                    }
                }
                break;
            case Telerik.Web.UI.SelectionOnFocus.SelectAll:
                this.selectAllText();
                break;
            default:
                this.set_caretPosition(0);
                break;
        }
    },
    _isInVisibleContainer: function (b) {
        var a = b;
        while ((typeof (a) != "undefined") && (a != null)) {
            if ((a.disabled == true) || (typeof (a.style) != "undefined" && ((typeof (a.style.display) != "undefined" && a.style.display == "none") || (typeof (a.style.visibility) != "undefined" && a.style.visibility == "hidden")))) {
                return false;
            }
            if (typeof (a.parentNode) != "undefined" && a.parentNode != null && a.parentNode != a && a.parentNode.tagName.toLowerCase() != "body") {
                a = a.parentNode;
            } else {
                return true;
            }
        }
        return true;
    },
    _applySelection: function () {
        if (!this._isInVisibleContainer(this._textBoxElement)) {
            return;
        }
        var c = this;
        if ((Sys.Browser.agent == Sys.Browser.Opera) || !document.selection) {
            this._textBoxElement.selectionStart = c._selectionStart;
            this._textBoxElement.selectionEnd = c._selectionEnd;
            return;
        }
        try {
            this._textBoxElement.select();
            sel = document.selection.createRange();
            sel.collapse();
            sel.moveStart("character", this._selectionStart);
            sel.collapse();
            sel.moveEnd("character", this._selectionEnd - this._selectionStart);
            sel.select();
        } catch (a) {
            var b = this;
            window.setTimeout(function () {
                document.body.focus();
                b._textBoxElement.select();
                sel = document.selection.createRange();
                sel.collapse();
                sel.moveStart("character", b._selectionStart);
                sel.collapse();
                sel.moveEnd("character", b._selectionEnd - b._selectionStart);
                sel.select();
            }, 1);
        }
    },
    _invalidate: function () {
        if (this._holdsValidValue) {
            this._holdsValidValue = false;
            this._initialValueAsText = "";
            this._displayText = "";
            this._clearHiddenValue();
            return false;
        }
    },
    _clearHiddenValue: function () {
        var a = this._errorHandlingCanceled;
        this._errorHandlingCanceled = true;
        this._setHiddenValue("");
        this._errorHandlingCanceled = a;
    },
    _handleWheel: function (a) { },
    _setHiddenValue: function (a) {
        if (a) {
            a = a.toString();
        } else {
            a = "";
        }
        if (a == this._value) {
            return false;
        } else {
            this._value = a;
            this._text = this._constructEditText(a);
            this.set_validationText(this._constructValidationText(a));
            this.updateClientState();
            return true;
        }
    },
    get_validationText: function (a) {
        return this._validationText;
    },
    set_validationText: function (a) {
        this._validationText = a;
        this._textBoxElement.RadInputValidationValue = a;
    },
    _updateHiddenValue: function () {
        if (!this._textBoxElement.readOnly) {
            return this._setHiddenValue(this._textBoxElement.value);
        }
    },
    _escapeNewLineChars: function (a, b) {
        a = escape(a);
        while (a.indexOf("%0D%0A") != -1) {
            a = a.replace("%0D%0A", b);
        }
        if (b != "%0A") {
            while (a.indexOf("%0A") != -1) {
                a = a.replace("%0A", b);
            }
        }
        if (b != "%0D") {
            while (a.indexOf("%0D") != -1) {
                a = a.replace("%0D", b);
            }
        }
        return unescape(a);
    },
    _isNormalChar: function (a) {
        if (($telerik.isFirefox && (a.rawEvent.keyCode != 0 && a.rawEvent.keyCode != 13) || a.ctrlKey) || ($telerik.isOpera && a.rawEvent.which == 0) || ($telerik.isSafari && (a.charCode < Sys.UI.Key.space || a.charCode > 60000))) {
            return false;
        }
        return true;
    },
    _constructEditText: function (a) {
        return a;
    },
    _constructDisplayText: function (a) {
        return a;
    },
    _constructValidationText: function (a) {
        return a;
    },
    _constructValueFromInitialText: function (a) {
        return a;
    },
    _canAutoPostBackAfterValidation: function () {
        if (!this.get_causesValidation() || !Page_ValidationActive) {
            return true;
        }
        return Page_ClientValidate(this.get_validationGroup());
    },
    add_blur: function (a) {
        this.get_events().addHandler("blur", a);
    },
    remove_blur: function (a) {
        this.get_events().removeHandler("blur", a);
    },
    raise_blur: function (a) {
        this.raiseEvent("blur", a);
    },
    add_mouseOut: function (a) {
        this.get_events().addHandler("mouseOut", a);
    },
    remove_mouseOut: function (a) {
        this.get_events().removeHandler("mouseOut", a);
    },
    raise_mouseOut: function (a) {
        this.raiseEvent("mouseOut", a);
    },
    add_valueChanged: function (a) {
        this.get_events().addHandler("valueChanged", a);
    },
    remove_valueChanged: function (a) {
        this.get_events().removeHandler("valueChanged", a);
    },
    raise_valueChanged: function (b, c) {
        if (typeof (b) != "undefined" && b != null && typeof (c) != "undefined" && c != null && b.toString() == c.toString()) {
            if (!this._isEnterPressed) {
                return false;
            }
        }
        var a = false;
        if (typeof (b) != "undefined" && b != null && typeof (c) != "undefined" && c != null) {
            if (b.toString() != c.toString()) {
                var d = new Telerik.Web.UI.InputValueChangedEventArgs(b, c);
                this.raiseEvent("valueChanged", d);
                a = !d.get_cancel();
            } else {
                a = this._isEnterPressed;
            }
        }
        if (this.get_autoPostBack() && a && this._canAutoPostBackAfterValidation()) {
            this.raisePostBackEvent();
        }
    },
    add_error: function (a) {
        this.get_events().addHandler("error", a);
    },
    remove_error: function (a) {
        this.get_events().removeHandler("error", a);
    },
    raise_error: function (c) {
        if (this.InEventRaise) {
            return;
        }
        this.InEventRaise = true;
        this.raiseEvent("error", c);
        if (!c.get_cancel()) {
            this._invalid = true;
            this._errorHandlingCanceled = false;
            this.updateCssClass();
            if (this.get_enableAriaSupport()) {
                this._applyAriaStateChange("invalid", true);
            }
            var d = this._isIncrementing ? true : false;
            var a = this;
            var b = function () {
                a._invalid = false;
                a.updateCssClass(d);
                if (a.get_enableAriaSupport()) {
                    a._applyAriaStateChange("invalid", false);
                }
            };
            setTimeout(function () {
                b();
            }, this.get_invalidStyleDuration());
        } else {
            this._errorHandlingCanceled = true;
            this._invalid = false;
            this.updateCssClass();
        }
        this.InEventRaise = false;
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
    add_mouseOver: function (a) {
        this.get_events().addHandler("mouseOver", a);
    },
    remove_mouseOver: function (a) {
        this.get_events().removeHandler("mouseOver", a);
    },
    raise_mouseOver: function (a) {
        this.raiseEvent("mouseOver", a);
    },
    add_focus: function (a) {
        this.get_events().addHandler("focus", a);
    },
    remove_focus: function (a) {
        this.get_events().removeHandler("focus", a);
    },
    raise_focus: function (a) {
        this.raiseEvent("focus", a);
    },
    add_disable: function (a) {
        this.get_events().addHandler("disable", a);
    },
    remove_disable: function (a) {
        this.get_events().removeHandler("disable", a);
    },
    raise_disable: function (a) {
        this.raiseEvent("disable", a);
    },
    add_enable: function (a) {
        this.get_events().addHandler("enable", a);
    },
    remove_enable: function (a) {
        this.get_events().removeHandler("enable", a);
    },
    raise_enable: function (a) {
        this.raiseEvent("enable", a);
    },
    add_keyPress: function (a) {
        this.get_events().addHandler("keyPress", a);
    },
    remove_keyPress: function (a) {
        this.get_events().removeHandler("keyPress", a);
    },
    raise_keyPress: function (a) {
        this.raiseEvent("keyPress", a);
    },
    add_enumerationChanged: function (a) {
        this.get_events().addHandler("enumerationChanged", a);
    },
    remove_enumerationChanged: function (a) {
        this.get_events().removeHandler("enumerationChanged", a);
    },
    raise_enumerationChanged: function (a) {
        this.raiseEvent("enumerationChanged", a);
    },
    add_moveUp: function (a) {
        this.get_events().addHandler("moveUp", a);
    },
    remove_moveUp: function (a) {
        this.get_events().removeHandler("moveUp", a);
    },
    raise_moveUp: function (a) {
        this.raiseEvent("moveUp", a);
    },
    add_moveDown: function (a) {
        this.get_events().addHandler("moveDown", a);
    },
    remove_moveDown: function (a) {
        this.get_events().removeHandler("moveDown", a);
    },
    raise_moveDown: function (a) {
        this.raiseEvent("moveDown", a);
    },
    add_buttonClick: function (a) {
        this.get_events().addHandler("buttonClick", a);
    },
    remove_buttonClick: function (a) {
        this.get_events().removeHandler("buttonClick", a);
    },
    raise_buttonClick: function (a) {
        this.raiseEvent("buttonClick", a);
    },
    add_valueChanging: function (a) {
        this.get_events().addHandler("valueChanging", a);
    },
    remove_valueChanging: function (a) {
        this.get_events().removeHandler("valueChanging", a);
    },
    raise_valueChanging: function (a) {
        this.raiseEvent("valueChanging", a);
    }
};
Telerik.Web.UI.RadInputControl.OverrideValidatorFunctions = function () {
    if (typeof (ValidatorGetValue) == "function" && typeof (ValidatorGetValue_Original) == "undefined") {
        ValidatorGetValue_Original = ValidatorGetValue;
        ValidatorGetValue = function (b) {
            var a = document.getElementById(b);
            if (typeof (a.RadInputValidationValue) == "string") {
                return a.RadInputValidationValue;
            } else {
                return ValidatorGetValue_Original(b);
            }
        };
    }
    if (typeof (ValidatorOnChange) == "function" && typeof (ValidatorOnChange_Original) == "undefined") {
        ValidatorOnChange_Original = ValidatorOnChange;
        ValidatorOnChange = function (a) {
            a = a || window.event;
            var b;
            if ((typeof (a.srcElement) != "undefined") && (a.srcElement != null)) {
                b = a.srcElement;
            } else {
                b = a.target;
            }
            if (typeof (b.RadInputValidationValue) != "string" || (typeof (b.RadInputChangeFired) == "boolean" && b.RadInputChangeFired)) {
                return ValidatorOnChange_Original(a);
            }
        };
    }
    if (typeof (ValidatedTextBoxOnKeyPress) == "function" && typeof (ValidatedTextBoxOnKeyPress_Original) == "undefined") {
        ValidatedTextBoxOnKeyPress_Original = ValidatedTextBoxOnKeyPress;
        ValidatedTextBoxOnKeyPress = function (a) {
            a = a || window.event;
            if (a.keyCode == 13) {
                ValidatorOnChange(a);
                var b;
                if ((typeof (a.srcElement) != "undefined") && (a.srcElement != null)) {
                    b = a.srcElement;
                } else {
                    b = a.target;
                }
                if (typeof (b.RadInputValidationValue) != "string") {
                    return AllValidatorsValid(b.Validators);
                }
            }
            return true;
        };
    }
};
Telerik.Web.UI.RadInputControl.registerClass("Telerik.Web.UI.RadInputControl", Telerik.Web.UI.RadWebControl);
Telerik.Web.UI.RadInputControl.CancelRawEventOnEnterKey = function (a, b) {
    if (b.get_keyCode() == 13) {
        return $telerik.cancelRawEvent(b.get_domEvent());
    }
};
Telerik.Web.UI.RadInputControl.OverrideValidatorFunctions();
Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.InputErrorReason = function () { };
Telerik.Web.UI.InputErrorReason.prototype = {
    ParseError: 1,
    OutOfRange: 2
};
Telerik.Web.UI.InputErrorReason.registerEnum("Telerik.Web.UI.InputErrorReason", false);
Telerik.Web.UI.SelectionOnFocus = function () { };
Telerik.Web.UI.SelectionOnFocus.prototype = {
    None: 0,
    CaretToBeginning: 1,
    CaretToEnd: 2,
    SelectAll: 3
};
Telerik.Web.UI.SelectionOnFocus.registerEnum("Telerik.Web.UI.SelectionOnFocus", false);
Telerik.Web.UI.InputButtonType = function () { };
Telerik.Web.UI.InputButtonType.prototype = {
    Button: 1,
    MoveUpButton: 2,
    MoveDownButton: 3
};
Telerik.Web.UI.InputButtonType.registerEnum("Telerik.Web.UI.InputButtonType", false);
Telerik.Web.UI.DisplayFormatPosition = function () { };
Telerik.Web.UI.DisplayFormatPosition.prototype = {
    Left: 1,
    Right: 2
};
Telerik.Web.UI.DisplayFormatPosition.registerEnum("Telerik.Web.UI.DisplayFormatPosition", false);
Telerik.Web.UI.InputSettingValidateOnEvent = function () { };
Telerik.Web.UI.InputSettingValidateOnEvent.prototype = {
    Blur: 0,
    Submit: 1,
    All: 2
};
Telerik.Web.UI.InputSettingValidateOnEvent.registerEnum("Telerik.Web.UI.InputSettingValidateOnEvent", false);
Telerik.Web.UI.InputType = function () { };
Telerik.Web.UI.InputType.prototype = {
    Text: 0,
    Date: 1,
    DateTime: 2,
    Number: 3,
    Time: 4
};
Telerik.Web.UI.InputType.registerEnum("Telerik.Web.UI.InputType", false);
Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.InputValueChangedEventArgs = function (b, a) {
    Telerik.Web.UI.InputValueChangedEventArgs.initializeBase(this);
    this._newValue = b;
    this._oldValue = a;
};
Telerik.Web.UI.InputValueChangedEventArgs.prototype = {
    get_oldValue: function () {
        return this._oldValue;
    },
    get_newValue: function () {
        return this._newValue;
    }
};
Telerik.Web.UI.InputValueChangedEventArgs.registerClass("Telerik.Web.UI.InputValueChangedEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.InputValueChangingEventArgs = function (b, a) {
    Telerik.Web.UI.InputValueChangingEventArgs.initializeBase(this, [b, a]);
};
Telerik.Web.UI.InputValueChangingEventArgs.prototype = {
    set_newValue: function (a) {
        if (this._newValue !== a) {
            this._newValue = a;
        }
    }
};
Telerik.Web.UI.InputValueChangingEventArgs.registerClass("Telerik.Web.UI.InputValueChangingEventArgs", Telerik.Web.UI.InputValueChangedEventArgs);
Telerik.Web.UI.MaskedTextBoxEventArgs = function (b, c, a) {
    Telerik.Web.UI.MaskedTextBoxEventArgs.initializeBase(this);
    this._newValue = b;
    this._oldValue = c;
    this._chunk = a;
};
Telerik.Web.UI.MaskedTextBoxEventArgs.prototype = {
    get_oldValue: function () {
        return this._oldValue;
    },
    get_newValue: function () {
        return this._newValue;
    },
    get_currentPart: function () {
        return this._chunk;
    }
};
Telerik.Web.UI.MaskedTextBoxEventArgs.registerClass("Telerik.Web.UI.MaskedTextBoxEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.InputKeyPressEventArgs = function (a, b, c) {
    Telerik.Web.UI.InputKeyPressEventArgs.initializeBase(this);
    this._domEvent = a;
    this._keyCode = b;
    this._keyCharacter = c;
};
Telerik.Web.UI.InputKeyPressEventArgs.prototype = {
    get_domEvent: function () {
        return this._domEvent;
    },
    get_keyCode: function () {
        return this._keyCode;
    },
    get_keyCharacter: function () {
        return this._keyCharacter;
    }
};
Telerik.Web.UI.InputKeyPressEventArgs.registerClass("Telerik.Web.UI.InputKeyPressEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.InputButtonClickEventArgs = function (a) {
    Telerik.Web.UI.InputButtonClickEventArgs.initializeBase(this);
    this._buttonType = a;
};
Telerik.Web.UI.InputButtonClickEventArgs.prototype = {
    get_buttonType: function () {
        return this._buttonType;
    }
};
Telerik.Web.UI.InputButtonClickEventArgs.registerClass("Telerik.Web.UI.InputButtonClickEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.InputErrorEventArgs = function (b, a) {
    Telerik.Web.UI.InputErrorEventArgs.initializeBase(this);
    this._reason = b;
    this._inputText = a;
};
Telerik.Web.UI.InputErrorEventArgs.prototype = {
    get_reason: function () {
        return this._reason;
    },
    get_inputText: function () {
        return this._inputText;
    }
};
Telerik.Web.UI.InputErrorEventArgs.registerClass("Telerik.Web.UI.InputErrorEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.NumericInputErrorEventArgs = function (a, b, c, d) {
    Telerik.Web.UI.NumericInputErrorEventArgs.initializeBase(this, [a, b]);
    this._keyCode = c;
    this._keyCharacter = d;
};
Telerik.Web.UI.NumericInputErrorEventArgs.prototype = {
    get_reason: function () {
        return this._reason;
    },
    get_inputText: function () {
        return this._inputText;
    },
    get_keyCode: function () {
        return this._keyCode;
    },
    get_keyCharacter: function () {
        return this._keyCharacter;
    }
};
Telerik.Web.UI.NumericInputErrorEventArgs.registerClass("Telerik.Web.UI.NumericInputErrorEventArgs", Telerik.Web.UI.InputErrorEventArgs);
Telerik.Web.UI.InputManagerKeyPressEventArgs = function (b, c, d, a) {
    Telerik.Web.UI.InputManagerKeyPressEventArgs.initializeBase(this, [b, c, d]);
    this._targetInput = a;
};
Telerik.Web.UI.InputManagerKeyPressEventArgs.prototype = {
    get_targetInput: function () {
        return this._targetInput;
    }
};
Telerik.Web.UI.InputManagerKeyPressEventArgs.registerClass("Telerik.Web.UI.InputManagerKeyPressEventArgs", Telerik.Web.UI.InputKeyPressEventArgs);
Telerik.Web.UI.InputManagerEventArgs = function (a, b) {
    Telerik.Web.UI.InputManagerEventArgs.initializeBase(this);
    this._targetInput = a;
    this._domEvent = b;
};
Telerik.Web.UI.InputManagerEventArgs.prototype = {
    get_targetInput: function () {
        return this._targetInput;
    },
    get_domEvent: function () {
        return this._domEvent;
    }
};
Telerik.Web.UI.InputManagerEventArgs.registerClass("Telerik.Web.UI.InputManagerEventArgs", Sys.EventArgs);
Telerik.Web.UI.InputManagerErrorEventArgs = function (b, c, a) {
    Telerik.Web.UI.InputManagerErrorEventArgs.initializeBase(this, [b, c]);
    this._targetInput = a;
};
Telerik.Web.UI.InputManagerErrorEventArgs.prototype = {
    get_targetInput: function () {
        return this._targetInput;
    },
    set_inputText: function (a) {
        this._inputText = a;
    }
};
Telerik.Web.UI.InputManagerErrorEventArgs.registerClass("Telerik.Web.UI.InputManagerErrorEventArgs", Telerik.Web.UI.InputErrorEventArgs);
Telerik.Web.UI.NumericInputManagerErrorEventArgs = function (b, c, d, e, a) {
    Telerik.Web.UI.NumericInputManagerErrorEventArgs.initializeBase(this, [b, c, d, e]);
    this._targetInput = a;
};
Telerik.Web.UI.NumericInputManagerErrorEventArgs.prototype = {
    get_targetInput: function () {
        return this._targetInput;
    }
};
Telerik.Web.UI.NumericInputManagerErrorEventArgs.registerClass("Telerik.Web.UI.NumericInputManagerErrorEventArgs", Telerik.Web.UI.NumericInputErrorEventArgs);
Telerik.Web.UI.InputManagerValidatingEventArgs = function (a) {
    Telerik.Web.UI.InputManagerValidatingEventArgs.initializeBase(this);
    this._input = a;
    this._isValid = true;
    this._context = null;
};
Telerik.Web.UI.InputManagerValidatingEventArgs.prototype = {
    get_input: function () {
        return this._input;
    },
    get_isValid: function () {
        return this._isValid;
    },
    set_isValid: function (a) {
        this._isValid = a;
    },
    get_context: function () {
        return this._context;
    },
    set_context: function (a) {
        this._context = a;
    }
};
Telerik.Web.UI.InputManagerValidatingEventArgs.registerClass("Telerik.Web.UI.InputManagerValidatingEventArgs", Sys.CancelEventArgs);
Telerik.Web.UI.PasswordStrengthCalculatingEventArgs = function (b, c, a) {
    Telerik.Web.UI.PasswordStrengthCalculatingEventArgs.initializeBase(this);
    this._passwordText = b;
    this._strengthScore = c;
    this._indicatorText = a;
};
Telerik.Web.UI.PasswordStrengthCalculatingEventArgs.prototype = {
    get_passwordText: function () {
        return this._passwordText;
    },
    get_strengthScore: function () {
        return this._strengthScore;
    },
    set_strengthScore: function (a) {
        if (typeof a == "number") {
            a = Math.ceil(a);
            if (a > 100) {
                a = 100;
            }
            if (a < 0) {
                a = 0;
            }
            this._strengthScore = a;
        }
    },
    set_indicatorText: function (a) {
        this._indicatorText = a;
    }
};
Telerik.Web.UI.PasswordStrengthCalculatingEventArgs.registerClass("Telerik.Web.UI.PasswordStrengthCalculatingEventArgs", Sys.EventArgs);
$telerik.findTextBox = $find;
$telerik.toTextBox = function (a) {
    return a;
};
Telerik.Web.UI.RadTextBox = function (a) {
    Telerik.Web.UI.RadTextBox.initializeBase(this, [a]);
    this._maxLength = 0;
    this._inputType = Telerik.Web.UI.InputType.Text;
    this._passwordSettings = null;
};
Telerik.Web.UI.RadTextBox.prototype = {
    initialize: function () {
        Telerik.Web.UI.RadTextBox.callBaseMethod(this, "initialize");
        if (this._passwordSettings != null) {
            if (this._passwordSettings.ShowIndicator) {
                Telerik.Web.UI.PasswordStrengthChecker.prototype.showStrength(this, this._textBoxElement, this._passwordSettings);
            }
        }
    },
    dispose: function () {
        Telerik.Web.UI.RadTextBox.callBaseMethod(this, "dispose");
    },
    _onTextBoxMouseWheelHandler: function (a) {
        return true;
    },
    _onTextBoxKeyUpHandler: function (a) {
        Telerik.Web.UI.RadTextBox.callBaseMethod(this, "_onTextBoxKeyUpHandler", [a]);
        if (this._passwordSettings != null) {
            if (this._passwordSettings.ShowIndicator) {
                Telerik.Web.UI.PasswordStrengthChecker.prototype.showStrength(this, this._textBoxElement, this._passwordSettings);
            }
        }
    },
    get_inputType: function () {
        return this._inputType;
    },
    set_inputType: function (a) {
        if (this._inputType !== a) {
            this._inputType = a;
            this.raisePropertyChanged("inputType");
        }
    },
    get_maxLength: function () {
        return this._maxLength;
    },
    set_maxLength: function (a) {
        if (this._maxLength !== a) {
            this._maxLength = a;
            this.raisePropertyChanged("maxLength");
        }
    },
    get_passwordSettings: function () {
        return this._passwordSettings;
    },
    set_passwordSettings: function (a) {
        if (this._passwordSettings !== a) {
            this._passwordSettings = a;
        }
    },
    raise_passwordStrengthCalculating: function (a) {
        this.raiseEvent("passwordStrengthCalculating", a);
    },
    add_passwordStrengthCalculating: function (a) {
        this.get_events().addHandler("passwordStrengthCalculating", a);
    },
    remove_passwordStrengthCalculating: function (a) {
        this.get_events().removeHandler("passwordStrengthCalculating", a);
    }
};
Telerik.Web.UI.RadTextBox.registerClass("Telerik.Web.UI.RadTextBox", Telerik.Web.UI.RadInputControl);