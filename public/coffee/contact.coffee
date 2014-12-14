app = angular.module 'mezouilhac-contact', ['google-maps'.ns(), 'angularjs-facebook-sdk']

app.config [
  "GoogleMapApiProvider".ns()
  (GoogleMapApi) ->
    GoogleMapApi.configure
      key: 'AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA',
      v: "3.17"
      libraries: "weather,geometry,visualization"
    return
]

app.controller "contactController", [
  "$scope"
  'Logger'.ns()
  "GoogleMapApi".ns()
  "$http"
  ($scope, $log, GoogleMapApi, $http) ->

    $scope.marker = []
    $scope.sendingEmail = false
    $scope.showResult =
      submit : false
      success : false

    GoogleMapApi.then (maps) ->
      $scope.centerPos = new maps.LatLng(43.507480, 2.822272)
      # Définis la hauteur du conteneur Gmap à la hauteur du block
      $(".angular-google-map-container").height($(".map-footer").height())

      $scope.marker.push
        latitude: $scope.map.center.latitude,
        longitude: $scope.map.center.longitude,
        title: 'Home'
        id: 0


    angular.extend $scope, {
      map :
        control: {}
        markerControl: {}
        windowControl: {}
        center:
          latitude: 43.507480
          longitude: 2.822272
        zoom: 12
        event: {}
    }

    $scope.sendEmail = (isValid)->
      if isValid
        $scope.sendingEmail = true
        $http.post '/contact', {mail: $scope.contact}
        .success (data, status, headers, config)->
          $scope.sendingEmail = false
          $scope.showResult =
            submit : true
            success : data
        .error (err)->
          $scope.sendingEmail = false
          $scope.showResult =
            submit : true
            success : false


    return



]