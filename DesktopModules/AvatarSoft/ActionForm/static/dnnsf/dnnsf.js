;
/*
 * DnnSF (DNN Sharp Foundation)
 */

/*yepnope1.5.x|WTFPL*/
(function (a, b, c) { function d(a) { return "[object Function]" == o.call(a) } function e(a) { return "string" == typeof a } function f() { } function g(a) { return !a || "loaded" == a || "complete" == a || "uninitialized" == a } function h() { var a = p.shift(); q = 1, a ? a.t ? m(function () { ("c" == a.t ? B.injectCss : B.injectJs)(a.s, 0, a.a, a.x, a.e, 1) }, 0) : (a(), h()) : q = 0 } function i(a, c, d, e, f, i, j) { function k(b) { if (!o && g(l.readyState) && (u.r = o = 1, !q && h(), l.onload = l.onreadystatechange = null, b)) { "img" != a && m(function () { t.removeChild(l) }, 50); for (var d in y[c]) y[c].hasOwnProperty(d) && y[c][d].onload() } } var j = j || B.errorTimeout, l = b.createElement(a), o = 0, r = 0, u = { t: d, s: c, e: f, a: i, x: j }; 1 === y[c] && (r = 1, y[c] = []), "object" == a ? l.data = c : (l.src = c, l.type = a), l.width = l.height = "0", l.onerror = l.onload = l.onreadystatechange = function () { k.call(this, r) }, p.splice(e, 0, u), "img" != a && (r || 2 === y[c] ? (t.insertBefore(l, s ? null : n), m(k, j)) : y[c].push(l)) } function j(a, b, c, d, f) { return q = 0, b = b || "j", e(a) ? i("c" == b ? v : u, a, b, this.i++, c, d, f) : (p.splice(this.i++, 0, a), 1 == p.length && h()), this } function k() { var a = B; return a.loader = { load: j, i: 0 }, a } var l = b.documentElement, m = a.setTimeout, n = b.getElementsByTagName("script")[0], o = {}.toString, p = [], q = 0, r = "MozAppearance" in l.style, s = r && !!b.createRange().compareNode, t = s ? l : n.parentNode, l = a.opera && "[object Opera]" == o.call(a.opera), l = !!b.attachEvent && !l, u = r ? "object" : l ? "script" : "img", v = l ? "script" : u, w = Array.isArray || function (a) { return "[object Array]" == o.call(a) }, x = [], y = {}, z = { timeout: function (a, b) { return b.length && (a.timeout = b[0]), a } }, A, B; B = function (a) { function b(a) { var a = a.split("!"), b = x.length, c = a.pop(), d = a.length, c = { url: c, origUrl: c, prefixes: a }, e, f, g; for (f = 0; f < d; f++) g = a[f].split("="), (e = z[g.shift()]) && (c = e(c, g)); for (f = 0; f < b; f++) c = x[f](c); return c } function g(a, e, f, g, h) { var i = b(a), j = i.autoCallback; i.url.split(".").pop().split("?").shift(), i.bypass || (e && (e = d(e) ? e : e[a] || e[g] || e[a.split("/").pop().split("?")[0]]), i.instead ? i.instead(a, e, f, g, h) : (y[i.url] ? i.noexec = !0 : y[i.url] = 1, f.load(i.url, i.forceCSS || !i.forceJS && "css" == i.url.split(".").pop().split("?").shift() ? "c" : c, i.noexec, i.attrs, i.timeout), (d(e) || d(j)) && f.load(function () { k(), e && e(i.origUrl, h, g), j && j(i.origUrl, h, g), y[i.url] = 2 }))) } function h(a, b) { function c(a, c) { if (a) { if (e(a)) c || (j = function () { var a = [].slice.call(arguments); k.apply(this, a), l() }), g(a, j, b, 0, h); else if (Object(a) === a) for (n in m = function () { var b = 0, c; for (c in a) a.hasOwnProperty(c) && b++; return b }(), a) a.hasOwnProperty(n) && (!c && !--m && (d(j) ? j = function () { var a = [].slice.call(arguments); k.apply(this, a), l() } : j[n] = function (a) { return function () { var b = [].slice.call(arguments); a && a.apply(this, b), l() } }(k[n])), g(a[n], j, b, n, h)) } else !c && l() } var h = !!a.test, i = a.load || a.both, j = a.callback || f, k = j, l = a.complete || f, m, n; c(h ? a.yep : a.nope, !!i), i && c(i) } var i, j, l = this.yepnope.loader; if (e(a)) g(a, 0, l, 0); else if (w(a)) for (i = 0; i < a.length; i++) j = a[i], e(j) ? g(j, 0, l, 0) : w(j) ? B(j) : Object(j) === j && h(j, l); else Object(a) === a && h(a, l) }, B.addPrefix = function (a, b) { z[a] = b }, B.addFilter = function (a) { x.push(a) }, B.errorTimeout = 1e4, null == b.readyState && b.addEventListener && (b.readyState = "loading", b.addEventListener("DOMContentLoaded", A = function () { b.removeEventListener("DOMContentLoaded", A, 0), b.readyState = "complete" }, 0)), a.yepnope = k(), a.yepnope.executeStack = h, a.yepnope.injectJs = function (a, c, d, e, i, j) { var k = b.createElement("script"), l, o, e = e || B.errorTimeout; k.src = a; for (o in d) k.setAttribute(o, d[o]); c = j ? h : c || f, k.onreadystatechange = k.onload = function () { !l && g(k.readyState) && (l = 1, c(), k.onload = k.onreadystatechange = null) }, m(function () { l || (l = 1, c(1)) }, e), i ? k.onload() : n.parentNode.insertBefore(k, n) }, a.yepnope.injectCss = function (a, c, d, e, g, i) { var e = b.createElement("link"), j, c = i ? h : c || f; e.href = a, e.rel = "stylesheet", e.type = "text/css"; for (j in d) e.setAttribute(j, d[j]); g || (n.parentNode.insertBefore(e, n), m(c, 0)) } })(this, document);


