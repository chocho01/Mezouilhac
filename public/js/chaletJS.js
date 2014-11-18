(function() {
  var app;

  app = angular.module('mezouilhac-chalet', []);

  app.controller("chaletsCtrl", [
    "$scope", "$http", function($scope, $http) {
      $scope.chalets = [];
      $scope.chalet = null;
      $scope.gallery = {
        main: null
      };
      $scope.loadChalet = function(id) {
        return $http.get("/chalet/" + id).success(function(d) {
          return $scope.chalets[id] = d[0];
        });
      };
      $scope.openModal = function(id) {
        $('.ui.modal').modal('show');
        $scope.chalet = $scope.chalets[id];
        return $scope.gallery.main = $scope.chalet.image.principale;
      };
      return $scope.changeImg = function(img) {
        return $scope.gallery.main = img;
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=chaletJS.js.map
