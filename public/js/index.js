(function() {
  var app;

  app = angular.module('mezouilhac-home', ['ui.bootstrap']);

  app.controller("HomeController", [
    "$scope", function($scope) {
      $scope.myInterval = 5000;
      return $scope.slides = [
        {
          image: "/img/slider/slider1.jpg",
          text: "trop dla balle"
        }, {
          image: "/img/slider/slider2.jpg",
          text: "This is a caption"
        }
      ];
    }
  ]);

}).call(this);

//# sourceMappingURL=index.js.map
