(function() {
  var app;

  app = angular.module('mezouilhac-chalet', []);

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
      $scope.openModal = function(id) {
        $('.ui.modal').modal('show');
        $scope.chalet = $scope.chalets[id];
        return $scope.gallerie = $scope.chalet.img_principale;
      };
      return $scope.changeImg = function(img) {
        return $scope.gallerie = img;
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=chaletJS.js.map
