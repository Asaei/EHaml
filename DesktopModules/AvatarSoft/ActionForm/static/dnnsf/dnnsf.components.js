;

/*
 * DnnSF (DNN Sharp Foundation) - Reusable components
 */

angular.module('dnnsf.components', [ 'ngSanitize', 'textAngular' ])

// https://github.com/angular/angular.js/issues/4516
.directive('fixchange', [function () {

    return {
        replace: false,
        require: 'ngModel',
        scope: false,
        link: function (scope, element, attrs, ngModelCtrl) {
            element.on('change', function () {
                scope.$apply(function () {
                    if (attrs['type'] == 'radio') {
                        ngModelCtrl.$setViewValue(attrs['value']);
                    } else if (attrs['type'] == 'checkbox') {
                        ngModelCtrl.$setViewValue(element[0].checked);
                    }
                });
            });
        }
    };
}])

.directive('dnnsfRadiogroup', ['$compile', '$timeout', '$parse', function ($compile, $timeout, $parse) {
    return {
        restrict: 'A',
        scope: { model: '=', options: '=' },
        controller: function ($scope) {
            $scope.getLabel = function (option) {
                return typeof option.label != 'undefined' ? option.label : option;
            };
            $scope.getValue = function (option) {
                return typeof option.value != 'undefined' ? option.value : option;
            };
        },
        template:
            '<div class="btn-group" data-toggle="buttons">'+
                '<label class="btn btn-default btn-sm" data-ng-repeat="o in options" data-ng-class="{\'active\': model == getValue(o), \'btn-info\': model == getValue(o) }">' +
                    '<input type="radio" fixchange="" data-ng-model="$parent.model" value="{{getValue(o)}}" />{{getLabel(o)}}' +
                '</label>'+
            '</div>',
        replace: true
    };
}])

// fancy checkbox
.directive('dnnsfCheckbox', ['$compile', '$timeout', '$parse', function ($compile, $timeout, $parse) {
    return {
        restrict: 'A',
        scope: { ngModel: '=' },
        link: function (scope, element, attrs) {

            scope.changed = function (updateModel) {

                var checked = updateModel ? element.hasClass('active') : scope.ngModel;
                if (updateModel)
                    scope.ngModel = checked;

                if (checked)
                    element.addClass('btn-info active')
                else 
                    element.removeClass('btn-info')
            };
            scope.changed();

            element.click(function () {
                $timeout(function () {
                    scope.changed(true);
                });
            });

            scope.$watch('ngModel', function () {
                scope.changed();
            });
        }
    };
}])

.directive('dnnsfRegistration', ['$timeout', '$http', '$sce', 'dnnsf', 'dataSources', function ($timeout, $http, $sce, dnnsf, dataSources) {
    return {
        scope: true,
        templateUrl: 'static/dnnsf/tpl/licensing.html?v=' + dnnsf.env.version,
        link: function (scope, element, attrs) {
            
            scope.dnnsf = dnnsf;
            scope.$sce = $sce;

            // pull licensing from server
            $http({
                method: 'GET',
                url: dnnsf.adminApi('GetLicense'),
                cache: true
            }).success(function (data, status) {
                scope.license = data;
            });
        }
    };
}])

.directive('dnnsfCheckUpdate', ['$timeout', '$http', '$sce', 'dnnsf', 'dataSources', function ($timeout, $http, $sce, dnnsf, dataSources) {
    return {
        scope: true,
        templateUrl: 'static/dnnsf/tpl/check-update.html?v=' + dnnsf.env.version,
        link: function (scope, element, attrs) {

            scope.dnnsf = dnnsf;
            scope.$sce = $sce;

            // pull licensing from server
            $http({
                method: 'GET',
                url: 'http://www.dnnsharp.com/DesktopModules/DnnSharp/DnnApiEndpoint/Api.ashx?method=CurrentVersion&productCode=' + dnnsf.productCode,
                cache: true
            }).success(function (data, status) {
                scope.serverVersion = data;
            });
        }
    };
}])


// this is to get lists from the server and share them between settings (using the cache offered by the $http service)
// the array is for minification purposes, otherwise dependency injection will not work
.factory('dataSources', ['$http', 'dnnsf', function ($http, dnnsf) {
    return {
        callForData: function (settings, fnReady) {
            $http({
                method: 'GET',
                url: dnnsf.adminApi('GetData', settings),
                cache: true
            }).success(function (data, status) {
                fnReady && fnReady(data);
            });
        }
    };
}])

