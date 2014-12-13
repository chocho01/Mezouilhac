'use strict';

angular.module('angularify.semantic.modal', [])

    .directive('modal', function () {
        return {
            restrict: "E",
            replace: true,
            transclude: true,
            scope: {
                model: '=ngModel'
            },
            template: "<div class=\"ui dimmer page\" ng-class=\"{ active: model }\"  ng-click=\"close_modal()\">" +
            "<div class=\"ui large modal transition visible\" ng-transclude>" +
            "</div>" +
            "</div>",
            link: function (scope, element, attrs) {

            }
        }
    });