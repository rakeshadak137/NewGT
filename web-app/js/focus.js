/**
 * Created with IntelliJ IDEA.
 * User: Akshay
 * Date: 12/2/13
 * Time: 2:15 PM
 * To change this template use File | Settings | File Templates.
 */
angular.module('app', [])
    .directive('ngFocus', ['$parse', function ($parse) {
        return function (scope, element, attr) {
            var fn = $parse(attr['ngFocus']);
            element.on('focus', function (event) {
                scope.$apply(function () {
                    fn(scope, {$event: event});
                });
            });
        };
    }])
    .directive('ngBlur', ['$parse', function ($parse) {
        return function (scope, element, attr) {
            var fn = $parse(attr['ngBlur']);
            element.on('blur', function (event) {
                scope.$apply(function () {
                    fn(scope, {$event: event});
                });
            });
        };
    }])
    .directive('ngSubmit', ['$parse', function ($parse) {
        return function (scope, element, attr) {
            var fn = $parse(attr['ngSubmit']);
            element.on('submit', function (event) {
                scope.$apply(function () {
                    fn(scope, {$event: event});
                });
            });
        };
    }]);