// the array is for minification purposes, otherwise dependency injection will not work
.directive('ctlDatasource', ['$compile', '$timeout', '$parse', 'dataSources', function ($compile, $timeout, $parse, dataSources) {
    return {
        scope: {
            pdef: '=ctlDatasource',
            model: '=updatemodel'
        },
        // we need this because the isolated scope is no longer avaiable in the html
        // https://github.com/angular/angular.js/issues/4845#issuecomment-28339616
        template: function (tElement, tAttrs) {
            return tElement.html();
        },
        link: function (scope, element, attrs) {
            $timeout(function () {
                if (scope.pdef.Settings['Items']) {
                    if (!scope.model)
                        scope.model = {};
                    var items = $.parseJSON(scope.pdef.Settings['Items']);
                    scope.items = [];
                    for (var i in items)
                        scope.items.push({ Value: i, Text: g_localize(items[i]) });
                } else {
                    dataSources.callForData(scope.pdef.Settings, function (data) { scope.items = data; });
                }
            });
        }
    };
}])


// the default cookieStore does not support path or expiration
.provider('$cookieStore', [function(){
    var self = this;
    self.defaultOptions = {};

    self.setDefaultOptions = function(options){
        self.defaultOptions = options;
    };

    self.$get = function(){
        return {
            get: function(name){
                var jsonCookie = $.cookie(name);
                if(jsonCookie){
                    return angular.fromJson(jsonCookie);
                }
            },
            put: function(name, value, options){
                options = $.extend({}, self.defaultOptions, options);
                $.cookie(name, angular.toJson(value), options);
            },
            remove: function(name, options){
                options = $.extend({}, self.defaultOptions, options);
                $.removeCookie(name, options);
            }
        };
    };
}])


// The purpose of this directive is to avoid infinite loops with nested templates.
// This happens because Angular is eager to compile nested directives even if they are not being used (for example, when they're in an IF statement).
.directive('dnnsfCalldirective', ['$compile', '$timeout', '$parse', '$sce', 'dnnsf', function ($compile, $timeout, $parse, $sce, dnnsf) {
    return {
        restrict: 'A',
        scope: true,
        replace: true,
        template: '',
        link: function (scope, element, attrs) {

            // pass all marked attributes to nested directive
            var tplEl = $('<div>');
            for (var i in element[0].attributes) {
                var name = element[0].attributes[i].name;
                if (name && name.indexOf('pass-') != -1)
                    tplEl.attr(name.replace('pass-', ''), element[0].attributes[i].value);
            }

            var tpl = $('<div>').append(tplEl).html();
            $compile(tpl)(scope, function (cloned, scope) {
                element.append(cloned);
            });
        }
    }
}])


.directive('dnnsfParams', ['$compile', '$timeout', '$parse', '$sce', 'dnnsf', function ($compile, $timeout, $parse, $sce, dnnsf) {
    return {
        restrict: 'A',
        // we need our scope to inherit from parent because some settings depend on that
        scope: true,
        //scope: {
        //    params: '=dnnsfParams',
        //    item: '=dnnsfItem'
        //},
        templateUrl: 'static/dnnsf/tpl/parameter.html?v=' + dnnsf.env.version,
        link: function (scope, element, attrs) {
            scope.localize = g_localize;
            scope.$sce = $sce;

            scope.params = scope.$eval(attrs.dnnsfParams);
            scope.item = scope.$eval(attrs.dnnsfItem);
            scope.$watch('item', function () {
                //scope.params = scope.fieldDefs[scope.item.InputTypeStr].Parameters;
                scope.params = scope.$eval(attrs.dnnsfParams);
            }, true);

            scope.switchExpressionField = function(paramId) {
                var wasExpr = scope.item.Parameters[paramId].IsExpression;
                if (wasExpr) {
                    scope.item.Parameters[paramId] = scope.item.Parameters[paramId].Expression.match(/^\[?(.*?)\]?$/)[1];
                    return;
                }

                if (typeof scope.item.Parameters[paramId] == "string")
                    scope.item.Parameters[paramId] = { Expression: '[' + scope.item.Parameters[paramId] + ']' };

                scope.item.Parameters[paramId].IsExpression = true;

            }
        }
    };
}])

