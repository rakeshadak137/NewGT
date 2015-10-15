///**
// * Created with IntelliJ IDEA.
// * User: Admin
// * Date: 12/9/13
// * Time: 4:31 PM
// * To change this template use File | Settings | File Templates.
// */
//'use strict';
//
///**
// * A directive for adding google places autocomplete to a text box
// * google places autocomplete info: https://developers.google.com/maps/documentation/javascript/places
// *
// * Simple Usage:
// *
// * <input type="text" ng-autocomplete="result"/>
// *
// * creates the autocomplete text box and gives you access to the result
// *
// *   + `ng-autocomplete="result"`: specifies the directive, $scope.result will hold the textbox result
// *
// *
// * Advanced Usage:
// *
// * <input type="text" ng-autocomplete="result" details="details" options="options"/>
// *
// *   + `ng-autocomplete="result"`: specifies the directive, $scope.result will hold the textbox autocomplete result
// *
// *   + `details="details"`: $scope.details will hold the autocomplete's more detailed result; latlng. address components, etc.
// *
// *   + `options="options"`: options provided by the user that filter the autocomplete results
// *
// *      + options = {
// *           types: type,        string, values can be 'geocode', 'establishment', '(regions)', or '(cities)'
// *           bounds: bounds,     google maps LatLngBounds Object
// *           country: country    string, ISO 3166-1 Alpha-2 compatible country code. examples; 'ca', 'us', 'gb'
// *         }
// *
// *
// */
//
//angular.module("ngAutocomplete", [])
//    .directive('ngAutocomplete', function ($parse) {
//        debugger;
//        return {
//
//            scope: {
//                details: '=',
//                ngAutocomplete: '=',
//                options: '='
//            },
//
//            link: function (scope, element, attrs, model) {
//
//                //options for autocomplete
//                var opts
//
//                //convert options provided to opts
//                var initOpts = function () {
//                    opts = {}
//                    if (scope.options) {
//                        if (scope.options.types) {
//                            opts.types = []
//                            opts.types.push(scope.options.types)
//                        }
//                        if (scope.options.bounds) {
//                            opts.bounds = scope.options.bounds
//                        }
//                        if (scope.options.country) {
//                            opts.componentRestrictions = {
//                                country: scope.options.country
//                            }
//                        }
//                    }
//                }
//                initOpts()
//                debugger;
//                //create new autocomplete
//                //reinitializes on every change of the options provided
//                var newAutocomplete = function () {
//                    scope.gPlace = new google.maps.places.Autocomplete(element[0], opts);
//                    google.maps.event.addListener(scope.gPlace, 'place_changed', function () {
//                        scope.$apply(function () {
////              if (scope.details) {
//                            scope.details = scope.gPlace.getPlace();
////              }
//                            scope.ngAutocomplete = element.val();
//                        });
//                    })
//                }
//                newAutocomplete()
//
//                //watch options provided to directive
//                scope.watchOptions = function () {
//                    debugger;
//                    return scope.options
//                };
//                scope.$watch(scope.watchOptions, function () {
//                    initOpts()
//                    newAutocomplete()
//                    element[0].value = '';
//                    scope.ngAutocomplete = element.val();
//                }, true);
//            }
//        };
//    });

angular.module('app',['directives'])

.controller('PORController',['$scope',function($scope){}])

.config(['$httpProvider',function($httpProvider){
        $httpProvider.defaults.headers.common["X-Requested-with"] = 'XMLHttpRequest';
    }])

.filter('startFrom',function(){
        return function(input,start){
            start =+ start;
            return input.slice(start);
        }
    });