var dnnsf = dnnsf || {};

// copy state into dnnsf
for (var key in g_dnnsfState)
    dnnsf[key] = g_dnnsfState[key];

// extend with common functions
dnnsf.init = function ($, appState) {
    // save dnnsfjQuery object for future use
    dnnsf.$ = $;

    // execute the initialization code when done loading
    $(function () {

        // media query support in IE7&8
        yepnope({
            test: $.support.opacity == false,
            yep: [
                appState.appUrl + '/static/html5/html5shiv.js',
                appState.appUrl + '/static/html5/respond.min.js'
            ]
        });

        // if we're in an iframe, hide the scrollbar of current window and rely on auto-height featre
        if (window.top != window) {
            $('body').css('overflow', 'hidden').attr('scroll', 'no');
        }

    });
};

// returns a query string parameter by name
dnnsf.urlParam = function (name) {
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (!results) { return 0; }
    return results[1] || 0;
};


// this scrolls the page to given scroll, taking into account offset and iframe communication when applicable
dnnsf.scrollTo = function (scroll) {

    if (isNaN(scroll))
        return;

    if (window.top != window) {
        // post to top window
        window.top.postMessage(JSON.stringify({
            type: dnnsf.urlParam('comm-prefix') + "-scroll",
            offset: scroll
        }), "*");
    } else {
        // scroll this window
        $('html, body').animate({
            scrollTop: scroll
        }, 500);
    }

};

// always use this logging function since it will take care of disabling the logging on production 
//   and also it measures execution time (not very precisely though)
dnnsf.log = function () {
    if (!this.isDebug || !window.console || !console.log)
        return;

    // append timestamp to list of arguments
    var args = Array.prototype.slice.call(arguments);
    args.push(new Date().getTime() - this.start);

    // call the broser logging function
    // TODO: in IE objects are no expanded, instead IE will show [Object object] string
    // it would be useful to do a JSON.stringify on IE
    Function.apply.call(console.log, console, args);
};

dnnsf.adminApi = function (method, args) {
    var url = g_dnnsfState.adminApi + '?method=' + method + '&alias=' + dnnsf.alias + '&mid=' + g_dnnsfState.moduleId;
    if (!args)
        return url;

    for (var name in args) {
        if (args.hasOwnProperty(name))
            url += '&' + name + '=' + encodeURIComponent(args[name]);
    }
    return url;
};

dnnsf.parseCssBlock = function (styleContent) {

    var rules = {};
    dnnsf.$.each(styleContent.split(';'), function(i, part) {
        var isep = part.indexOf(':');
        if (isep == -1)
            return; // ?
        rules[dnnsf.$.trim(part.substr(0, isep))] = dnnsf.$.trim(part.substr(isep + 1));
    });

    return rules;
};

dnnsf.stackTrace = function () {

    //return '';
    //var e = new Error('dummy');
    //var stack = e.stack.replace(/^[^\(]+?[\n$]/gm, '')
    //    .replace(/^\s+at\s+/gm, '')
    //    .replace(/^Object.<anonymous>\s*\(/gm, '{anonymous}()@')
    //    .split('\n');
    //// remove the call to this function
    //stack.splice(0, 1);
    //return stack;
};

// this function tries to guess if a string is an object or array
dnnsf.eval = function (obj) {

    if (typeof (obj) != 'string')
        return obj;

    if (!isNaN(parseInt(obj)))
        return parseInt(obj);

    if (!isNaN(parseFloat(obj)))
        return parseFloat(obj);

    // TODO: find a better way to determine json arrays and objects - for example with a regex
    if (obj[0] == '[' || obj[0] == '{')
        return eval(obj);

    if (obj == "false")
        return false;

    if (obj == "true")
        return true;

    // just return it as string
    return obj;
};

// if object is array, return it, otheriwse return a new array with only this item
dnnsf.toArray = function (obj) {
    if (!obj) return [];
    if (!$.isArray(obj))
        obj = [obj];
    return obj;
};

dnnsf.tryParseBool = function (o) {
    //  JSON values aren't necessary strings
    if (typeof (o) !== 'string')
        return o;

    if (o.toLowerCase() == 'true')
        return true;

    if (o.toLowerCase() == 'false')
        return false;

    return o;
};


// returns baseId + altId if altId exists, otherwise generates an unique string
dnnsf.uniqueId = function (baseId, altId) {
    if (!altId || altId == -1)
        return baseId + new Date().getTime() + Math.floor(Math.random() * 10000);
    return baseId + altId;
}


// also register a dnnsf service for angular
if (typeof angular != "undefined") {
    angular.module('dnnsf', []).service('dnnsf', ['$timeout', function ($timeout) {

        this.env = dnnsf;
        this.start = new Date().getTime();

        // copy everything in dnnsf
        for (var key in dnnsf)
            this[key] = dnnsf[key];
    }]);
}





