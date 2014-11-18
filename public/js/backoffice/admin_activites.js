(function() {
  var app;

  app = angular.module('mezouilhac-backoffice', []);

  app.controller("activiteCtrl", [
    "$scope", "$http", function($scope, $http) {
      $scope.list_activites = [];
      $scope.listIcon = ["arbre", "animaux"];
      $scope.init = function() {
        $scope.activite = {
          nom: null,
          position: {
            latitude: null,
            longitude: null
          },
          categorie: null,
          adresse: null,
          url: null,
          icon: 'arbre'
        };
        return $scope.action = 'add';
      };
      $scope.init();
      $scope.addActivite = function() {
        return $http.post('/admin/activites/add', $scope.activite).success(function(d) {
          $scope.message = d;
          if (d.ok) {
            return $scope.list_activites.push($scope.activite);
          }
        });
      };
      $scope.updateActivite = function(id) {
        return $http.post('/admin/activites/update/' + $scope.activite._id, $scope.activite).success(function(d) {
          $scope.message = d;
          return $scope.list_activites[$scope.getIndexInList($scope.activite)] = $scope.activite;
        });
      };
      $scope.deleteActivite = function(id) {
        return $http.post('/admin/activites/remove/' + $scope.activite._id).success(function(d) {
          $scope.message = d;
          return $scope.list_activites.splice($scope.getIndexInList($scope.activite), 1);
        });
      };
      $scope.getActivite = function(id) {
        return $http.get('/api/activites/' + id).success(function(d) {
          $scope.activite = d;
          return $scope.action = 'update';
        });
      };
      $scope.changeCategorie = function(choix_categorie) {
        return $scope.activite.categorie = choix_categorie;
      };
      $scope.changeIcon = function(icon) {
        return $scope.activite.icon = icon;
      };
      $http.get('/api/activites').success(function(d) {
        return $scope.list_activites = d;
      });
      $scope.getAdresse = function() {
        var lat, lon;
        lat = parseFloat($scope.activite.position.latitude);
        lon = parseFloat($scope.activite.position.longitude);
        return $http.get('https://maps.googleapis.com/maps/api/geocode/json?latlng=' + lat + ',' + lon + '6&key=AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA').success(function(d) {
          return $scope.activite.adresse = d.results[0].formatted_address;
        });
      };
      return $scope.getIndexInList = function(activite) {
        var i;
        i = 0;
        while (i < $scope.list_activites.length) {
          if ($scope.list_activites[i]['_id'] === activite._id) {
            return i;
          }
          i++;
        }
        return -1;
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=admin_activites.js.map