.directive('dnnsfActions', ['$compile', '$timeout', '$parse', '$sce', 'dnnsf', function ($compile, $timeout, $parse, $sce, dnnsf) {
    return {
        restrict: 'A',
        scope: true,
        templateUrl: 'static/dnnsf/tpl/action-list.html?v=' + dnnsf.env.version,
        link: function (scope, element, attrs) {

            if (attrs.dnnsfActions) {
                scope.$watch(attrs.dnnsfActions, function () {
                    scope.actions = scope.$eval(attrs.dnnsfActions);
                });
            }

            scope.addAction = function (actionType) {
                var action = {
                    Id: -1,
                    $_uid: 'new' + new Date().getTime(),
                    EventName: scope.eventName,
                    Parameters: {},
                    ActionType: actionType.Id,
                    $_isOpen: true,
                    $_isLoaded: true,
                    $_isFocus: true,
                    $_field: scope.field
                };

                // copy defaults

                //$.each($.grep(actionType.Parameters, function (e) { return e.DefaultValue; }), function (intIndex, objValue) {
                //    var val = g_localizeMaybeJson(objValue.DefaultValue);
                //    action.Parameters[objValue.Id] = val;
                //});
                // This comes from a parent scope
                // TODO: move it into an utility function
                scope.initParameters(actionType, action);

                scope.actions.push(action);
            };

        }
    };
}])

// fancy file picker
.directive('dnnsfFilepicker', ['$compile', '$timeout', '$parse', '$sce', 'dnnsf', 'dataSources', function ($compile, $timeout, $parse, $sce, dnnsf, dataSources) {
    return {
        restrict: 'A',
        scope: { 
            ngModel: '='
        },
        templateUrl: 'static/dnnsf/tpl/filepicker.html?v=' + dnnsf.env.version,
        link: function (scope, element, attrs) {
            scope.dnnsf = dnnsf;
            scope.$sce = $sce;
            scope.singleSelect = attrs.dnnsfPickermode == 'Single';

            // load seleceted files
            scope.selectedFiles = scope.ngModel ? angular.copy(scope.ngModel) : [];

            scope.openFolder = function (folder) {

                scope.currentFolder = folder;

                // build breadcrumbs
                scope.breadcrumbs = [folder];
                var parent = folder.$_parent;
                while (parent) {
                    scope.breadcrumbs.splice(0, 0, parent);
                    parent = parent.$_parent;
                }

                // get data from the server
                scope.loading = true;
                dataSources.callForData({
                    dataSource: 'FilesInFolder',
                    folderId: folder.Value
                }, function (data) {
                    scope.files = data;

                    // mark selected files
                    var filesInFolder = $.grep(scope.selectedFiles, function (o, i) { return o.Filter == folder.Value; });
                    if (filesInFolder) {
                        var matches = 0
                        for (var i = 0; i < scope.files.length; i++) {
                            for (var j = 0; j < filesInFolder.length; j++) {
                                if (scope.files[i].Value == filesInFolder[j].Value) {
                                    scope.files[i].Selected = true;
                                    filesInFolder[j] = scope.files[i];
                                    matches++;
                                    break;
                                }
                            }

                            // stop if we already matched all selected files in this fodler
                            if (matches == filesInFolder.length)
                                break;
                        }

                        //$.each(scope.files, function (i, o) {
                        //    if ($.inArray(o, scope.selectedFiles) != -1)
                        //        o.Selected = true;
                        //});
                    }
                    scope.loading = false;
                });
            }

            scope.updateCount = function (folder, toAdd) {
                folder.selectedCount = (folder.selectedCount || 0) + toAdd;
                while (folder) {
                    folder.fullTreeSelectedCount = (folder.fullTreeSelectedCount || 0) + toAdd;
                    folder = folder.$_parent;
                }
            };

            scope.toggleSelectFile = function (file, bSelect) {

                file.Selected = bSelect;

                if (scope.singleSelect) {
                    if (scope.selectedFiles && scope.selectedFiles.length) {
                        scope.selectedFiles[0].Selected = false;

                        // reset counts for all folders
                        function resetCounts(folder) {
                            folder.selectedCount = folder.fullTreeSelectedCount = 0;
                            $.each(folder.Children, function (i, folder) {
                                resetCounts(folder);
                            });
                        }
                        resetCounts(scope.folder);
                    }
                    scope.selectedFiles = [];
                    if (bSelect)
                        scope.selectedFiles.push(file);
                } else {

                    // find it in the list - if found and currently unchecked, remove it
                    var found = false;
                    for (var i = 0; i < scope.selectedFiles.length; i++) {
                        if (scope.selectedFiles[i].Value == file.Value) {
                            if (!bSelect)
                                scope.selectedFiles.splice(i, 1);
                            found = true;
                            break;
                        }
                    }

                    // if not found and currently checked, push it to the list
                    if (!found && bSelect)
                        scope.selectedFiles.push(file);
                }

                // the easy way: file is in current folder
                scope.updateCount(scope.currentFolder, bSelect ? 1 : -1);

                // update all relevant folders for this file
                //scope.folder.selectedCount += bSelect ? 1 : -1;
            };

            scope.update = function () {
                scope.ngModel = angular.copy(scope.selectedFiles);
                scope.editing = false;
            };

            scope.loading = true;
            dataSources.callForData({ 
                dataSource: 'PortalFolders'
            }, function(data){
                scope.folder = data[0];
                scope.folder.$_isExpanded = true;

                // link child folders with their parents
                function linkChildren(parent) {

                    // update counts
                    var filesInFolder = $.grep(scope.selectedFiles, function (o2, i2) { return o2.Filter == parent.Value; });
                    if (filesInFolder.length)
                        scope.updateCount(parent, filesInFolder.length);

                    $.each(parent.Children, function (i, folder) {
                        // link parent
                        folder.$_parent = parent;

                        // also link all children
                        linkChildren(folder);
                    });
                }

                linkChildren(scope.folder);

                // open root folder
                scope.openFolder(scope.folder);

                scope.loading = false;
            });


        }
    };
}])


