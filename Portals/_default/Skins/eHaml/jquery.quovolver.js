(function($) {
    $.fn.quovolver = function(options) {
        var opts = $.extend({},
        $.fn.quovolver.defaults, options);
        return this.each(function() {
            var $this = $(this);
            var o = $.meta ? $.extend({},
            opts, $this.data()) : opts;
            $this.addClass("quovolve").css({
                position: "relative"
            }).wrap('<div class="quovolve-box"></div>');
            if (o.children) {
                var groupMethod = "find"
            } else {
                var groupMethod = "children"
            }
            var $box = $this.parent(".quovolve-box"),
            $items = $this[groupMethod](o.children),
            $active = 1,
            $total = $items.length;
            $items.hide().filter(":first").show();
            if (o.navPrev || o.navNext || o.navNum || o.navText) {
                o.navEnabled = true;
                var $nav = buildNav()
            } else {
                o.navEnabled = false
            }
            if (o.equalHeight) {
                equalHeight($items);
                $(window).resize(function() {
                    equalHeight($items);
                    $this.css("height", $($items[$active - 1]).outerHeight())
                })
            }
            if (o.autoPlay) {
                var $playID = autoPlay();
                if (o.stopOnHover) {
                    var $playID = stopAutoPlay($playID)
                } else {
                    if (o.pauseOnHover) {
                        var $playID = pauseAutoPlay($playID)
                    }
                }
            }
            function gotoItem(itemNumber) {
                if ($items.is(":animated") || $this.is(":animated")) {
                    return false
                }
                if ($box.is(":hidden")) {
                    return false
                }
                if (itemNumber < 1) {
                    itemNumber = $total
                } else {
                    if (itemNumber > $total) {
                        itemNumber = 1
                    }
                }
                var gotoData = {
                    current: $($items[$active - 1]),
                    upcoming: $($items[itemNumber - 1])
                };
                gotoData.currentHeight = getHiddenProperty(gotoData.current);
                gotoData.upcomingHeight = getHiddenProperty(gotoData.upcoming);
                gotoData.currentOuterHeight = getHiddenProperty(gotoData.current, "outerHeight");
                gotoData.upcomingOuterHeight = getHiddenProperty(gotoData.upcoming, "outerHeight");
                gotoData.currentWidth = getHiddenProperty(gotoData.current, "width");
                gotoData.upcomingWidth = getHiddenProperty(gotoData.upcoming, "width");
                gotoData.currentOuterWidth = getHiddenProperty(gotoData.current, "outerWidth");
                gotoData.upcomingOuterWidth = getHiddenProperty(gotoData.upcoming, "outerWidth");
                if (o.transition != "basic" && typeof o.transition == "string" && eval("typeof " + o.transition) == "function") {
                    eval(o.transition + "(gotoData)")
                } else {
                    basic(gotoData)
                }
                $active = itemNumber;
                updateNavNum($nav);
                updateNavText($nav);
                return false
            }
            function buildNav() {
                if (o.navPosition === "above" || o.navPosition === "both") {
                    $box.prepend('<div class="quovolve-nav quovolve-nav-above"></div>');
                    var nav = $box.find(".quovolve-nav")
                }
                if (o.navPosition === "below" || o.navPosition === "both") {
                    $box.append('<div class="quovolve-nav quovolve-nav-below"></div>');
                    var nav = $box.find(".quovolve-nav")
                }
                if (o.navPosition === "custom") {
                    if (o.navPositionCustom !== "" && $(o.navPositionCustom).length !== 0) {
                        $(o.navPositionCustom).append('<div class="quovolve-nav quovolve-nav-custom"></div>');
                        var nav = $(o.navPositionCustom).find(".quovolve-nav")
                    } else {
                        console.log("Error", "That custom selector did not return an element.")
                    }
                }
                if (o.navPrev) {
                    nav.append('<span class="nav-prev"><a href="#">' + o.navPrevText + "</a></span>")
                }
                if (o.navNext) {
                    nav.append('<span class="nav-next"><a href="#">' + o.navNextText + "</a></span>")
                }
                if (o.navNum) {
                    nav.append('<ol class="nav-numbers"></ol>');
                    for (var i = 1; i < ($total + 1); i++) {
                        nav.find(".nav-numbers").append('<li><a href="#item-' + i + '">' + i + "</a></li>")
                    }
                    updateNavNum(nav)
                }
                if (o.navText) {
                    nav.append('<span class="nav-text"></span>');
                    updateNavText(nav)
                }
                return nav
            }
            function getHiddenProperty(item, property) {
                if (!property) {
                    property = "height"
                }
                if ($(this).is(":hidden")) {
                    item.show().css({
                        position: "absolute",
                        visibility: "hidden",
                        display: "block"
                    })
                }
                var value = item[property]();
                if ($(this).is(":hidden")) {
                    item.hide().css({
                        position: "static",
                        visibility: "visible",
                        display: "none"
                    })
                }
                return value
            }
            function equalHeight(group) {
                var tallest = 0;
                group.height("auto");
                group.each(function() {
                    if ($(this).is(":visible")) {
                        var thisHeight = $(this).height()
                    } else {
                        var thisHeight = getHiddenProperty($(this))
                    }
                    if (thisHeight > tallest) {
                        tallest = thisHeight
                    }
                });
                group.height(tallest)
            }
            function updateNavNum(nav) {
                if (o.navEnabled) {
                    nav.find(".nav-numbers li").removeClass("active");
                    nav.find('.nav-numbers a[href="#item-' + $active + '"]').parent().addClass("active")
                }
            }
            function updateNavText(nav) {
                if (o.navEnabled) {
                    var content = o.navTextContent.replace("@a", $active).replace("@b", $total);
                    nav.find(".nav-text").text(content)
                }
            }
            function autoPlay() {
                $box.addClass("play");
                intervalID = setInterval(function() {
                    gotoItem($active + 1)
                },
                o.autoPlaySpeed);
                return intervalID
            }
            function pauseAutoPlay(intervalID) {
                if (o.stopAutoPlay !== true) {
                    $box.hover(function() {
                        $box.addClass("pause").removeClass("play");
                        clearInterval(intervalID)
                    },
                    function() {
                        $box.removeClass("pause").addClass("play");
                        clearInterval(intervalID);
                        intervalID = autoPlay()
                    });
                    return intervalID
                }
            }
            function stopAutoPlay(intervalID) {
                $box.hover(function() {
                    $box.addClass("stop").removeClass("play");
                    clearInterval(intervalID)
                },
                function() {});
                return intervalID
            }
            function basic(data) {
                $this.css("height", data.upcomingOuterHeight);
                data.current.hide();
                data.upcoming.show();
                if (o.equalHeight === false) {
                    $this.css("height", "auto")
                }
            }
            function fade(data) {
                $this.height(data.currentOuterHeight);
                data.current.fadeOut(o.transitionSpeed, 
                function() {
                    $this.animate({
                        height: data.upcomingOuterHeight
                    },
                    o.transitionSpeed, 
                    function() {
                        data.upcoming.fadeIn(o.transitionSpeed, 
                        function() {
                            $this.height("auto")
                        })
                    })
                })
            }
            $(".nav-prev a").click(function() {
                return gotoItem($active - 1)
            });
            $(".nav-next a").click(function() {
                return gotoItem($active + 1)
            });
            $(".nav-numbers a").click(function() {
                return gotoItem($(this).text())
            });
            $(this).bind("goto", 
            function(event, item) {
                gotoItem(item)
            })
        })
    };
    $.fn.quovolver.defaults = {
        children: "",
        transition: "fade",
        transitionSpeed: 300,
        autoPlay: true,
        autoPlaySpeed: 6000,
        pauseOnHover: true,
        stopOnHover: false,
        equalHeight: true,
        navPosition: "above",
        navPositionCustom: "",
        navPrev: false,
        navNext: false,
        navNum: false,
        navText: false,
        navPrevText: "Prev",
        navNextText: "Next",
        navTextContent: "@a / @b"
    }
})(jQuery);