try {
    if (Sys.Browser.agent == Sys.Browser.InternetExplorer) {
        document.execCommand("BackgroundImageCache", false, true);
    }
} catch (err) {}
Type.registerNamespace("Telerik.Web.UI");
window.$telerik = window.TelerikCommonScripts = Telerik.Web.CommonScripts = {
    cloneJsObject: function (a, b) {
        if (!b) {
            b = {};
        }
        for (var c in a) {
            var d = a[c];
            b[c] = (d instanceof Array) ? Array.clone(d) : d;
        }
        return b;
    },
    isCloned: function () {
        return this._isCloned;
    },
    cloneControl: function (a, b, c) {
        if (!a) {
            return null;
        }
        if (!b) {
            b = Object.getType(a);
        }
        var d = a.__clonedProperties__;
        if (null == d) {
            d = a.__clonedProperties__ = $telerik._getPropertiesParameter(a, b);
        }
        if (!c) {
            c = a.get_element().cloneNode(true);
            c.removeAttribute("control");
            c.removeAttribute("id");
        }
        var f = $create(b, d, null, null, c);
        if (a._observerContext) {
            f._observerContext = a._observerContext;
        }
        var e = $telerik.cloneJsObject(a.get_events());
        f._events = e;
        f._events._list = $telerik.cloneJsObject(f._events._list);
        f._isCloned = true;
        f.isCloned = $telerik.isCloned;
        return f;
    },
    _getPropertiesParameter: function (a, e) {
        var d = {};
        var f = e.prototype;
        for (var c in f) {
            var g = a[c];
            if (typeof (g) == "function" && c.indexOf("get_") == 0) {
                var b = c.substring(4);
                if (null == a["set_" + b]) {
                    continue;
                }
                var h = g.call(a);
                if (null == h) {
                    continue;
                }
                d[b] = h;
            }
        }
        delete d.clientStateFieldID;
        delete d.id;
        return d;
    },
    getOuterSize: function (a) {
        var c = $telerik.getSize(a);
        var b = $telerik.getMarginBox(a);
        return {
            width: c.width + b.left + b.right,
            height: c.height + b.top + b.bottom
        };
    },
    getOuterBounds: function (a) {
        var c = $telerik.getBounds(a);
        var b = $telerik.getMarginBox(a);
        return {
            x: c.x - b.left,
            y: c.y - b.top,
            width: c.width + b.left + b.right,
            height: c.height + b.top + b.bottom
        };
    },
    getInvisibleParent: function (a) {
        while (a && a != document) {
            if ("none" == $telerik.getCurrentStyle(a, "display", "")) {
                return a;
            }
            a = a.parentNode;
        }
        return null;
    },
    isScrolledIntoView: function (c) {
        var f = c.ownerDocument;
        var a = (f.defaultView) ? f.defaultView : f.parentWindow;
        var e = $telerik.$(a).scrollTop(),
            g = e + $telerik.$(a).height(),
            b = $telerik.$(c).offset().top,
            d = b + $telerik.$(c).height();
        return ((b + ((d - b) / 4)) >= e && ((b + ((d - b) / 4)) <= g));
    },
    scrollIntoView: function (c) {
        if (!c || !c.parentNode) {
            return;
        }
        var e = null,
            a = c.offsetParent,
            f = c.offsetTop,
            d = 0;
        var g = c.parentNode;
        while (g != null) {
            var h = $telerik.getCurrentStyle(g, "overflowY");
            if (h == "scroll" || h == "auto") {
                e = g;
                break;
            }
            if (g == a) {
                f += g.offsetTop;
                a = g.offsetParent;
            }
            if (g.tagName == "BODY") {
                var b = g.ownerDocument;
                if (!$telerik.isIE && b.defaultView && b.defaultView.frameElement) {
                    d = b.defaultView.frameElement.offsetHeight;
                }
                e = g;
                break;
            }
            g = g.parentNode;
        }
        if (!e) {
            return;
        }
        if (!d) {
            d = e.offsetHeight;
        }
        if ((e.scrollTop + d) < (f + c.offsetHeight)) {
            e.scrollTop = (f + c.offsetHeight) - d;
        } else {
            if (f < (e.scrollTop)) {
                e.scrollTop = f;
            }
        }
    },
    isRightToLeft: function (b) {
        while (b && b.nodeType !== 9) {
            var a = $telerik.getCurrentStyle(b, "direction");
            if (b.dir == "rtl" || a == "rtl") {
                return true;
            }
            if (b.dir == "ltr" || a == "ltr") {
                return false;
            }
            b = b.parentNode;
        }
        return false;
    },
    getCorrectScrollLeft: function (a) {
        if ($telerik.isRightToLeft(a)) {
            return -(a.scrollWidth - a.offsetWidth - Math.abs(a.scrollLeft));
        } else {
            return a.scrollLeft;
        }
    },
    _borderStyleNames: ["borderTopStyle", "borderRightStyle", "borderBottomStyle", "borderLeftStyle"],
    _borderWidthNames: ["borderTopWidth", "borderRightWidth", "borderBottomWidth", "borderLeftWidth"],
    _paddingWidthNames: ["paddingTop", "paddingRight", "paddingBottom", "paddingLeft"],
    _marginWidthNames: ["marginTop", "marginRight", "marginBottom", "marginLeft"],
    radControls: [],
    registerControl: function (a) {
        if (!Array.contains(this.radControls, a)) {
            Array.add(this.radControls, a);
        }
    },
    unregisterControl: function (a) {
        Array.remove(this.radControls, a);
    },
    repaintChildren: function (c) {
        var b = c.get_element ? c.get_element() : c;
        for (var d = 0, a = this.radControls.length;
        d < a;
        d++) {
            var e = this.radControls[d];
            if (e.repaint && this.isDescendant(b, e.get_element())) {
                e.repaint();
            }
        }
    },
    _borderThickness: function () {
        $telerik._borderThicknesses = {};
        var a = document.createElement("div");
        var d = document.createElement("div");
        a.style.visibility = "hidden";
        a.style.position = "absolute";
        a.style.top = "-9999px";
        a.style.fontSize = "1px";
        d.style.height = "0px";
        d.style.overflow = "hidden";
        document.body.appendChild(a).appendChild(d);
        var c = a.offsetHeight;
        d.style.borderTop = "solid black";
        a.style.borderLeft = "1px solid red";
        d.style.borderTopWidth = "thin";
        $telerik._borderThicknesses.thin = a.offsetHeight - c;
        d.style.borderTopWidth = "medium";
        $telerik._borderThicknesses.medium = a.offsetHeight - c;
        d.style.borderTopWidth = "thick";
        $telerik._borderThicknesses.thick = a.offsetHeight - c;
        var b = $telerik.getComputedStyle(a, "border-left-color", null);
        var e = $telerik.getComputedStyle(d, "border-top-color", null);
        if (b && e && b == e) {
            document.documentElement.className += " _Telerik_a11y";
        }
        if (typeof (a.removeChild) !== "undefined") {
            a.removeChild(d);
        }
        document.body.removeChild(a);
        if (!$telerik.isSafari && !$telerik.isIE10Mode) {
            d.outerHTML = null;
        }
        if (!$telerik.isSafari && !$telerik.isIE10Mode) {
            a.outerHTML = null;
        }
        a = null;
        d = null;
    },
    getCurrentStyle: function (a, e, d) {
        var c = null;
        if (a) {
            if (a.currentStyle) {
                c = a.currentStyle[e];
            } else {
                if (document.defaultView && document.defaultView.getComputedStyle) {
                    var b = document.defaultView.getComputedStyle(a, null);
                    if (b) {
                        c = b[e];
                    }
                }
            }
            if (!c && a.style) {
                if (a.style.getPropertyValue) {
                    c = a.style.getPropertyValue(e);
                } else {
                    if (a.style.getAttribute) {
                        c = a.style.getAttribute(e);
                    }
                }
            }
        }
        if ((!c || c == "" || typeof (c) === "undefined")) {
            if (typeof (d) != "undefined") {
                c = d;
            } else {
                c = null;
            }
        }
        return c;
    },
    getComputedStyle: function (a, e, d) {
        var c = null;
        if (a) {
            if (a.currentStyle) {
                c = a.currentStyle[e];
            } else {
                if (document.defaultView && document.defaultView.getComputedStyle) {
                    var b = document.defaultView.getComputedStyle(a, null);
                    if (b) {
                        if (b.getPropertyValue) {
                            c = b.getPropertyValue(e);
                        } else {
                            c = b[e];
                        }
                    }
                }
            }
            if (!c && a.style) {
                if (a.style.getPropertyValue) {
                    c = a.style.getPropertyValue(e);
                } else {
                    if (a.style.getAttribute) {
                        c = a.style.getAttribute(e);
                    }
                }
            }
        }
        if ((!c || c == "" || typeof (c) === "undefined")) {
            if (typeof (d) != "undefined") {
                c = d;
            } else {
                c = null;
            }
        }
        return c;
    },
    getLocation: function (G) {
        var h = G && G.ownerDocument ? G.ownerDocument : document;
        if (G === h.documentElement) {
            return new Sys.UI.Point(0, 0);
        }
        if (Sys.Browser.agent == Sys.Browser.InternetExplorer) {
            if (G.window === G || G.nodeType === 9 || !G.getClientRects || !G.getBoundingClientRect || G.parentElement == null) {
                return new Sys.UI.Point(0, 0);
            }
            var M = G.getClientRects();
            if (!M || !M.length) {
                return new Sys.UI.Point(0, 0);
            }
            var K = M[0];
            var f = 0;
            var t = 0;
            var k = false;
            try {
                k = h.parentWindow.frameElement;
            } catch (u) {
                k = true;
            }
            if (k) {
                var d = G.getBoundingClientRect();
                if (!d) {
                    return new Sys.UI.Point(0, 0);
                }
                var x = K.left;
                var B = K.top;
                for (var e = 1;
                e < M.length;
                e++) {
                    var s = M[e];
                    if (s.left < x) {
                        x = s.left;
                    }
                    if (s.top < B) {
                        B = s.top;
                    }
                }
                f = x - d.left;
                t = B - d.top;
            }
            var n = 0;
            if (Sys.Browser.version < 8 || $telerik.quirksMode) {
                var C = 1;
                if (k && k.getAttribute) {
                    var q = k.getAttribute("frameborder");
                    if (q != null) {
                        C = parseInt(q, 10);
                        if (isNaN(C)) {
                            C = q.toLowerCase() == "no" ? 0 : 1;
                        }
                    }
                }
                n = 2 * C;
            }
            var F = h.documentElement;
            var H = K.left - n - f + $telerik.getCorrectScrollLeft(F);
            var I = K.top - n - t + F.scrollTop;
            var p = new Sys.UI.Point(Math.round(H), Math.round(I));
            if ($telerik.quirksMode) {
                p.x += $telerik.getCorrectScrollLeft(h.body);
                p.y += h.body.scrollTop;
            }
            return p;
        }
        var p = $telerik.originalGetLocation(G);
        if ($telerik.isOpera) {
            var l = null;
            var E = $telerik.getCurrentStyle(G, "display");
            if (E != "inline") {
                l = G.parentNode;
            } else {
                l = G.offsetParent;
            }
            while (l) {
                var m = l.tagName.toUpperCase();
                if (m == "BODY" || m == "HTML") {
                    break;
                }
                if (m == "TABLE" && l.parentNode && l.parentNode.style.display == "inline-block") {
                    var A = l.offsetLeft;
                    var w = l.style.display;
                    l.style.display = "inline-block";
                    if (l.offsetLeft > A) {
                        p.x += l.offsetLeft - A;
                    }
                    l.style.display = w;
                }
                p.x -= $telerik.getCorrectScrollLeft(l);
                p.y -= l.scrollTop;
                if (E != "inline") {
                    l = l.parentNode;
                } else {
                    l = l.offsetParent;
                }
            }
        }
        var a = Math.max(h.documentElement.scrollTop, h.body.scrollTop);
        var g = Math.max(h.documentElement.scrollLeft, h.body.scrollLeft);
        if ($telerik.isSafari) {
            if (a > 0 || g > 0) {
                var o = h.documentElement.getElementsByTagName("form");
                if (o && o.length > 0) {
                    var b = $telerik.originalGetLocation(o[0]);
                    if (b.y && b.y < 0) {
                        p.y += a;
                    }
                    if (b.x && b.x < 0) {
                        p.x += g;
                    }
                } else {
                    var N = G.parentNode,
                        J = false,
                        v = false;
                    while (N && N.tagName) {
                        var c = $telerik.originalGetLocation(N);
                        if (c.y < 0) {
                            J = true;
                        }
                        if (c.x < 0) {
                            v = true;
                        }
                        N = N.parentNode;
                    }
                    if (J) {
                        p.y += a;
                    }
                    if (v) {
                        p.x += g;
                    }
                }
            }
            var l = G.parentNode;
            var z = null;
            var D = null;
            while (l && l.tagName.toUpperCase() != "BODY" && l.tagName.toUpperCase() != "HTML") {
                if (l.tagName.toUpperCase() == "TD") {
                    z = l;
                } else {
                    if (l.tagName.toUpperCase() == "TABLE") {
                        D = l;
                    } else {
                        var L = $telerik.getCurrentStyle(l, "position");
                        if (L == "absolute" || L == "relative") {
                            var j = $telerik.getCurrentStyle(l, "borderTopWidth", 0);
                            var y = $telerik.getCurrentStyle(l, "borderLeftWidth", 0);
                            p.x += parseInt(j);
                            p.y += parseInt(y);
                        }
                    }
                }
                var L = $telerik.getCurrentStyle(l, "position");
                if (L == "absolute" || L == "relative") {
                    p.x -= l.scrollLeft;
                    p.y -= l.scrollTop;
                }
                if (z && D) {
                    p.x += parseInt($telerik.getCurrentStyle(D, "borderTopWidth"), 0);
                    p.y += parseInt($telerik.getCurrentStyle(D, "borderLeftWidth", 0));
                    if ($telerik.getCurrentStyle(D, "borderCollapse") != "collapse") {
                        p.x += parseInt($telerik.getCurrentStyle(z, "borderTopWidth", 0));
                        p.y += parseInt($telerik.getCurrentStyle(z, "borderLeftWidth", 0));
                    }
                    z = null;
                    D = null;
                } else {
                    if (D) {
                        if ($telerik.getCurrentStyle(D, "borderCollapse") != "collapse") {
                            p.x += parseInt($telerik.getCurrentStyle(D, "borderTopWidth", 0));
                            p.y += parseInt($telerik.getCurrentStyle(D, "borderLeftWidth", 0));
                        }
                        D = null;
                    }
                }
                l = l.parentNode;
            }
        }
        return p;
    },
    setLocation: function (b, a) {
        Sys.UI.DomElement.setLocation(b, a.x, a.y);
    },
    findControl: function (c, a) {
        var f = c.getElementsByTagName("*");
        for (var d = 0, e = f.length;
        d < e;
        d++) {
            var b = f[d].id;
            if (b && b.endsWith(a)) {
                return $find(b);
            }
        }
        return null;
    },
    findElement: function (c, a) {
        var f = c.getElementsByTagName("*");
        for (var d = 0, e = f.length;
        d < e;
        d++) {
            var b = f[d].id;
            if (b && b.endsWith(a)) {
                return $get(b);
            }
        }
        return null;
    },
    getContentSize: function (a) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        var c = $telerik.getSize(a);
        var d = $telerik.getBorderBox(a);
        var b = $telerik.getPaddingBox(a);
        return {
            width: c.width - d.horizontal - b.horizontal,
            height: c.height - d.vertical - b.vertical
        };
    },
    getSize: function (a) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        return {
            width: a.offsetWidth,
            height: a.offsetHeight
        };
    },
    setContentSize: function (a, c) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        if (!c) {
            throw Error.argumentNull("size");
        }
        if ($telerik.getCurrentStyle(a, "MozBoxSizing") == "border-box" || $telerik.getCurrentStyle(a, "BoxSizing") == "border-box") {
            var d = $telerik.getBorderBox(a);
            var b = $telerik.getPaddingBox(a);
            c = {
                width: c.width + d.horizontal + b.horizontal,
                height: c.height + d.vertical + b.vertical
            };
        }
        a.style.width = c.width.toString() + "px";
        a.style.height = c.height.toString() + "px";
    },
    setSize: function (a, d) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        if (!d) {
            throw Error.argumentNull("size");
        }
        var e = $telerik.getBorderBox(a);
        var c = $telerik.getPaddingBox(a);
        var b = {
            width: d.width - e.horizontal - c.horizontal,
            height: d.height - e.vertical - c.vertical
        };
        $telerik.setContentSize(a, b);
    },
    getBounds: function (b) {
        var a = $telerik.getLocation(b);
        return new Sys.UI.Bounds(a.x, a.y, b.offsetWidth || 0, b.offsetHeight || 0);
    },
    setBounds: function (b, a) {
        if (!b) {
            throw Error.argumentNull("element");
        }
        if (!a) {
            throw Error.argumentNull("bounds");
        }
        $telerik.setSize(b, a);
        $telerik.setLocation(b, a);
    },
    getClientBounds: function () {
        var b;
        var a;
        switch (Sys.Browser.agent) {
            case Sys.Browser.InternetExplorer:
                b = document.documentElement.clientWidth;
                a = document.documentElement.clientHeight;
                if (b == 0 && a == 0) {
                    b = document.body.clientWidth;
                    a = document.body.clientHeight;
                }
                break;
            case Sys.Browser.Safari:
                b = window.innerWidth;
                a = window.innerHeight;
                break;
            case Sys.Browser.Opera:
                if (Sys.Browser.version >= 9.5) {
                    b = Math.min(window.innerWidth, document.documentElement.clientWidth);
                    a = Math.min(window.innerHeight, document.documentElement.clientHeight);
                } else {
                    b = Math.min(window.innerWidth, document.body.clientWidth);
                    a = Math.min(window.innerHeight, document.body.clientHeight);
                }
                break;
            default:
                b = Math.min(window.innerWidth, document.documentElement.clientWidth);
                a = Math.min(window.innerHeight, document.documentElement.clientHeight);
                break;
        }
        return new Sys.UI.Bounds(0, 0, b, a);
    },
    getMarginBox: function (b) {
        if (!b) {
            throw Error.argumentNull("element");
        }
        var a = {
            top: $telerik.getMargin(b, Telerik.Web.BoxSide.Top),
            right: $telerik.getMargin(b, Telerik.Web.BoxSide.Right),
            bottom: $telerik.getMargin(b, Telerik.Web.BoxSide.Bottom),
            left: $telerik.getMargin(b, Telerik.Web.BoxSide.Left)
        };
        a.horizontal = a.left + a.right;
        a.vertical = a.top + a.bottom;
        return a;
    },
    getPaddingBox: function (b) {
        if (!b) {
            throw Error.argumentNull("element");
        }
        var a = {
            top: $telerik.getPadding(b, Telerik.Web.BoxSide.Top),
            right: $telerik.getPadding(b, Telerik.Web.BoxSide.Right),
            bottom: $telerik.getPadding(b, Telerik.Web.BoxSide.Bottom),
            left: $telerik.getPadding(b, Telerik.Web.BoxSide.Left)
        };
        a.horizontal = a.left + a.right;
        a.vertical = a.top + a.bottom;
        return a;
    },
    getBorderBox: function (b) {
        if (!b) {
            throw Error.argumentNull("element");
        }
        var a = {
            top: $telerik.getBorderWidth(b, Telerik.Web.BoxSide.Top),
            right: $telerik.getBorderWidth(b, Telerik.Web.BoxSide.Right),
            bottom: $telerik.getBorderWidth(b, Telerik.Web.BoxSide.Bottom),
            left: $telerik.getBorderWidth(b, Telerik.Web.BoxSide.Left)
        };
        a.horizontal = a.left + a.right;
        a.vertical = a.top + a.bottom;
        return a;
    },
    isBorderVisible: function (a, b) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        if (b < Telerik.Web.BoxSide.Top || b > Telerik.Web.BoxSide.Left) {
            throw Error.argumentOutOfRange(String.format(Sys.Res.enumInvalidValue, b, "Telerik.Web.BoxSide"));
        }
        var d = $telerik._borderStyleNames[b];
        var c = $telerik.getCurrentStyle(a, d);
        return c != "none";
    },
    getMargin: function (a, c) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        if (c < Telerik.Web.BoxSide.Top || c > Telerik.Web.BoxSide.Left) {
            throw Error.argumentOutOfRange(String.format(Sys.Res.enumInvalidValue, c, "Telerik.Web.BoxSide"));
        }
        var e = $telerik._marginWidthNames[c];
        var d = $telerik.getCurrentStyle(a, e);
        try {
            return $telerik.parsePadding(d);
        } catch (b) {
            return 0;
        }
    },
    getBorderWidth: function (a, b) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        if (b < Telerik.Web.BoxSide.Top || b > Telerik.Web.BoxSide.Left) {
            throw Error.argumentOutOfRange(String.format(Sys.Res.enumInvalidValue, b, "Telerik.Web.BoxSide"));
        }
        if (!$telerik.isBorderVisible(a, b)) {
            return 0;
        }
        var d = $telerik._borderWidthNames[b];
        var c = $telerik.getCurrentStyle(a, d);
        return $telerik.parseBorderWidth(c);
    },
    getPadding: function (a, b) {
        if (!a) {
            throw Error.argumentNull("element");
        }
        if (b < Telerik.Web.BoxSide.Top || b > Telerik.Web.BoxSide.Left) {
            throw Error.argumentOutOfRange(String.format(Sys.Res.enumInvalidValue, b, "Telerik.Web.BoxSide"));
        }
        var d = $telerik._paddingWidthNames[b];
        var c = $telerik.getCurrentStyle(a, d);
        return $telerik.parsePadding(c);
    },
    parseBorderWidth: function (a) {
        if (a) {
            switch (a) {
                case "thin":
                case "medium":
                case "thick":
                    return $telerik._borderThicknesses[a];
                case "inherit":
                    return 0;
            }
            var b = $telerik.parseUnit(a);
            return b.size;
        }
        return 0;
    },
    parsePadding: function (b) {
        if (b) {
            if (b == "auto" || b == "inherit") {
                return 0;
            }
            var a = $telerik.parseUnit(b);
            return a.size;
        }
        return 0;
    },
    parseUnit: function (d) {
        if (!d) {
            throw Error.argumentNull("value");
        }
        d = d.trim().toLowerCase();
        var g = d.length;
        var a = -1;
        for (var f = 0;
        f < g;
        f++) {
            var c = d.substr(f, 1);
            if ((c < "0" || c > "9") && c != "-" && c != "." && c != ",") {
                break;
            }
            a = f;
        }
        if (a == -1) {
            throw Error.create("No digits");
        }
        var e;
        var b;
        if (a < (g - 1)) {
            e = d.substring(a + 1).trim();
        } else {
            e = "px";
        }
        b = parseFloat(d.substr(0, a + 1));
        if (e == "px") {
            b = Math.floor(b);
        }
        return {
            size: b,
            type: e
        };
    },
    containsPoint: function (c, a, b) {
        return a >= c.x && a <= (c.x + c.width) && b >= c.y && b <= (c.y + c.height);
    },
    isDescendant: function (a, c) {
        try {
            for (var b = c.parentNode;
            b != null;
            b = b.parentNode) {
                if (b == a) {
                    return true;
                }
            }
        } catch (d) {}
        return false;
    },
    isDescendantOrSelf: function (a, b) {
        if (a === b) {
            return true;
        }
        return $telerik.isDescendant(a, b);
    },
    addCssClasses: function (a, b) {
        for (var c = 0;
        c < b.length;
        c++) {
            Sys.UI.DomElement.addCssClass(a, b[c]);
        }
    },
    removeCssClasses: function (a, b) {
        for (var c = 0;
        c < b.length;
        c++) {
            Sys.UI.DomElement.removeCssClass(a, b[c]);
        }
    },
    getScrollOffset: function (c, b) {
        var a = 0;
        var e = 0;
        var d = c;
        var f = c && c.ownerDocument ? c.ownerDocument : document;
        while (d != null && d.scrollLeft != null) {
            a += $telerik.getCorrectScrollLeft(d);
            e += d.scrollTop;
            if (!b || (d == f.body && (d.scrollLeft != 0 || d.scrollTop != 0))) {
                break;
            }
            d = d.parentNode;
        }
        return {
            x: a,
            y: e
        };
    },
    getElementByClassName: function (c, e, b) {
        var g = null;
        if (b) {
            g = c.getElementsByTagName(b);
        } else {
            g = c.getElementsByTagName("*");
        }
        for (var f = 0, d = g.length;
        f < d;
        f++) {
            var a = g[f];
            if (Sys.UI.DomElement.containsCssClass(a, e)) {
                return a;
            }
        }
        return null;
    },
    getElementsByClassName: function (c, b, a) {
        if (document.getElementsByClassName) {
            getElementsByClassName = function (g, m, e) {
                e = e || document;
                var k = e.getElementsByClassName(g),
                    j = (m) ? new RegExp("\\b" + m + "\\b", "i") : null,
                    l = [],
                    h;
                for (var d = 0, f = k.length;
                d < f;
                d += 1) {
                    h = k[d];
                    if (!j || j.test(h.nodeName)) {
                        l.push(h);
                    }
                }
                return l;
            };
        } else {
            if (document.evaluate) {
                getElementsByClassName = function (g, h, n) {
                    h = h || "*";
                    n = n || document;
                    var r = g.split(" "),
                        o = "",
                        p = "http://www.w3.org/1999/xhtml",
                        f = (document.documentElement.namespaceURI === p) ? p : null,
                        k = [],
                        l, i;
                    for (var q = 0, m = r.length;
                    q < m;
                    q += 1) {
                        o += "[contains(concat(' ', @class, ' '), ' " + r[q] + " ')]";
                    }
                    try {
                        l = document.evaluate(".//" + h + o, n, f, 0, null);
                    } catch (d) {
                        l = document.evaluate(".//" + h + o, n, null, 0, null);
                    }
                    while ((i = l.iterateNext())) {
                        k.push(i);
                    }
                    return k;
                };
            } else {
                getElementsByClassName = function (d, f, n) {
                    f = f || "*";
                    n = n || document;
                    var e = d.split(" "),
                        q = [],
                        i = (f === "*" && n.all) ? n.all : n.getElementsByTagName(f),
                        p, g = [],
                        o;
                    for (var r = 0, h = e.length;
                    r < h;
                    r += 1) {
                        q.push(new RegExp("(^|\\s)" + e[r] + "(\\s|$)"));
                    }
                    for (var t = 0, j = i.length;
                    t < j;
                    t += 1) {
                        p = i[t];
                        o = false;
                        for (var u = 0, s = q.length;
                        u < s;
                        u += 1) {
                            o = q[u].test(p.className);
                            if (!o) {
                                break;
                            }
                        }
                        if (o) {
                            g.push(p);
                        }
                    }
                    return g;
                };
            }
        }
        return getElementsByClassName(b, a, c);
    },
    _getWindow: function (b) {
        var a = b.ownerDocument || b.document || b;
        return a.defaultView || a.parentWindow;
    },
    useAttachEvent: function (a) {
        return (a.attachEvent && !$telerik.isOpera);
    },
    useDetachEvent: function (a) {
        return (a.detachEvent && !$telerik.isOpera);
    },
    addHandler: function (c, h, g, b) {
        if (!c._events) {
            c._events = {};
        }
        var f = c._events[h];
        if (!f) {
            c._events[h] = f = [];
        }
        var a;
        if ($telerik.useAttachEvent(c)) {
            a = function () {
                var d = {};
                try {
                    d = $telerik._getWindow(c).event;
                } catch (i) {}
                return g.call(c, new Sys.UI.DomEvent(d));
            };
            c.attachEvent("on" + h, a);
        } else {
            if (c.addEventListener) {
                a = function (d) {
                    return g.call(c, new Sys.UI.DomEvent(d));
                };
                c.addEventListener(h, a, false);
            }
        }
        f[f.length] = {
            handler: g,
            browserHandler: a,
            autoRemove: b
        };
        if (b) {
            var e = c.dispose;
            if (e !== $telerik._disposeHandlers) {
                c.dispose = $telerik._disposeHandlers;
                if (typeof (e) !== "undefined") {
                    c._chainDispose = e;
                }
            }
        }
    },
    addHandlers: function (b, e, d, a) {
        for (var c in e) {
            var f = e[c];
            if (d) {
                f = Function.createDelegate(d, f);
            }
            $telerik.addHandler(b, c, f, a || false);
        }
    },
    clearHandlers: function (a) {
        $telerik._clearHandlers(a, false);
    },
    _clearHandlers: function (a, g) {
        if (a._events) {
            var f = a._events;
            for (var b in f) {
                var c = f[b];
                for (var e = c.length - 1;
                e >= 0;
                e--) {
                    var d = c[e];
                    if (!g || d.autoRemove) {
                        $telerik.removeHandler(a, b, d.handler);
                    }
                }
            }
            a._events = null;
        }
    },
    _disposeHandlers: function () {
        $telerik._clearHandlers(this, true);
        var b = this._chainDispose,
            a = typeof (b);
        if (a !== "undefined") {
            this.dispose = b;
            this._chainDispose = null;
            if (a === "function") {
                this.dispose();
            }
        }
    },
    removeHandler: function (a, b, c) {
        $telerik._removeHandler(a, b, c);
    },
    _removeHandler: function (c, g, f) {
        var a = null;
        var b = c._events[g] || [];
        for (var e = 0, d = b.length;
        e < d;
        e++) {
            if (b[e].handler === f) {
                a = b[e].browserHandler;
                break;
            }
        }
        if ($telerik.useDetachEvent(c)) {
            c.detachEvent("on" + g, a);
        } else {
            if (c.removeEventListener) {
                c.removeEventListener(g, a, false);
            }
        }
        b.splice(e, 1);
    },
    _emptySrc: function () {
        return "about:blank";
    },
    addExternalHandler: function (a, b, c) {
        if (!a) {
            return;
        }
        if ($telerik.useAttachEvent(a)) {
            a.attachEvent("on" + b, c);
        } else {
            if (a.addEventListener) {
                a.addEventListener(b, c, false);
            }
        }
    },
    removeExternalHandler: function (a, b, c) {
        if (!a) {
            return;
        }
        if ($telerik.useDetachEvent(a)) {
            a.detachEvent("on" + b, c);
        } else {
            if (a.addEventListener) {
                a.removeEventListener(b, c, false);
            }
        }
    },
    addMobileHandler: function (g, a, c, e, f, d) {
        if (!a || !g) {
            return;
        }
        var b = Function.createDelegate(g, $telerik.isTouchDevice ? (f || e) : e);
        if ($telerik.isTouchDevice) {
            if ($telerik.$) {
                $telerik.$(a).bind($telerik.getMobileEventCounterpart(c), b);
            } else {
                $telerik.addExternalHandler(a, $telerik.getMobileEventCounterpart(c), b);
            }
        } else {
            if (d) {
                $telerik.addExternalHandler(a, c, b);
            } else {
                $addHandler(a, c, b);
            }
        }
        return b;
    },
    removeMobileHandler: function (a, c, d, b, e) {
        if (!a) {
            return;
        }
        if ($telerik.isTouchDevice) {
            if ($telerik.$) {
                $telerik.$(a).unbind($telerik.getMobileEventCounterpart(c), (b || d));
            } else {
                $telerik.removeExternalHandler(a, $telerik.getMobileEventCounterpart(c), (b || d));
            }
        } else {
            if (e) {
                $telerik.removeExternalHandler(a, c, d);
            } else {
                $removeHandler(a, c, d);
            }
        }
    },
    getMobileEventCounterpart: function (a) {
        switch (a) {
            case "mousedown":
                return "touchstart";
            case "mouseup":
                return "touchend";
            case "mousemove":
                return "touchmove";
        }
        return a;
    },
    getTouchEventLocation: function (d) {
        var f = arguments[1],
            b = f ? [f + "X"] : "pageX",
            c = f ? [f + "Y"] : "pageY",
            a = {
                x: d[b],
                y: d[c]
            }, g = d.changedTouches || (d.originalEvent ? d.originalEvent.changedTouches : d.rawEvent ? d.rawEvent.changedTouches : false);
        if ($telerik.isTouchDevice && g && g.length < 2) {
            a.x = g[0][b];
            a.y = g[0][c];
        }
        return a;
    },
    getTouchTarget: function (a) {
        if ($telerik.isTouchDevice) {
            var b = "originalEvent" in a ? a.originalEvent.changedTouches : "rawEvent" in a ? a.rawEvent.changedTouches : a.changedTouches;
            return b ? document.elementFromPoint(b[0].clientX, b[0].clientY) : a.target;
        } else {
            return a.target;
        }
    },
    cancelRawEvent: function (a) {
        if (!a) {
            return false;
        }
        if (a.preventDefault) {
            a.preventDefault();
        }
        if (a.stopPropagation) {
            a.stopPropagation();
        }
        a.cancelBubble = true;
        a.returnValue = false;
        return false;
    },
    getOuterHtml: function (a) {
        if (a.outerHTML) {
            return a.outerHTML;
        } else {
            var b = a.cloneNode(true);
            var c = a.ownerDocument.createElement("div");
            c.appendChild(b);
            return c.innerHTML;
        }
    },
    setVisible: function (a, b) {
        if (!a) {
            return;
        }
        if (b != $telerik.getVisible(a)) {
            if (b) {
                if (a.style.removeAttribute) {
                    a.style.removeAttribute("display");
                } else {
                    a.style.removeProperty("display");
                }
            } else {
                a.style.display = "none";
            }
            a.style.visibility = b ? "visible" : "hidden";
        }
    },
    getVisible: function (a) {
        if (!a) {
            return false;
        }
        return (("none" != $telerik.getCurrentStyle(a, "display")) && ("hidden" != $telerik.getCurrentStyle(a, "visibility")));
    },
    getViewPortSize: function () {
        var b = 0;
        var a = 0;
        var c = document.body;
        if (!$telerik.quirksMode && !$telerik.isSafari) {
            c = document.documentElement;
        }
        if (window.innerWidth) {
            b = Math.max(document.documentElement.clientWidth, document.body.clientWidth);
            a = Math.max(document.documentElement.clientHeight, document.body.clientHeight);
            if (b > window.innerWidth) {
                b = document.documentElement.clientWidth;
            }
            if (a > window.innerHeight) {
                a = document.documentElement.clientHeight;
            }
        } else {
            b = c.clientWidth;
            a = c.clientHeight;
        }
        b += c.scrollLeft;
        a += c.scrollTop;
        if ($telerik.isMobileSafari) {
            b += window.pageXOffset;
            a += window.pageYOffset;
        }
        return {
            width: b - 6,
            height: a - 6
        };
    },
    elementOverflowsTop: function (a, b) {
        var c = b || $telerik.getLocation(a);
        return c.y < 0;
    },
    elementOverflowsLeft: function (a, b) {
        var c = b || $telerik.getLocation(a);
        return c.x < 0;
    },
    elementOverflowsBottom: function (b, a, c) {
        var e = c || $telerik.getLocation(a);
        var d = e.y + a.offsetHeight;
        return d > b.height;
    },
    elementOverflowsRight: function (b, a, c) {
        var e = c || $telerik.getLocation(a);
        var d = e.x + a.offsetWidth;
        return d > b.width;
    },
    getDocumentRelativeCursorPosition: function (b) {
        var c = document.documentElement;
        var d = document.body;
        var f = b.clientX + ($telerik.getCorrectScrollLeft(c) + $telerik.getCorrectScrollLeft(d));
        var a = b.clientY + (c.scrollTop + d.scrollTop);
        if ($telerik.isIE && Sys.Browser.version < 8) {
            f -= 2;
            a -= 2;
        }
        return {
            left: f,
            top: a
        };
    },
    evalScriptCode: function (b) {
        if ($telerik.isSafari) {
            b = b.replace(/^\s*<!--((.|\n)*)-->\s*$/mi, "$1");
        }
        var a = document.createElement("script");
        a.setAttribute("type", "text/javascript");
        a.text = b;
        var c = document.getElementsByTagName("head")[0];
        c.appendChild(a);
        a.parentNode.removeChild(a);
    },
    isScriptRegistered: function (c, d) {
        if (!c) {
            return 0;
        }
        if (!d) {
            d = document;
        }
        if ($telerik._uniqueScripts == null) {
            $telerik._uniqueScripts = {};
        }
        var j = document.getElementsByTagName("script");
        var k = 0;
        var e = c.indexOf("?d=");
        var g = c.indexOf("&");
        var a = e > 0 && g > e ? c.substring(e + 3, g) : c;
        if ($telerik._uniqueScripts[a] != null) {
            return 2;
        }
        for (var h = 0, b = j.length;
        h < b;
        h++) {
            var f = j[h];
            if (f.src) {
                if (f.getAttribute("src", 2).indexOf(a) != -1) {
                    $telerik._uniqueScripts[a] = true;
                    if (!$telerik.isDescendant(d, f)) {
                        k++;
                    }
                }
            }
        }
        return k;
    },
    evalScripts: function (d, a) {
        $telerik.registerSkins(d);
        var e = d.getElementsByTagName("script");
        var k = 0,
            g = 0;
        var l = function (i, o) {
            if (i - g > 0 && ($telerik.isIE || $telerik.isSafari)) {
                window.setTimeout(function () {
                    l(i, o);
                }, 5);
            } else {
                var n = document.createElement("script");
                n.setAttribute("type", "text/javascript");
                document.getElementsByTagName("head")[0].appendChild(n);
                n.loadFinished = false;
                n.onload = function () {
                    if (!this.loadFinished) {
                        this.loadFinished = true;
                        g++;
                    }
                };
                n.onreadystatechange = function () {
                    if ("loaded" === this.readyState && !this.loadFinished) {
                        this.loadFinished = true;
                        g++;
                    }
                };
                n.setAttribute("src", o);
            }
        };
        var f = [];
        for (var b = 0, m = e.length;
        b < m;
        b++) {
            var h = e[b];
            if (h.src) {
                var c = h.getAttribute("src", 2);
                if (!$telerik.isScriptRegistered(c, d)) {
                    l(k++, c);
                }
            } else {
                Array.add(f, h.innerHTML);
            }
        }
        var j = function () {
            if (k - g > 0) {
                window.setTimeout(j, 20);
            } else {
                for (var i = 0;
                i < f.length;
                i++) {
                    $telerik.evalScriptCode(f[i]);
                }
                if (a) {
                    a();
                }
            }
        };
        j();
    },
    registerSkins: function (b) {
        if (!b) {
            b = document.body;
        }
        var f = b.getElementsByTagName("link");
        if (f && f.length > 0) {
            var a = document.getElementsByTagName("head")[0];
            if (a) {
                for (var k = 0, c = f.length;
                k < c;
                k++) {
                    var h = f[k];
                    if (h.className == "Telerik_stylesheet") {
                        var l = a.getElementsByTagName("link");
                        if (h.href.indexOf("ie7CacheFix") >= 0) {
                            try {
                                h.href = h.href.replace("&ie7CacheFix", "");
                                h.href = h.href.replace("?ie7CacheFix", "");
                            } catch (d) {}
                        }
                        if (l && l.length > 0) {
                            var g = l.length - 1;
                            while (g >= 0 && l[g--].href != h.href) {}
                            if (g >= 0) {
                                continue;
                            }
                        }
                        if ($telerik.isIE && !$telerik.isIE9Mode) {
                            h.parentNode.removeChild(h);
                            h = h.cloneNode(true);
                        }
                        a.appendChild(h);
                        if (c > f.length) {
                            c = f.length;
                            k--;
                        }
                    }
                }
            }
        }
    },
    getFirstChildByTagName: function (a, b, d) {
        if (!a || !a.childNodes) {
            return null;
        }
        var c = a.childNodes[d] || a.firstChild;
        while (c) {
            if (c.nodeType == 1 && c.tagName.toLowerCase() == b) {
                return c;
            }
            c = c.nextSibling;
        }
        return null;
    },
    getChildByClassName: function (a, d, b) {
        var c = a.childNodes[b] || a.firstChild;
        while (c) {
            if (c.nodeType == 1 && c.className.indexOf(d) > -1) {
                return c;
            }
            c = c.nextSibling;
        }
        return null;
    },
    getChildrenByTagName: function (e, b) {
        var g = new Array();
        var c = e.childNodes;
        if ($telerik.isIE) {
            c = e.children;
        }
        for (var f = 0, d = c.length;
        f < d;
        f++) {
            var a = c[f];
            if (a.nodeType == 1 && a.tagName.toLowerCase() == b) {
                Array.add(g, a);
            }
        }
        return g;
    },
    getChildrenByClassName: function (b, e) {
        var g = new Array();
        var c = b.childNodes;
        if ($telerik.isIE) {
            c = b.children;
        }
        for (var f = 0, d = c.length;
        f < d;
        f++) {
            var a = c[f];
            if (a.nodeType == 1 && a.className.indexOf(e) > -1) {
                Array.add(g, a);
            }
        }
        return g;
    },
    mergeElementAttributes: function (e, b, d) {
        if (!e || !b) {
            return;
        }
        if (e.mergeAttributes) {
            b.mergeAttributes(e, d);
        } else {
            for (var a = 0;
            a < e.attributes.length;
            a++) {
                var c = e.attributes[a].nodeValue;
                b.setAttribute(e.attributes[a].nodeName, c);
            }
            if ("" == b.getAttribute("style")) {
                b.removeAttribute("style");
            }
        }
    },
    isMouseOverElement: function (a, b) {
        var d = $telerik.getBounds(a);
        var c = $telerik.getDocumentRelativeCursorPosition(b);
        return $telerik.containsPoint(d, c.left, c.top);
    },
    isMouseOverElementEx: function (a, b) {
        var d = null;
        try {
            d = $telerik.getOuterBounds(a);
        } catch (b) {
            return false;
        }
        if (b && b.target) {
            var f = b.target.tagName;
            if (f == "SELECT" || f == "OPTION") {
                return true;
            }
            if (b.clientX < 0 || b.clientY < 0) {
                return true;
            }
        }
        var c = $telerik.getDocumentRelativeCursorPosition(b);
        d.x += 2;
        d.y += 2;
        d.width -= 4;
        d.height -= 4;
        return $telerik.containsPoint(d, c.left, c.top);
    },
    getPreviousHtmlNode: function (a) {
        if (!a || !a.previousSibling) {
            return null;
        }
        while (a.previousSibling) {
            if (a.previousSibling.nodeType == 1) {
                return a.previousSibling;
            }
            a = a.previousSibling;
        }
    },
    getNextHtmlNode: function (a) {
        if (!a || !a.nextSibling) {
            return null;
        }
        while (a.nextSibling) {
            if (a.nextSibling.nodeType == 1) {
                return a.nextSibling;
            }
            a = a.nextSibling;
        }
    },
    disposeElement: function (b) {
        if (typeof (Sys.WebForms) == "undefined") {
            return;
        }
        var a = Sys.WebForms.PageRequestManager.getInstance();
        if (a && a._destroyTree) {
            a._destroyTree(b);
        } else {
            if (Sys.Application.disposeElement) {
                Sys.Application.disposeElement(b, true);
            }
        }
    },
    htmlEncode: function (d) {
        var a = /&/g,
            c = /</g,
            b = />/g;
        return ("" + d).replace(a, "&amp;").replace(c, "&lt;").replace(b, "&gt;");
    },
    htmlDecode: function (d) {
        var a = /&amp;/g,
            c = /&lt;/g,
            b = /&gt;/g;
        return ("" + d).replace(b, ">").replace(c, "<").replace(a, "&");
    }
};
if (typeof (Sys.Browser.WebKit) == "undefined") {
    Sys.Browser.WebKit = {};
}
if (typeof (Sys.Browser.Chrome) == "undefined") {
    Sys.Browser.Chrome = {};
}
if (navigator.userAgent.indexOf("Chrome") > -1) {
    Sys.Browser.version = parseFloat(navigator.userAgent.match(/WebKit\/(\d+(\.\d+)?)/)[1]);
    Sys.Browser.agent = Sys.Browser.Chrome;
    Sys.Browser.name = "Chrome";
} else {
    if (navigator.userAgent.indexOf("WebKit/") > -1) {
        Sys.Browser.version = parseFloat(navigator.userAgent.match(/WebKit\/(\d+(\.\d+)?)/)[1]);
        if (Sys.Browser.version < 500) {
            Sys.Browser.agent = Sys.Browser.Safari;
            Sys.Browser.name = "Safari";
        } else {
            Sys.Browser.agent = Sys.Browser.WebKit;
            Sys.Browser.name = "WebKit";
        }
    }
}
$telerik.isMobileSafari = (navigator.userAgent.search(/like\sMac\sOS\sX.*Mobile\/\S+/) != -1);
$telerik.isChrome = Sys.Browser.agent == Sys.Browser.Chrome;
$telerik.isSafari6 = Sys.Browser.agent == Sys.Browser.WebKit && Sys.Browser.version >= 536;
$telerik.isSafari5 = Sys.Browser.agent == Sys.Browser.WebKit && Sys.Browser.version >= 534 && Sys.Browser.version < 536;
$telerik.isSafari4 = Sys.Browser.agent == Sys.Browser.WebKit && Sys.Browser.version >= 526 && Sys.Browser.version < 534;
$telerik.isSafari3 = Sys.Browser.agent == Sys.Browser.WebKit && Sys.Browser.version < 526 && Sys.Browser.version > 500;
$telerik.isSafari2 = Sys.Browser.agent == Sys.Browser.Safari;
$telerik.isSafari = $telerik.isSafari2 || $telerik.isSafari3 || $telerik.isSafari4 || $telerik.isSafari5 || $telerik.isSafari6 || $telerik.isChrome;
$telerik.isAndroid = (navigator.userAgent.search(/Android.*Safari\/\S+/i) != -1);
$telerik.isBlackBerry4 = (navigator.userAgent.search(/BlackBerry\d+\/4[\d\.]+/i) != -1);
$telerik.isBlackBerry5 = (navigator.userAgent.search(/BlackBerry\d+\/5[\d\.]+/i) != -1);
$telerik.isBlackBerry6 = (navigator.userAgent.search(/BlackBerry.*Safari\/\S+/i) != -1);
$telerik.isBlackBerry = $telerik.isBlackBerry4 || $telerik.isBlackBerry5 || $telerik.isBlackBerry6;
$telerik.isIE = Sys.Browser.agent == Sys.Browser.InternetExplorer;
$telerik.isIE6 = $telerik.isIE && Sys.Browser.version < 7;
$telerik.isIE7 = $telerik.isIE && (Sys.Browser.version == 7 || (document.documentMode && document.documentMode == 7));
$telerik.isIE8 = $telerik.isIE && (document.documentMode && document.documentMode == 8);
$telerik.isIE9 = $telerik.isIE && (document.documentMode && document.documentMode == 9);
$telerik.isIE9Mode = $telerik.isIE && (document.documentMode && document.documentMode >= 9);
$telerik.isIE10 = $telerik.isIE && (document.documentMode && document.documentMode == 10);
$telerik.isIE10Mode = $telerik.isIE && (document.documentMode && document.documentMode >= 10);
$telerik.isOpera = Sys.Browser.agent == Sys.Browser.Opera;
$telerik.isFirefox = Sys.Browser.agent == Sys.Browser.Firefox;
$telerik.isFirefox2 = $telerik.isFirefox && Sys.Browser.version < 3;
$telerik.isFirefox3 = $telerik.isFirefox && Sys.Browser.version >= 3;
$telerik.quirksMode = $telerik.isIE && document.compatMode != "CSS1Compat";
$telerik.standardsMode = !$telerik.quirksMode;
$telerik.OperaEngine = 0;
$telerik.OperaVersionString = window.opera ? window.opera.version() : 0;
$telerik.OperaVersion = $telerik.OperaVersionString ? (parseInt($telerik.OperaVersionString * 10) / 10) : 0;
if ($telerik.isOpera) {
    $telerik._prestoVersion = navigator.userAgent.match(/Presto\/(\d+\.(\d+)?)/);
    if ($telerik._prestoVersion) {
        $telerik.OperaEngine = parseInt($telerik._prestoVersion[1]) + (parseInt($telerik._prestoVersion[2]) / 100);
    }
}
$telerik.isOpera9 = $telerik.isOpera && $telerik.OperaVerNumber < 10;
$telerik.isOpera10 = $telerik.isOpera && $telerik.OperaVersion >= 10 && $telerik.OperaVersion < 10.5;
$telerik.isOpera105 = $telerik.isOpera && $telerik.OperaVersion >= 10.5;
$telerik.isOpera11 = $telerik.isOpera && $telerik.OperaVersion > 11;
$telerik.isMobileOpera = $telerik.isOpera && (navigator.userAgent.search(/opera (?:mobi|tablet)/i) != -1);
$telerik.isTouchDevice = $telerik.isMobileSafari || $telerik.isAndroid || $telerik.isBlackBerry6 || $telerik.isMobileOpera;
if ($telerik.isIE9Mode) {
    document.documentElement.className += " _Telerik_IE9";
}
if ($telerik.isOpera11) {
    document.documentElement.className += " _Telerik_Opera11";
} else {
    if ($telerik.isOpera105) {
        document.documentElement.className += " _Telerik_Opera105";
    }
}
if (document.documentElement.getBoundingClientRect) {
    $telerik.originalGetLocation = function (c) {
        var h = Function._validateParams(arguments, [{
            name: "element",
            domElement: true
        }]);
        if (h) {
            throw h;
        }
        if (c.self || c.nodeType === 9 || (c === document.documentElement) || (c.parentNode === c.ownerDocument.documentElement)) {
            return new Sys.UI.Point(0, 0);
        }
        var j = c.getBoundingClientRect();
        if (!j) {
            return new Sys.UI.Point(0, 0);
        }
        var a = c.ownerDocument.documentElement,
            k = Math.round(j.left) + a.scrollLeft,
            l = Math.round(j.top) + a.scrollTop;
        if (Sys.Browser.agent === Sys.Browser.InternetExplorer) {
            try {
                var i = c.ownerDocument.parentWindow.frameElement || null;
                if (i) {
                    var b = (i.frameBorder === "0" || i.frameBorder === "no") ? 2 : 0;
                    k += b;
                    l += b;
                }
            } catch (n) {}
            if (Sys.Browser.version === 7 && !document.documentMode) {
                var m = document.body,
                    g = m.getBoundingClientRect(),
                    d = (g.right - g.left) / m.clientWidth;
                d = Math.round(d * 100);
                d = (d - d % 5) / 100;
                if (!isNaN(d) && (d !== 1)) {
                    k = Math.round(k / d);
                    l = Math.round(l / d);
                }
            }
            if ((document.documentMode || 0) < 8) {
                k -= a.clientLeft;
                l -= a.clientTop;
            }
        }
        return new Sys.UI.Point(k, l);
    };
} else {
    if ($telerik.isSafari) {
        $telerik.originalGetLocation = function (d) {
            var f = Function._validateParams(arguments, [{
                name: "element",
                domElement: true
            }]);
            if (f) {
                throw f;
            }
            if ((d.window && (d.window === d)) || d.nodeType === 9) {
                return new Sys.UI.Point(0, 0);
            }
            var i = 0,
                j = 0,
                g, l = null,
                b = null,
                c;
            for (g = d;
            g;
            l = g, b = c, g = g.offsetParent) {
                c = Sys.UI.DomElement._getCurrentStyle(g);
                var a = g.tagName ? g.tagName.toUpperCase() : null;
                if ((g.offsetLeft || g.offsetTop) && ((a !== "BODY") || (!b || b.position !== "absolute"))) {
                    i += g.offsetLeft;
                    j += g.offsetTop;
                }
                if (l && Sys.Browser.version >= 3) {
                    i += parseInt(c.borderLeftWidth);
                    j += parseInt(c.borderTopWidth);
                }
            }
            c = Sys.UI.DomElement._getCurrentStyle(d);
            var h = c ? c.position : null;
            if (!h || (h !== "absolute")) {
                for (g = d.parentNode;
                g;
                g = g.parentNode) {
                    a = g.tagName ? g.tagName.toUpperCase() : null;
                    if ((a !== "BODY") && (a !== "HTML") && (g.scrollLeft || g.scrollTop)) {
                        i -= (g.scrollLeft || 0);
                        j -= (g.scrollTop || 0);
                    }
                    c = Sys.UI.DomElement._getCurrentStyle(g);
                    var k = c ? c.position : null;
                    if (k && (k === "absolute")) {
                        break;
                    }
                }
            }
            return new Sys.UI.Point(i, j);
        };
    } else {
        $telerik.originalGetLocation = function (d) {
            var f = Function._validateParams(arguments, [{
                name: "element",
                domElement: true
            }]);
            if (f) {
                throw f;
            }
            if ((d.window && (d.window === d)) || d.nodeType === 9) {
                return new Sys.UI.Point(0, 0);
            }
            var i = 0,
                j = 0,
                g, k = null,
                b = null,
                c = null;
            for (g = d;
            g;
            k = g, b = c, g = g.offsetParent) {
                var a = g.tagName ? g.tagName.toUpperCase() : null;
                c = Sys.UI.DomElement._getCurrentStyle(g);
                if ((g.offsetLeft || g.offsetTop) && !((a === "BODY") && (!b || b.position !== "absolute"))) {
                    i += g.offsetLeft;
                    j += g.offsetTop;
                }
                if (k !== null && c) {
                    if ((a !== "TABLE") && (a !== "TD") && (a !== "HTML")) {
                        i += parseInt(c.borderLeftWidth) || 0;
                        j += parseInt(c.borderTopWidth) || 0;
                    }
                    if (a === "TABLE" && (c.position === "relative" || c.position === "absolute")) {
                        i += parseInt(c.marginLeft) || 0;
                        j += parseInt(c.marginTop) || 0;
                    }
                }
            }
            c = Sys.UI.DomElement._getCurrentStyle(d);
            var h = c ? c.position : null;
            if (!h || (h !== "absolute")) {
                for (g = d.parentNode;
                g;
                g = g.parentNode) {
                    a = g.tagName ? g.tagName.toUpperCase() : null;
                    if ((a !== "BODY") && (a !== "HTML") && (g.scrollLeft || g.scrollTop)) {
                        i -= (g.scrollLeft || 0);
                        j -= (g.scrollTop || 0);
                        c = Sys.UI.DomElement._getCurrentStyle(g);
                        if (c) {
                            i += parseInt(c.borderLeftWidth) || 0;
                            j += parseInt(c.borderTopWidth) || 0;
                        }
                    }
                }
            }
            return new Sys.UI.Point(i, j);
        };
    }
}
Sys.Application.add_init(function () {
    try {
        $telerik._borderThickness();
    } catch (a) {}
});
Telerik.Web.UI.Orientation = function () {
    throw Error.invalidOperation();
};
Telerik.Web.UI.Orientation.prototype = {
    Horizontal: 0,
    Vertical: 1
};
Telerik.Web.UI.Orientation.registerEnum("Telerik.Web.UI.Orientation", false);
Telerik.Web.UI.RadWebControl = function (a) {
    Telerik.Web.UI.RadWebControl.initializeBase(this, [a]);
    this._clientStateFieldID = null;
    this._shouldUpdateClientState = true;
    this._invisibleParents = [];
};
Telerik.Web.UI.RadWebControl.prototype = {
    initialize: function () {
        Telerik.Web.UI.RadWebControl.callBaseMethod(this, "initialize");
        $telerik.registerControl(this);
        if (!this.get_clientStateFieldID()) {
            return;
        }
        var a = $get(this.get_clientStateFieldID());
        if (!a) {
            return;
        }
        a.setAttribute("autocomplete", "off");
    },
    dispose: function () {
        $telerik.unregisterControl(this);
        var a = this.get_element();
        this._clearParentShowHandlers();
        Telerik.Web.UI.RadWebControl.callBaseMethod(this, "dispose");
        if (a) {
            a.control = null;
            var b = true;
            if (a._events) {
                for (var c in a._events) {
                    if (a._events[c].length > 0) {
                        b = false;
                        break;
                    }
                }
                if (b) {
                    a._events = null;
                }
            }
        }
    },
    raiseEvent: function (a, c) {
        var b = this.get_events().getHandler(a);
        if (b) {
            if (!c) {
                c = Sys.EventArgs.Empty;
            }
            b(this, c);
        }
    },
    updateClientState: function () {
        if (this._shouldUpdateClientState) {
            this.set_clientState(this.saveClientState());
        }
    },
    saveClientState: function () {
        return null;
    },
    get_clientStateFieldID: function () {
        return this._clientStateFieldID;
    },
    set_clientStateFieldID: function (a) {
        if (this._clientStateFieldID != a) {
            this._clientStateFieldID = a;
            this.raisePropertyChanged("ClientStateFieldID");
        }
    },
    get_clientState: function () {
        if (this._clientStateFieldID) {
            var a = document.getElementById(this._clientStateFieldID);
            if (a) {
                return a.value;
            }
        }
        return null;
    },
    set_clientState: function (a) {
        if (this._clientStateFieldID) {
            var b = document.getElementById(this._clientStateFieldID);
            if (b) {
                b.value = a;
            }
        }
    },
    repaint: function () {},
    canRepaint: function () {
        return this.get_element().offsetWidth > 0;
    },
    add_parentShown: function (b) {
        var a = $telerik.getInvisibleParent(b);
        if (!a) {
            return;
        }
        if (!Array.contains(this._invisibleParents, a)) {
            Array.add(this._invisibleParents, a);
            this._handleHiddenParent(true, a);
        }
    },
    remove_parentShown: function (a) {
        Array.remove(this._invisibleParents, a);
        this._handleHiddenParent(false, a);
    },
    _handleHiddenParent: function (a, c) {
        if (!c) {
            return;
        }
        if (!this._parentShowDelegate) {
            this._parentShowDelegate = Function.createDelegate(this, this._parentShowHandler);
        }
        var e = this._parentShowDelegate;
        var d = "DOMAttrModified";
        if ($telerik.isIE) {
            d = "propertychange";
        }
        var b = a ? $telerik.addExternalHandler : $telerik.removeExternalHandler;
        b(c, d, e);
    },
    _parentShowHandler: function (b) {
        if ($telerik.isIE) {
            if (b.rawEvent) {
                var b = b.rawEvent;
            }
            if (!b || !b.srcElement || !b.propertyName) {
                return;
            }
            var a = b.srcElement;
            if (b.propertyName == "style.display" || b.propertyName == "className") {
                var d = $telerik.getCurrentStyle(a, "display");
                if (d != "none") {
                    b.target = a;
                    this._runWhenParentShows(b);
                }
            }
        } else {
            if (b.attrName == "style" || b.attrName == "class") {
                var c = b.target;
                if ((b.currentTarget == b.target) && ("none" != $telerik.getCurrentStyle(c, "display"))) {
                    window.setTimeout(Function.createDelegate(this, function () {
                        this._runWhenParentShows(b);
                    }), 0);
                }
            }
        }
    },
    _runWhenParentShows: function (a) {
        var b = a.target;
        this.remove_parentShown(b);
        this.repaint();
    },
    _clearParentShowHandlers: function () {
        var b = this._invisibleParents;
        for (var a = 0;
        a < b.length;
        a++) {
            this.remove_parentShown(b[a]);
        }
        this._invisibleParents = [];
        this._parentShowDelegate = null;
    },
    _getChildElement: function (a) {
        return $get(this.get_id() + "_" + a);
    },
    _findChildControl: function (a) {
        return $find(this.get_id() + "_" + a);
    }
};
Telerik.Web.UI.RadWebControl.registerClass("Telerik.Web.UI.RadWebControl", Sys.UI.Control);
Telerik.Web.Timer = function () {
    Telerik.Web.Timer.initializeBase(this);
    this._interval = 1000;
    this._enabled = false;
    this._timer = null;
    this._timerCallbackDelegate = Function.createDelegate(this, this._timerCallback);
};
Telerik.Web.Timer.prototype = {
    get_interval: function () {
        return this._interval;
    },
    set_interval: function (a) {
        if (this._interval !== a) {
            this._interval = a;
            this.raisePropertyChanged("interval");
            if (!this.get_isUpdating() && (this._timer !== null)) {
                this._stopTimer();
                this._startTimer();
            }
        }
    },
    get_enabled: function () {
        return this._enabled;
    },
    set_enabled: function (a) {
        if (a !== this.get_enabled()) {
            this._enabled = a;
            this.raisePropertyChanged("enabled");
            if (!this.get_isUpdating()) {
                if (a) {
                    this._startTimer();
                } else {
                    this._stopTimer();
                }
            }
        }
    },
    add_tick: function (a) {
        this.get_events().addHandler("tick", a);
    },
    remove_tick: function (a) {
        this.get_events().removeHandler("tick", a);
    },
    dispose: function () {
        this.set_enabled(false);
        this._stopTimer();
        Telerik.Web.Timer.callBaseMethod(this, "dispose");
    },
    updated: function () {
        Telerik.Web.Timer.callBaseMethod(this, "updated");
        if (this._enabled) {
            this._stopTimer();
            this._startTimer();
        }
    },
    _timerCallback: function () {
        var a = this.get_events().getHandler("tick");
        if (a) {
            a(this, Sys.EventArgs.Empty);
        }
    },
    _startTimer: function () {
        this._timer = window.setInterval(this._timerCallbackDelegate, this._interval);
    },
    _stopTimer: function () {
        window.clearInterval(this._timer);
        this._timer = null;
    }
};
Telerik.Web.Timer.registerClass("Telerik.Web.Timer", Sys.Component);
Telerik.Web.BoxSide = function () {};
Telerik.Web.BoxSide.prototype = {
    Top: 0,
    Right: 1,
    Bottom: 2,
    Left: 3
};
Telerik.Web.BoxSide.registerEnum("Telerik.Web.BoxSide", false);
Telerik.Web.UI.WebServiceLoaderEventArgs = function (a) {
    Telerik.Web.UI.WebServiceLoaderEventArgs.initializeBase(this);
    this._context = a;
};
Telerik.Web.UI.WebServiceLoaderEventArgs.prototype = {
    get_context: function () {
        return this._context;
    }
};
Telerik.Web.UI.WebServiceLoaderEventArgs.registerClass("Telerik.Web.UI.WebServiceLoaderEventArgs", Sys.EventArgs);
Telerik.Web.UI.WebServiceLoaderSuccessEventArgs = function (b, a) {
    Telerik.Web.UI.WebServiceLoaderSuccessEventArgs.initializeBase(this, [a]);
    this._data = b;
};
Telerik.Web.UI.WebServiceLoaderSuccessEventArgs.prototype = {
    get_data: function () {
        return this._data;
    }
};
Telerik.Web.UI.WebServiceLoaderSuccessEventArgs.registerClass("Telerik.Web.UI.WebServiceLoaderSuccessEventArgs", Telerik.Web.UI.WebServiceLoaderEventArgs);
Telerik.Web.UI.WebServiceLoaderErrorEventArgs = function (a, b) {
    Telerik.Web.UI.WebServiceLoaderErrorEventArgs.initializeBase(this, [b]);
    this._message = a;
};
Telerik.Web.UI.WebServiceLoaderErrorEventArgs.prototype = {
    get_message: function () {
        return this._message;
    }
};
Telerik.Web.UI.WebServiceLoaderErrorEventArgs.registerClass("Telerik.Web.UI.WebServiceLoaderErrorEventArgs", Telerik.Web.UI.WebServiceLoaderEventArgs);
Telerik.Web.UI.WebServiceLoader = function (a) {
    this._webServiceSettings = a;
    this._events = null;
    this._onWebServiceSuccessDelegate = Function.createDelegate(this, this._onWebServiceSuccess);
    this._onWebServiceErrorDelegate = Function.createDelegate(this, this._onWebServiceError);
    this._currentRequest = null;
};
Telerik.Web.UI.WebServiceLoader.prototype = {
    get_webServiceSettings: function () {
        return this._webServiceSettings;
    },
    get_events: function () {
        if (!this._events) {
            this._events = new Sys.EventHandlerList();
        }
        return this._events;
    },
    loadData: function (a, b) {
        var c = this.get_webServiceSettings();
        this.invokeMethod(c.get_method(), a, b);
    },
    invokeMethod: function (b, a, d) {
        var c = this.get_webServiceSettings();
        if (c.get_isEmpty()) {
            alert("Please, specify valid web service and method.");
            return;
        }
        this._raiseEvent("loadingStarted", new Telerik.Web.UI.WebServiceLoaderEventArgs(d));
        var f = c.get_path();
        var e = c.get_useHttpGet();
        this._currentRequest = Sys.Net.WebServiceProxy.invoke(f, b, e, a, this._onWebServiceSuccessDelegate, this._onWebServiceErrorDelegate, d);
    },
    add_loadingStarted: function (a) {
        this.get_events().addHandler("loadingStarted", a);
    },
    add_loadingError: function (a) {
        this.get_events().addHandler("loadingError", a);
    },
    add_loadingSuccess: function (a) {
        this.get_events().addHandler("loadingSuccess", a);
    },
    _serializeDictionaryAsKeyValuePairs: function (b) {
        var a = [];
        for (var c in b) {
            a[a.length] = {
                Key: c,
                Value: b[c]
            };
        }
        return a;
    },
    _onWebServiceSuccess: function (c, a) {
        var b = new Telerik.Web.UI.WebServiceLoaderSuccessEventArgs(c, a);
        this._raiseEvent("loadingSuccess", b);
    },
    _onWebServiceError: function (a, b) {
        var c = new Telerik.Web.UI.WebServiceLoaderErrorEventArgs(a.get_message(), b);
        this._raiseEvent("loadingError", c);
    },
    _raiseEvent: function (a, c) {
        var b = this.get_events().getHandler(a);
        if (b) {
            if (!c) {
                c = Sys.EventArgs.Empty;
            }
            b(this, c);
        }
    }
};
Telerik.Web.UI.WebServiceLoader.registerClass("Telerik.Web.UI.WebServiceLoader");
Telerik.Web.UI.WebServiceSettings = function (a) {
    this._path = null;
    this._method = null;
    this._useHttpGet = false;
    this._odata = false;
    if (!a) {
        a = {};
    }
    if (typeof (a.path) != "undefined") {
        this._path = a.path;
    }
    if (typeof (a.method) != "undefined") {
        this._method = a.method;
    }
    if (typeof (a.useHttpGet) != "undefined") {
        this._useHttpGet = a.useHttpGet;
    }
};
Telerik.Web.UI.WebServiceSettings.prototype = {
    get_isWcf: function () {
        return /\.svc$/.test(this._path) && !this.get_isOData();
    },
    get_isOData: function () {
        return this._odata;
    },
    get_path: function () {
        return this._path;
    },
    set_path: function (a) {
        this._path = a;
    },
    get_method: function () {
        return this._method;
    },
    set_method: function (a) {
        this._method = a;
    },
    get_useHttpGet: function () {
        return this._useHttpGet;
    },
    set_useHttpGet: function (a) {
        this._useHttpGet = a;
    },
    get_isEmpty: function () {
        var b = this.get_path();
        var a = this.get_method();
        return (!(b && a));
    }
};
Telerik.Web.UI.WebServiceSettings.registerClass("Telerik.Web.UI.WebServiceSettings");
Telerik.Web.UI.CallbackLoader = function (a) {
    this._callbackSettings = a;
};
Telerik.Web.UI.CallbackLoader.prototype = {
    invokeCallbackMethod: function () {
        WebForm_DoCallback(this._callbackSettings._id, this._callbackSettings._arguments, this._callbackSettings._onCallbackSuccess, this._callbackSettings._context, this._callbackSettings._onCallbackError, this._callbackSettings._isAsync);
    }
};
Telerik.Web.UI.CallbackLoader.registerClass("Telerik.Web.UI.CallbackLoader");
Telerik.Web.UI.CallbackSettings = function (a) {
    this._id = a.id;
    this._arguments = a.arguments;
    this._onCallbackSuccess = a.onCallbackSuccess;
    this._context = a.context;
    this._onCallbackError = a.onCallbackError;
    this._isAsync = a.isAsync;
};
Telerik.Web.UI.CallbackSettings.registerClass("Telerik.Web.UI.CallbackSettings");
Telerik.Web.UI.ActionsManager = function (a) {
    Telerik.Web.UI.ActionsManager.initializeBase(this);
    this._actions = [];
    this._currentActionIndex = -1;
};
Telerik.Web.UI.ActionsManager.prototype = {
    get_actions: function () {
        return this._actions;
    },
    shiftPointerLeft: function () {
        this._currentActionIndex--;
    },
    shiftPointerRight: function () {
        this._currentActionIndex++;
    },
    get_currentAction: function () {
        return this.get_actions()[this._currentActionIndex];
    },
    get_nextAction: function () {
        return this.get_actions()[this._currentActionIndex + 1];
    },
    addAction: function (a) {
        if (a) {
            var b = new Telerik.Web.UI.ActionsManagerEventArgs(a);
            this.raiseEvent("executeAction", b);
            this._clearActionsToRedo();
            Array.add(this._actions, a);
            this._currentActionIndex = this._actions.length - 1;
            return true;
        }
        return false;
    },
    undo: function (a) {
        if (a == null) {
            a = 1;
        }
        if (a > this._actions.length) {
            a = this._actions.length;
        }
        var d = 0;
        var b = null;
        while (0 < a-- && 0 <= this._currentActionIndex && this._currentActionIndex < this._actions.length) {
            b = this._actions[this._currentActionIndex--];
            if (b) {
                var c = new Telerik.Web.UI.ActionsManagerEventArgs(b);
                this.raiseEvent("undoAction", c);
                d++;
            }
        }
    },
    redo: function (a) {
        if (a == null) {
            a = 1;
        }
        if (a > this._actions.length) {
            a = this._actions.length;
        }
        var d = 0;
        var b = null;
        var e = this._currentActionIndex + 1;
        while (0 < a-- && 0 <= e && e < this._actions.length) {
            b = this._actions[e];
            if (b) {
                var c = new Telerik.Web.UI.ActionsManagerEventArgs(b);
                this.raiseEvent("redoAction", c);
                this._currentActionIndex = e;
                d++;
            }
            e++;
        }
    },
    removeActionAt: function (a) {
        this._actions.splice(a, 1);
        if (this._currentActionIndex >= a) {
            this._currentActionIndex--;
        }
    },
    canUndo: function () {
        return (-1 < this._currentActionIndex);
    },
    canRedo: function () {
        return (this._currentActionIndex < this._actions.length - 1);
    },
    getActionsToUndo: function () {
        if (this.canUndo()) {
            return (this._actions.slice(0, this._currentActionIndex + 1)).reverse();
        }
        return [];
    },
    getActionsToRedo: function () {
        if (this.canRedo()) {
            return this._actions.slice(this._currentActionIndex + 1);
        }
        return [];
    },
    _clearActionsToRedo: function () {
        if (this.canRedo()) {
            var a = this._currentActionIndex + 2;
            if (a < this._actions.length) {
                this._actions.splice(a, this._actions.length - a);
            }
        }
    },
    add_undoAction: function (a) {
        this.get_events().addHandler("undoAction", a);
    },
    remove_undoAction: function (a) {
        this.get_events().removeHandler("undoAction", a);
    },
    add_redoAction: function (a) {
        this.get_events().addHandler("redoAction", a);
    },
    remove_redoAction: function (a) {
        this.get_events().removeHandler("redoAction", a);
    },
    add_executeAction: function (a) {
        this.get_events().addHandler("executeAction", a);
    },
    remove_executeAction: function (a) {
        this.get_events().removeHandler("executeAction", a);
    },
    raiseEvent: function (a, c) {
        var b = this.get_events().getHandler(a);
        if (b) {
            b(this, c);
        }
    }
};
Telerik.Web.UI.ActionsManager.registerClass("Telerik.Web.UI.ActionsManager", Sys.Component);
Telerik.Web.UI.ActionsManagerEventArgs = function (a) {
    Telerik.Web.UI.ActionsManagerEventArgs.initializeBase(this);
    this._action = a;
};
Telerik.Web.UI.ActionsManagerEventArgs.prototype = {
    get_action: function () {
        return this._action;
    }
};
Telerik.Web.UI.ActionsManagerEventArgs.registerClass("Telerik.Web.UI.ActionsManagerEventArgs", Sys.CancelEventArgs);
Telerik.Web.StringBuilder = function (a) {
    this._buffer = a || [];
};
Telerik.Web.StringBuilder.prototype = {
    append: function (b) {
        for (var a = 0;
        a < arguments.length;
        a++) {
            this._buffer[this._buffer.length] = arguments[a];
        }
        return this;
    },
    toString: function () {
        return this._buffer.join("");
    },
    get_buffer: function () {
        return this._buffer;
    }
};
(function () {
    function g() {
        if ($telerik.$) {
            return $telerik.$.extend.apply($telerik.$, arguments);
        }
        var k = arguments[0] && typeof (arguments[0]) === "object" ? arguments[0] : {};
        for (var l = 1;
        l < arguments.length;
        l++) {
            var m = arguments[l];
            if (m != null) {
                for (var j in m) {
                    var n = m[j];
                    if (typeof (n) !== "undefined") {
                        k[j] = n;
                    }
                }
            }
        }
        return k;
    }
    function f(k, l) {
        if (l) {
            return "'" + k.split("'").join("\\'").replace(/\n/g, "\\n").replace(/\r/g, "\\r").replace(/\t/g, "\\t") + "'";
        } else {
            var i = k.charAt(0),
                j = k.substring(1);
            if (i === "=") {
                return "+(" + j + ")+";
            } else {
                if (i === ":") {
                    return "+e(" + j + ")+";
                } else {
                    return ";" + k + ";o+=";
                }
            }
        }
    }
    var a = /^\w+/,
        h = /\${([^}]*)}/g,
        c = /\\}/g,
        e = /__CURLY__/g,
        d = /\\#/g,
        b = /__SHARP__/g;
    Telerik.Web.UI.Template = {
        paramName: "data",
        useWithBlock: true,
        render: function (l, m) {
            var i, k, j = "";
            for (i = 0, k = m.length;
            i < k;
            i++) {
                j += l(m[i]);
            }
            return j;
        },
        compile: function (r, n) {
            var l = g({}, this, n),
                k = l.paramName,
                i = k.match(a)[0],
                m = l.useWithBlock,
                j = "var o,e=$telerik.htmlEncode;",
                p, q, s;
            if (typeof (r) === "function") {
                if (r.length === 2) {
                    return function (t) {
                        return r($telerik.$ || jQuery, {
                            data: t
                        }).join("");
                    };
                }
                return r;
            }
            j += m ? "with(" + k + "){" : "";
            j += "o=";
            p = r.replace(c, "__CURLY__").replace(h, "#=e($1)#").replace(e, "}").replace(d, "__SHARP__").split("#");
            for (s = 0;
            s < p.length;
            s++) {
                j += f(p[s], s % 2 === 0);
            }
            j += m ? ";}" : ";";
            j += "return o;";
            j = j.replace(b, "#");
            try {
                return new Function(i, j);
            } catch (o) {
                throw new Error(String.format("Invalid template:'{0}' Generated code:'{1}'", r, j));
            }
        }
    };
})();
if (Sys && Sys.WebForms && Sys.WebForms.PageRequestManager) {
    Sys.WebForms.PageRequestManager.prototype._onFormElementClick = function (a) {
        if ($telerik.isIE10) {
            this._activeDefaultButtonClicked = (a.target === this._activeDefaultButton);
            this._onFormElementActive(a.target, parseInt(a.offsetX), parseInt(a.offsetY));
        } else {
            this._activeDefaultButtonClicked = (a.target === this._activeDefaultButton);
            this._onFormElementActive(a.target, a.offsetX, a.offsetY);
        }
    };
}