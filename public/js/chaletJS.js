(function() {
  var app;

  app = angular.module('mezouilhac-chalet', ['angularify.semantic.modal']);

  app.filter("imgFull", [
    function() {
      return function(img) {
        if (!img) {
          return null;
        }
        return img.substr(0, img.length - 8) + img.substr(img.length - 4, img.length);
      };
    }
  ]);

  app.controller("chaletsCtrl", [
    "$scope", "$http", function($scope, $http) {
      $scope.chalets = [];
      $scope.chalet = null;
      $scope.gallerie = null;
      $scope.loadChalet = function(id) {
        return $http.get("/api/chalets/" + id).success(function(d) {
          return $scope.chalets[id] = d;
        });
      };
      $scope.changeImg = function(img) {
        return $scope.gallerie = img;
      };
      $scope.open_modal = function(id) {
        $scope.show_modal = true;
        $scope.chalet = $scope.chalets[id];
        return $scope.gallerie = $scope.chalet.img_principale;
      };
      return $scope.close_modal = function() {
        return $scope.show_modal = false;
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=chaletJS.js.map
