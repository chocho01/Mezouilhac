(function() {
  var app;

  app = angular.module('mezouilhac-contact', ['google-maps'.ns()]);

  app.config([
    "GoogleMapApiProvider".ns(), function(GoogleMapApi) {
      GoogleMapApi.configure({
        key: 'AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA',
        v: "3.17",
        libraries: "weather,geometry,visualization"
      });
    }
  ]);

  app.controller("contactCtrl", [
    "$scope", 'Logger'.ns(), "GoogleMapApi".ns(), "$http", function($scope, $log, GoogleMapApi, $http) {
      $scope.activites = [];
      GoogleMapApi.then(function(maps) {
        $scope.centerPos = new maps.LatLng(43.507480, 2.822272);
        $(".angular-google-map-container").height($(".map-footer").height());
        return $scope.activites.push({
          latitude: $scope.map.center.latitude,
          longitude: $scope.map.center.longitude,
          title: 'Home',
          id: 0
        });
      });
      angular.extend($scope, {
        map: {
          control: {},
          markerControl: {},
          windowControl: {},
          center: {
            latitude: 43.507480,
            longitude: 2.822272
          },
          zoom: 12,
          event: {}
        }
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=contact.js.map