.directive('dnnsfBgPicker', ['$compile', '$timeout', '$parse', '$sce', 'dnnsf', 'dataSources', function ($compile, $timeout, $parse, $sce, dnnsf, dataSources) {
    return {
        restrict: 'A',
        scope: {
            model: '=ngModel'
        },
        templateUrl: 'static/dnnsf/tpl/bg-picker.html?v=' + dnnsf.env.version,
        link: function (scope, element, attrs) {

            scope.bg = {};

            dataSources.callForData({
                'DataSource': 'BgPatterns'
            }, function (data) {
                scope.patterns = data;
            });

            dataSources.callForData({
                'DataSource': 'BgImages'
            }, function (data) {
                scope.images = data;
            });

            scope.$watch('model', function () {
                dnnsf.log('model changed', scope.model);
                if (scope.model == null)
                    return;

                scope.bg.type = 'None';
                var css = dnnsf.parseCssBlock(scope.model);
                dnnsf.log(css);
                if (css['background-color']) {
                    scope.bg.type = 'Color';
                    scope.bg.color = css['background-color'];
                } else if (css['background-image']) {
                    var img = css['background-image'];
                    var myRegexp = /url\((.+)\)/g;
                    var match = myRegexp.exec(img);
                    img = match && match.length > 1 ? match[1] : img;

                    if (css['background-repeat'] == 'no-repeat') {
                        scope.bg.type = 'Image';
                        scope.bg.image = img;
                    } else {
                        scope.bg.type = 'Pattern';
                        scope.bg.pattern = img;
                    }
                }

            });
           

            // watch changes to recompute value
            scope.$watch('bg', function () {

                dnnsf.log('bg changed', scope.bg);
               
                switch (scope.bg.type) {
                    case 'None':
                        scope.model = '';
                        break;
                    case 'Color':
                        scope.model = 'background-color: ' + (scope.bg.color || 'transparent') + ';';
                        break;
                    case 'Pattern':
                        scope.model = 'background-image: url(' + scope.bg.pattern + '); background-repeat: repeat;';
                        break;
                    case 'Image':
                        scope.model = 'background-image: url(' + scope.bg.image + ');  background-repeat: no-repeat; background-size:cover';
                        break;
                }

            }, true);
        }
    };
}])



// select picker
.directive('bsSelectpicker', ['$compile', '$timeout', '$parse', function ($compile, $timeout, $parse) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            $timeout(function () {
                $(element).selectpicker();
            }, 200);
        }
    };
}])

.directive('uiShow', function () {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {

            var expression = attrs.uiShow;

            // optional slide duration.
            var duration = (attrs.uiDuration || "fast");
            var effect = (attrs.uiEffect || "slide");

            // check to see the default display of the element based on the link-time value of the model we are watching.
            if (!scope.$eval(expression)) {
                element.hide();
            }

            // watch the expression in scope context to when it changes - and adjust the visibility of the element accordingly.
            scope.$watch(
                expression,
                function (newValue, oldValue) {

                    // Ignore first-run values since we've already defaulted the element state.
                    if (newValue === oldValue)
                        return;

                    if (newValue) {
                        if (effect == 'fade') {
                            element.stop(true, true).fadeIn(duration);
                        } else {
                            element.stop(true, true).slideDown(duration);
                        }
                    } else {
                        if (effect == 'fade') {
                            element.stop(true, true).fadeOut(duration);
                        } else {
                            element.stop(true, true).slideUp(duration);
                        }
                    }

                }
            );

        }
    };
})

.directive('uiFocus', ['$timeout', function ($timeout) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            scope.$watch(attrs.uiFocus, function (value) {
                if (attrs.uiFocus) {
                    $timeout(function () {
                        $(element[0]).focus().select();
                    });
                }
            }, true);
        }
    };
}])

;