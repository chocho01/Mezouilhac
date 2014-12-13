(function() {
  var app, arrayObjectIndexOf;

  $(".activites").height($(window).height() - ($(window).height() / 4.5));

  $(".list-activites").height($(window).height() - ($(window).height() / 4.5));

  arrayObjectIndexOf = function(myArray, searchTerm, property) {
    var i, len;
    i = 0;
    len = myArray.length;
    while (i < len) {
      if (myArray[i][property] === searchTerm) {
        return i;
      }
      i++;
    }
    return -1;
  };

  app = angular.module('mezouilhac-gmap', ['google-maps'.ns()]);

  app.config([
    "GoogleMapApiProvider".ns(), function(GoogleMapApi) {
      GoogleMapApi.configure({
        key: 'AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA',
        v: "3.17",
        libraries: "weather,geometry,visualization"
      });
    }
  ]);

  app.controller("activiteCtrl", [
    "$scope", 'Logger'.ns(), "GoogleMapApi".ns(), "$http", function($scope, $log, GoogleMapApi, $http) {
      $log.doLog = true;
      $scope.activites = [];
      $scope.list_activites = [];
      $http.get('api/activites').success(function(d) {
        var activite, i, _i, _len, _results;
        $scope.list_activites = d;
        _results = [];
        for (i = _i = 0, _len = d.length; _i < _len; i = ++_i) {
          activite = d[i];
          _results.push($scope.activites.push({
            position: {
              latitude: activite.position.latitude,
              longitude: activite.position.longitude
            },
            id: activite._id,
            icon: "img/icon/" + activite.icon + "_marker.png",
            url: activite.url,
            img: "/img/icon/" + activite.icon + ".png",
            category: activite.categorie,
            title: activite.nom,
            adresse: activite.adresse,
            description: activite.description,
            showWindow: false,
            windowOptions: {
              visible: false
            }
          }));
        }
        return _results;
      });
      GoogleMapApi.then(function(maps) {
        $scope.centerPos = new maps.LatLng(43.507480, 2.822272);
        $(".angular-google-map-container").height($(".google-map").height());
        $scope.setOn = function(id_marker) {
          angular.forEach($scope.activites, function(marker) {
            marker.showWindow = false;
            if (marker.id === id_marker) {
              return marker.windowOptions = {
                visible: !marker.windowOptions.visible
              };
            } else {
              return marker.windowOptions = {
                visible: false
              };
            }
          });
        };
        return $scope.activites.push({
          position: {
            latitude: $scope.map.center.latitude,
            longitude: $scope.map.center.longitude
          },
          title: 'Home',
          id: 0,
          icon: "/img/icon/home.png",
          img: "/img/icon/home.png",
          title: "Mezouilhac",
          category: "Le gîte",
          adresse: "Riols, 34220",
          description: "Bienvenue à Mezouilhac !",
          windowOptions: {
            visible: false
          }
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

//# sourceMappingURL=activiteJS.js.map
