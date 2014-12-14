(function() {
  var app;

  app = angular.module('mezouilhac-contact', ['google-maps'.ns(), 'angularjs-facebook-sdk']);

  app.config([
    "GoogleMapApiProvider".ns(), function(GoogleMapApi) {
      GoogleMapApi.configure({
        key: 'AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA',
        v: "3.17",
        libraries: "weather,geometry,visualization"
      });
    }
  ]);

  app.controller("contactController", [
    "$scope", 'Logger'.ns(), "GoogleMapApi".ns(), "$http", function($scope, $log, GoogleMapApi, $http) {
      $scope.marker = [];
      $scope.sendingEmail = false;
      $scope.showResult = {
        submit: false,
        success: false
      };
      GoogleMapApi.then(function(maps) {
        $scope.centerPos = new maps.LatLng(43.507480, 2.822272);
        $(".angular-google-map-container").height($(".map-footer").height());
        return $scope.marker.push({
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
      $scope.sendEmail = function(isValid) {
        if (isValid) {
          $scope.sendingEmail = true;
          return $http.post('/contact', {
            mail: $scope.contact
          }).success(function(data, status, headers, config) {
            $scope.sendingEmail = false;
            return $scope.showResult = {
              submit: true,
              success: data
            };
          }).error(function(err) {
            $scope.sendingEmail = false;
            return $scope.showResult = {
              submit: true,
              success: false
            };
          });
        }
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=contact.js.map
